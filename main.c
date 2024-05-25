#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <ifaddrs.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <stdint.h>
#include <stdbool.h>
#include <fcntl.h>
#include <errno.h>

#define BROADCAST_PORT 12345
#define TCP_PORT 54321
#define INITIAL_BATCH_SIZE 1000000
#define MAX_BATCH_SIZE 10000000
#define DISCOVERY_INTERVAL 1
#define PRIMES_FILE "primes.txt"
#define HANDSHAKE_PORT 54322

typedef struct {
    char ip[INET_ADDRSTRLEN];
    int cores;
    long ram;
    int execution_time;
    int batch_size;
} SlaveInfo;

SlaveInfo slaves[100];
int slave_count = 0;
pthread_mutex_t lock;
bool start_calculations = false;

void error(const char *msg) {
    perror(msg);
    exit(EXIT_FAILURE);
}

void print_cluster_info() {
    printf("\nCluster Information:\n");
    printf("Slave Name\tIP Address\tCores\tRAM\n");
    for (int i = 0; i < slave_count; ++i) {
        printf("Slave-%d\t%s\t%d\t%ld GB\n", i + 1, slaves[i].ip, slaves[i].cores, slaves[i].ram / (1024 * 1024 * 1024));
    }
    printf("Master\t\tN/A\t\t%d\t%ld GB\n", sysconf(_SC_NPROCESSORS_ONLN), (sysconf(_SC_PHYS_PAGES) * sysconf(_SC_PAGE_SIZE)) / (1024 * 1024 * 1024));
    printf("\n");
}

void get_ip_address(char *ip) {
    struct ifaddrs *ifaddr, *ifa;
    if (getifaddrs(&ifaddr) == -1) {
        error("getifaddrs");
    }
    for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
        if (ifa->ifa_addr == NULL) continue;
        if (ifa->ifa_addr->sa_family == AF_INET) {
            if (strcmp(ifa->ifa_name, "en0") == 0 || strcmp(ifa->ifa_name, "eth0") == 0) {
                struct sockaddr_in *sa = (struct sockaddr_in *) ifa->ifa_addr;
                inet_ntop(AF_INET, &sa->sin_addr, ip, INET_ADDRSTRLEN);
            }
        }
    }
    freeifaddrs(ifaddr);
}

void sieve_of_eratosthenes(int start, int end, int *primes, int *prime_count) {
    bool *sieve = malloc((end + 1) * sizeof(bool));
    if (sieve == NULL) {
        perror("Failed to allocate memory for sieve");
        return;
    }

    memset(sieve, true, (end + 1) * sizeof(bool));
    sieve[0] = sieve[1] = false;
    for (int num = 2; num * num <= end; ++num) {
        if (sieve[num]) {
            for (int i = num * num; i <= end; i += num) {
                sieve[i] = false;
            }
        }
    }
    *prime_count = 0;
    for (int num = start; num <= end; ++num) {
        if (sieve[num]) {
            primes[(*prime_count)++] = num;
        }
    }
    free(sieve);
}


void *broadcast_presence(void *arg) {
    int sockfd;
    struct sockaddr_in broadcast_addr;
    char message[256];
    char ip_address[INET_ADDRSTRLEN];
    get_ip_address(ip_address);
    int cores = sysconf(_SC_NPROCESSORS_ONLN);
    long ram = sysconf(_SC_PHYS_PAGES) * sysconf(_SC_PAGE_SIZE);

    snprintf(message, sizeof(message), "SLAVE:%s:%d:%ld", ip_address, cores, ram);
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        error("socket");
    }

    int broadcast = 1;
    if (setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof(broadcast)) < 0) {
        error("setsockopt");
    }

    memset(&broadcast_addr, 0, sizeof(broadcast_addr));
    broadcast_addr.sin_family = AF_INET;
    broadcast_addr.sin_port = htons(BROADCAST_PORT);
    broadcast_addr.sin_addr.s_addr = inet_addr("255.255.255.255");

    while (1) {
        sendto(sockfd, message, strlen(message), 0, (struct sockaddr *) &broadcast_addr, sizeof(broadcast_addr));
        sleep(DISCOVERY_INTERVAL);
    }

    close(sockfd);
    return NULL;
}

void handle_master_connection(int new_socket) {
    uint64_t start, end;

    // Reading start and end in a guaranteed format
    if (read(new_socket, &start, sizeof(start)) != sizeof(start) || read(new_socket, &end, sizeof(end)) != sizeof(end)) {
        perror("Error reading range");
        close(new_socket);
        return;
    }

    // Convert from network byte order to host byte order
    start = ntohll(start);
    end = ntohll(end);

    printf("Received range: %lu to %lu\n", start, end);

    struct timeval start_time, end_time;
    gettimeofday(&start_time, NULL);

    int *primes = malloc(INITIAL_BATCH_SIZE * sizeof(int));
    if (!primes) {
        perror("Failed to allocate memory for primes");
        close(new_socket);
        return;
    }

    int prime_count;
    sieve_of_eratosthenes(start, end, primes, &prime_count);

    gettimeofday(&end_time, NULL);
    long execution_time = ((end_time.tv_sec - start_time.tv_sec) * 1000) + ((end_time.tv_usec - start_time.tv_usec) / 1000);

    uint64_t result[2] = {prime_count, execution_time};

    // Convert from host byte order to network byte order before sending
    result[0] = htonll(result[0]);
    result[1] = htonll(result[1]);

    if (write(new_socket, result, sizeof(result)) != sizeof(result)) {
        perror("Error writing result");
    }

    free(primes);
    close(new_socket);
}



void *start_slave_server(void *arg) {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);

    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        error("socket failed");
    }

    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
        error("setsockopt");
    }

    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(TCP_PORT);

    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        error("bind failed");
    }

    if (listen(server_fd, 3) < 0) {
        error("listen");
    }

    printf("Slave server listening for master connections...\n");

    while (1) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) {
            perror("accept");
            continue;
        }
        pthread_t thread_id;
        pthread_create(&thread_id, NULL, (void *(*)(void *))handle_master_connection, (void *)(intptr_t)new_socket);
    }
}

void *respond_to_handshake(void *arg) {
    int sockfd;
    struct sockaddr_in servaddr, cliaddr;
    char buffer[1024];
    socklen_t len = sizeof(cliaddr);

    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        error("socket");
    }

    memset(&servaddr, 0, sizeof(servaddr));
    memset(&cliaddr, 0, sizeof(cliaddr));

    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(HANDSHAKE_PORT);

    if (bind(sockfd, (const struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        error("bind");
    }

    while (1) {
        int n = recvfrom(sockfd, buffer, 1024, 0, (struct sockaddr *)&cliaddr, &len);
        buffer[n] = '\0';

        if (strcmp(buffer, "HANDSHAKE") == 0) {
            char ip_address[INET_ADDRSTRLEN];
            get_ip_address(ip_address);
            int cores = sysconf(_SC_NPROCESSORS_ONLN);
            long ram = sysconf(_SC_PHYS_PAGES) * sysconf(_SC_PAGE_SIZE);
            char message[256];
            snprintf(message, sizeof(message), "SLAVE:%s:%d:%ld", ip_address, cores, ram);
            sendto(sockfd, message, strlen(message), 0, (struct sockaddr *) &cliaddr, len);
            printf("Responded to handshake with %s\n", inet_ntoa(cliaddr.sin_addr));
        }
    }

    close(sockfd);
    return NULL;
}

void *discover_slaves(void *arg) {
    int sockfd;
    struct sockaddr_in broadcast_addr;
    char buffer[1024];
    socklen_t len = sizeof(broadcast_addr);

    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        error("socket");
    }

    int broadcast = 1;
    if (setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof(broadcast)) < 0) {
        error("setsockopt");
    }

    memset(&broadcast_addr, 0, sizeof(broadcast_addr));
    broadcast_addr.sin_family = AF_INET;
    broadcast_addr.sin_port = htons(HANDSHAKE_PORT);
    broadcast_addr.sin_addr.s_addr = inet_addr("255.255.255.255");

    while (!start_calculations) {
        sendto(sockfd, "HANDSHAKE", strlen("HANDSHAKE"), 0, (struct sockaddr *) &broadcast_addr, sizeof(broadcast_addr));
        sleep(DISCOVERY_INTERVAL);

        int n = recvfrom(sockfd, buffer, 1024, MSG_DONTWAIT, (struct sockaddr *) &broadcast_addr, &len);
        if (n > 0) {
            buffer[n] = '\0';
            char *token = strtok(buffer, ":");
            if (strcmp(token, "SLAVE") == 0) {
                token = strtok(NULL, ":");
                char slave_ip[INET_ADDRSTRLEN];
                strcpy(slave_ip, token);
                token = strtok(NULL, ":");
                int cores = atoi(token);
                token = strtok(NULL, ":");
                long ram = atol(token);

                pthread_mutex_lock(&lock);
                bool exists = false;
                for (int i = 0; i < slave_count; ++i) {
                    if (strcmp(slaves[i].ip, slave_ip) == 0) {
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    strcpy(slaves[slave_count].ip, slave_ip);
                    slaves[slave_count].cores = cores;
                    slaves[slave_count].ram = ram;
                    slaves[slave_count].batch_size = INITIAL_BATCH_SIZE;
                    ++slave_count;
                    print_cluster_info();  // Print cluster info when a new slave is discovered
                }
                pthread_mutex_unlock(&lock);
            }
        }
    }

    close(sockfd);
    return NULL;
}

void *handle_user_input(void *arg) {
    char input;
    while (!start_calculations) {
        scanf(" %c", &input);
        if (input == 's') {
            pthread_mutex_lock(&lock);
            start_calculations = true;
            pthread_mutex_unlock(&lock);
        }
    }
    return NULL;
}

void assign_ranges_to_slave(const char *slave_ip, uint64_t start, uint64_t end) {
    int sockfd;
    struct sockaddr_in servaddr;
    uint64_t buffer[2] = {start, end};

    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        error("socket");
    }

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(TCP_PORT);

    if (inet_pton(AF_INET, slave_ip, &servaddr.sin_addr) <= 0) {
        perror("inet_pton");
        close(sockfd);
        return;
    }

    if (connect(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        perror("connect");
        close(sockfd);
        return;
    }

    send(sockfd, buffer, sizeof(buffer), 0);
    uint64_t result[2];
    read(sockfd, result, sizeof(result));

    close(sockfd);

    pthread_mutex_lock(&lock);
    for (int i = 0; i < slave_count; ++i) {
        if (strcmp(slaves[i].ip, slave_ip) == 0) {
            slaves[i].execution_time = result[1];
            if (result[1] < 1000 && slaves[i].batch_size < MAX_BATCH_SIZE) {
                slaves[i].batch_size = slaves[i].batch_size * 2 < MAX_BATCH_SIZE ? slaves[i].batch_size * 2 : MAX_BATCH_SIZE;
            } else if (result[1] > 2000) {
                slaves[i].batch_size = slaves[i].batch_size / 2 > INITIAL_BATCH_SIZE ? slaves[i].batch_size / 2 : INITIAL_BATCH_SIZE;
            }
        }
    }
    pthread_mutex_unlock(&lock);

    FILE *primes_file = fopen(PRIMES_FILE, "a");
    if (primes_file == NULL) {
        perror("fopen");
        return;
    }
    int primes[INITIAL_BATCH_SIZE];
    int prime_count;
    sieve_of_eratosthenes(start, end, primes, &prime_count);
    for (int i = 0; i < prime_count; ++i) {
        fprintf(primes_file, "%d\n", primes[i]);
    }
    fclose(primes_file);
}

void calculate_primes_master(uint64_t start, uint64_t end) {
    struct timeval start_time, end_time;
    gettimeofday(&start_time, NULL);

    int primes[INITIAL_BATCH_SIZE];
    int prime_count;
    sieve_of_eratosthenes(start, end, primes, &prime_count);

    gettimeofday(&end_time, NULL);
    long execution_time = ((end_time.tv_sec - start_time.tv_sec) * 1000) + ((end_time.tv_usec - start_time.tv_usec) / 1000);

    FILE *primes_file = fopen(PRIMES_FILE, "a");
    if (primes_file == NULL) {
        perror("fopen");
        return;
    }
    for (int i = 0; i < prime_count; ++i) {
        fprintf(primes_file, "%d\n", primes[i]);
    }
    fclose(primes_file);

    printf("Master found %d primes in range %lu to %lu in %ld milliseconds\n", prime_count, start, end, execution_time);
}

void distribute_workload(uint64_t current) {
    while (!start_calculations) {
        sleep(1);
    }

    while (1) {
        pthread_mutex_lock(&lock);
        for (int i = 0; i < slave_count; ++i) {
            uint64_t start = current;
            uint64_t end = current + slaves[i].batch_size - 1;
            if (end < start) {
                printf("Invalid range: start %lu, end %lu\n", start, end);
                pthread_mutex_unlock(&lock);
                return;
            }
            printf("Assigning range %lu to %lu to slave %s\n", start, end, slaves[i].ip);
            assign_ranges_to_slave(slaves[i].ip, start, end);
            current = end + 1;
        }
        pthread_mutex_unlock(&lock);

        printf("Master calculating range %lu to %lu\n", current, current + INITIAL_BATCH_SIZE - 1);
        calculate_primes_master(current, current + INITIAL_BATCH_SIZE - 1);
        current += INITIAL_BATCH_SIZE;
    }
}


void start_master() {
    printf("Starting master...\n");

    pthread_t discover_thread, input_thread;
    pthread_create(&discover_thread, NULL, discover_slaves, NULL);
    pthread_create(&input_thread, NULL, handle_user_input, NULL);

    uint64_t current = 2;
    distribute_workload(current);
}

void broadcast_and_serve_slave() {
    pthread_t broadcast_thread, handshake_thread, server_thread;
    pthread_create(&broadcast_thread, NULL, broadcast_presence, NULL);
    pthread_create(&handshake_thread, NULL, respond_to_handshake, NULL);
    pthread_create(&server_thread, NULL, start_slave_server, NULL);

    pthread_join(broadcast_thread, NULL);
    pthread_join(handshake_thread, NULL);
    pthread_join(server_thread, NULL);
}

int main() {
    pthread_mutex_init(&lock, NULL);

    int mode;
    printf("1. Master\n2. Slave\nChoose mode: ");
    scanf("%d", &mode);

    if (mode == 1) {
        start_master();
    } else if (mode == 2) {
        broadcast_and_serve_slave();
    } else {
        fprintf(stderr, "Invalid choice.\n");
        return 1;
    }

    pthread_mutex_destroy(&lock);
    return 0;
}
