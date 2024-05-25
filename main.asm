	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 5
	.globl	_error                          ; -- Begin function error
	.p2align	2
_error:                                 ; @error
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	ldr	x0, [sp, #8]
	bl	_perror
	mov	w0, #1
	bl	_exit
	.cfi_endproc
                                        ; -- End function
	.globl	_print_cluster_info             ; -- Begin function print_cluster_info
	.p2align	2
_print_cluster_info:                    ; @print_cluster_info
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, _slaves@GOTPAGE
	ldr	x8, [x8, _slaves@GOTPAGEOFF]
	stur	x8, [x29, #-16]                 ; 8-byte Folded Spill
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	adrp	x0, l_.str.1@PAGE
	add	x0, x0, l_.str.1@PAGEOFF
	bl	_printf
	stur	wzr, [x29, #-4]
	b	LBB1_1
LBB1_1:                                 ; =>This Inner Loop Header: Depth=1
	ldur	w8, [x29, #-4]
	adrp	x9, _slave_count@PAGE
	ldr	w9, [x9, _slave_count@PAGEOFF]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB1_4
	b	LBB1_2
LBB1_2:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldur	x8, [x29, #-16]                 ; 8-byte Folded Reload
	ldur	w9, [x29, #-4]
	add	w13, w9, #1
	ldursw	x9, [x29, #-4]
	mov	x12, #40
	mul	x10, x9, x12
	mov	x9, x8
	add	x11, x9, x10
	ldursw	x9, [x29, #-4]
	mul	x10, x9, x12
	mov	x9, x8
	add	x9, x9, x10
	ldr	w9, [x9, #16]
                                        ; implicit-def: $x10
	mov	x10, x9
	ldursw	x9, [x29, #-4]
	mul	x9, x9, x12
	add	x8, x8, x9
	ldr	x8, [x8, #24]
	mov	x9, #1073741824
	sdiv	x8, x8, x9
	mov	x9, sp
                                        ; implicit-def: $x12
	mov	x12, x13
	str	x12, [x9]
	str	x11, [x9, #8]
	str	x10, [x9, #16]
	str	x8, [x9, #24]
	adrp	x0, l_.str.2@PAGE
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_printf
	b	LBB1_3
LBB1_3:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldur	w8, [x29, #-4]
	add	w8, w8, #1
	stur	w8, [x29, #-4]
	b	LBB1_1
LBB1_4:
	mov	w0, #58
	bl	_sysconf
	stur	x0, [x29, #-24]                 ; 8-byte Folded Spill
	mov	w0, #200
	bl	_sysconf
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
	mov	w0, #29
	bl	_sysconf
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	mov	x9, x0
	ldur	x0, [x29, #-24]                 ; 8-byte Folded Reload
	mul	x8, x8, x9
	mov	x9, #1073741824
	sdiv	x8, x8, x9
	mov	x9, sp
	str	x0, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.3@PAGE
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	adrp	x0, l_.str.4@PAGE
	add	x0, x0, l_.str.4@PAGEOFF
	bl	_printf
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_ip_address                 ; -- Begin function get_ip_address
	.p2align	2
_get_ip_address:                        ; @get_ip_address
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	add	x0, sp, #16
	bl	_getifaddrs
	adds	w8, w0, #1
	cset	w8, ne
	tbnz	w8, #0, LBB2_2
	b	LBB2_1
LBB2_1:
	adrp	x0, l_.str.5@PAGE
	add	x0, x0, l_.str.5@PAGEOFF
	bl	_error
	b	LBB2_2
LBB2_2:
	ldr	x8, [sp, #16]
	str	x8, [sp, #8]
	b	LBB2_3
LBB2_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB2_13
	b	LBB2_4
LBB2_4:                                 ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #24]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB2_6
	b	LBB2_5
LBB2_5:                                 ;   in Loop: Header=BB2_3 Depth=1
	b	LBB2_12
LBB2_6:                                 ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #24]
	ldrb	w8, [x8, #1]
	subs	w8, w8, #2
	cset	w8, ne
	tbnz	w8, #0, LBB2_11
	b	LBB2_7
LBB2_7:                                 ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [sp, #8]
	ldr	x0, [x8, #8]
	adrp	x1, l_.str.6@PAGE
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, eq
	tbnz	w8, #0, LBB2_9
	b	LBB2_8
LBB2_8:                                 ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [sp, #8]
	ldr	x0, [x8, #8]
	adrp	x1, l_.str.7@PAGE
	add	x1, x1, l_.str.7@PAGEOFF
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB2_10
	b	LBB2_9
LBB2_9:                                 ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [sp, #8]
	ldr	x8, [x8, #24]
	str	x8, [sp]
	ldr	x8, [sp]
	add	x1, x8, #4
	ldur	x2, [x29, #-8]
	mov	w0, #2
	mov	w3, #16
	bl	_inet_ntop
	b	LBB2_10
LBB2_10:                                ;   in Loop: Header=BB2_3 Depth=1
	b	LBB2_11
LBB2_11:                                ;   in Loop: Header=BB2_3 Depth=1
	b	LBB2_12
LBB2_12:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	x8, [sp, #8]
	ldr	x8, [x8]
	str	x8, [sp, #8]
	b	LBB2_3
LBB2_13:
	ldr	x0, [sp, #16]
	bl	_freeifaddrs
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_sieve_of_eratosthenes          ; -- Begin function sieve_of_eratosthenes
	.p2align	2
_sieve_of_eratosthenes:                 ; @sieve_of_eratosthenes
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	w0, [x29, #-4]
	stur	w1, [x29, #-8]
	stur	x2, [x29, #-16]
	str	x3, [sp, #24]
	ldur	w8, [x29, #-8]
	add	w9, w8, #1
                                        ; implicit-def: $x8
	mov	x8, x9
	sxtw	x8, w8
	lsr	x0, x8, #0
	bl	_malloc
	str	x0, [sp, #16]
	ldr	x8, [sp, #16]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB3_2
	b	LBB3_1
LBB3_1:
	adrp	x0, l_.str.8@PAGE
	add	x0, x0, l_.str.8@PAGEOFF
	bl	_perror
	b	LBB3_19
LBB3_2:
	ldr	x0, [sp, #16]
	ldur	w8, [x29, #-8]
	mov	w1, #1
	add	w9, w8, #1
                                        ; implicit-def: $x8
	mov	x8, x9
	sxtw	x8, w8
	lsr	x2, x8, #0
	mov	x3, #-1
	bl	___memset_chk
	ldr	x8, [sp, #16]
	strb	wzr, [x8, #1]
	ldr	x8, [sp, #16]
	strb	wzr, [x8]
	mov	w8, #2
	str	w8, [sp, #12]
	b	LBB3_3
LBB3_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_6 Depth 2
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #12]
	mul	w8, w8, w9
	ldur	w9, [x29, #-8]
	subs	w8, w8, w9
	cset	w8, gt
	tbnz	w8, #0, LBB3_12
	b	LBB3_4
LBB3_4:                                 ;   in Loop: Header=BB3_3 Depth=1
	ldr	x8, [sp, #16]
	ldrsw	x9, [sp, #12]
	add	x8, x8, x9
	ldrb	w8, [x8]
	tbz	w8, #0, LBB3_10
	b	LBB3_5
LBB3_5:                                 ;   in Loop: Header=BB3_3 Depth=1
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #12]
	mul	w8, w8, w9
	str	w8, [sp, #8]
	b	LBB3_6
LBB3_6:                                 ;   Parent Loop BB3_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w8, [sp, #8]
	ldur	w9, [x29, #-8]
	subs	w8, w8, w9
	cset	w8, gt
	tbnz	w8, #0, LBB3_9
	b	LBB3_7
LBB3_7:                                 ;   in Loop: Header=BB3_6 Depth=2
	ldr	x8, [sp, #16]
	ldrsw	x9, [sp, #8]
	add	x8, x8, x9
	strb	wzr, [x8]
	b	LBB3_8
LBB3_8:                                 ;   in Loop: Header=BB3_6 Depth=2
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #8]
	add	w8, w8, w9
	str	w8, [sp, #8]
	b	LBB3_6
LBB3_9:                                 ;   in Loop: Header=BB3_3 Depth=1
	b	LBB3_10
LBB3_10:                                ;   in Loop: Header=BB3_3 Depth=1
	b	LBB3_11
LBB3_11:                                ;   in Loop: Header=BB3_3 Depth=1
	ldr	w8, [sp, #12]
	add	w8, w8, #1
	str	w8, [sp, #12]
	b	LBB3_3
LBB3_12:
	ldr	x8, [sp, #24]
	str	wzr, [x8]
	ldur	w8, [x29, #-4]
	str	w8, [sp, #4]
	b	LBB3_13
LBB3_13:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #4]
	ldur	w9, [x29, #-8]
	subs	w8, w8, w9
	cset	w8, gt
	tbnz	w8, #0, LBB3_18
	b	LBB3_14
LBB3_14:                                ;   in Loop: Header=BB3_13 Depth=1
	ldr	x8, [sp, #16]
	ldrsw	x9, [sp, #4]
	add	x8, x8, x9
	ldrb	w8, [x8]
	tbz	w8, #0, LBB3_16
	b	LBB3_15
LBB3_15:                                ;   in Loop: Header=BB3_13 Depth=1
	ldr	w8, [sp, #4]
	ldur	x9, [x29, #-16]
	ldr	x12, [sp, #24]
	ldrsw	x10, [x12]
	mov	x11, x10
	add	w11, w11, #1
	str	w11, [x12]
	str	w8, [x9, x10, lsl #2]
	b	LBB3_16
LBB3_16:                                ;   in Loop: Header=BB3_13 Depth=1
	b	LBB3_17
LBB3_17:                                ;   in Loop: Header=BB3_13 Depth=1
	ldr	w8, [sp, #4]
	add	w8, w8, #1
	str	w8, [sp, #4]
	b	LBB3_13
LBB3_18:
	ldr	x0, [sp, #16]
	bl	_free
	b	LBB3_19
LBB3_19:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_broadcast_presence             ; -- Begin function broadcast_presence
	.p2align	2
_broadcast_presence:                    ; @broadcast_presence
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #432
	.cfi_def_cfa_offset 432
	stp	x28, x27, [sp, #400]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #416]            ; 16-byte Folded Spill
	add	x29, sp, #416
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	sub	x8, x29, #48
	str	x8, [sp, #48]                   ; 8-byte Folded Spill
	str	x0, [x8, #24]
	add	x0, sp, #96
	str	x0, [sp, #56]                   ; 8-byte Folded Spill
	bl	_get_ip_address
	mov	w0, #58
	bl	_sysconf
	mov	x8, x0
	str	w8, [sp, #92]
	mov	w0, #200
	bl	_sysconf
	str	x0, [sp, #64]                   ; 8-byte Folded Spill
	mov	w0, #29
	bl	_sysconf
	ldr	x11, [sp, #56]                  ; 8-byte Folded Reload
	mov	x8, x0
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
	mul	x8, x0, x8
	str	x8, [sp, #80]
	ldr	w8, [sp, #92]
                                        ; implicit-def: $x10
	mov	x10, x8
	ldr	x8, [sp, #80]
	mov	x9, sp
	str	x11, [x9]
	str	x10, [x9, #8]
	str	x8, [x9, #16]
	add	x0, sp, #112
	mov	x3, #256
	mov	x1, x3
	mov	w2, #0
	str	w2, [sp, #72]                   ; 4-byte Folded Spill
	adrp	x4, l_.str.9@PAGE
	add	x4, x4, l_.str.9@PAGEOFF
	bl	___snprintf_chk
	ldr	w2, [sp, #72]                   ; 4-byte Folded Reload
	mov	w1, #2
	mov	x0, x1
	bl	_socket
	stur	w0, [x29, #-28]
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB4_2
	b	LBB4_1
LBB4_1:
	adrp	x0, l_.str.10@PAGE
	add	x0, x0, l_.str.10@PAGEOFF
	bl	_error
	b	LBB4_2
LBB4_2:
	add	x3, sp, #76
	mov	w8, #1
	str	w8, [sp, #76]
	ldur	w0, [x29, #-28]
	mov	w1, #65535
	mov	w2, #32
	mov	w4, #4
	bl	_setsockopt
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB4_4
	b	LBB4_3
LBB4_3:
	adrp	x0, l_.str.11@PAGE
	add	x0, x0, l_.str.11@PAGEOFF
	bl	_error
	b	LBB4_4
LBB4_4:
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	str	xzr, [x8]
	str	xzr, [x8, #8]
	mov	w8, #2
	sturb	w8, [x29, #-47]
	mov	w8, #14640
	sturh	w8, [x29, #-46]
	adrp	x0, l_.str.12@PAGE
	add	x0, x0, l_.str.12@PAGEOFF
	bl	_inet_addr
	stur	w0, [x29, #-44]
	b	LBB4_5
LBB4_5:                                 ; =>This Inner Loop Header: Depth=1
	ldur	w8, [x29, #-28]
	str	w8, [sp, #44]                   ; 4-byte Folded Spill
	add	x0, sp, #112
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
	bl	_strlen
	ldr	x1, [sp, #32]                   ; 8-byte Folded Reload
	mov	x2, x0
	ldr	w0, [sp, #44]                   ; 4-byte Folded Reload
	mov	w3, #0
	sub	x4, x29, #48
	mov	w5, #16
	bl	_sendto
	mov	w0, #1
	bl	_sleep
	b	LBB4_5
	.cfi_endproc
                                        ; -- End function
	.globl	_handle_master_connection       ; -- Begin function handle_master_connection
	.p2align	2
_handle_master_connection:              ; @handle_master_connection
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #176
	.cfi_def_cfa_offset 176
	stp	x29, x30, [sp, #160]            ; 16-byte Folded Spill
	add	x29, sp, #160
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	stur	w0, [x29, #-28]
	ldur	w0, [x29, #-28]
	sub	x1, x29, #40
	mov	x2, #8
	bl	_read
	subs	x8, x0, #8
	cset	w8, ne
	tbnz	w8, #0, LBB5_2
	b	LBB5_1
LBB5_1:
	ldur	w0, [x29, #-28]
	sub	x1, x29, #48
	mov	x2, #8
	bl	_read
	subs	x8, x0, #8
	cset	w8, eq
	tbnz	w8, #0, LBB5_3
	b	LBB5_2
LBB5_2:
	adrp	x0, l_.str.13@PAGE
	add	x0, x0, l_.str.13@PAGEOFF
	bl	_perror
	ldur	w0, [x29, #-28]
	bl	_close
	b	LBB5_16
LBB5_3:
	b	LBB5_4
LBB5_4:
	ldur	x0, [x29, #-40]
	bl	__OSSwapInt64
	str	x0, [sp, #48]                   ; 8-byte Folded Spill
	b	LBB5_5
LBB5_5:
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	stur	x8, [x29, #-40]
	b	LBB5_6
LBB5_6:
	ldur	x0, [x29, #-48]
	bl	__OSSwapInt64
	str	x0, [sp, #40]                   ; 8-byte Folded Spill
	b	LBB5_7
LBB5_7:
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	stur	x8, [x29, #-48]
	ldur	x10, [x29, #-40]
	ldur	x8, [x29, #-48]
	mov	x9, sp
	str	x10, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.14@PAGE
	add	x0, x0, l_.str.14@PAGEOFF
	bl	_printf
	sub	x0, x29, #64
	mov	x1, #0
	bl	_gettimeofday
	mov	x0, #2304
	movk	x0, #61, lsl #16
	bl	_malloc
	str	x0, [sp, #72]
	ldr	x8, [sp, #72]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB5_9
	b	LBB5_8
LBB5_8:
	adrp	x0, l_.str.15@PAGE
	add	x0, x0, l_.str.15@PAGEOFF
	bl	_perror
	ldur	w0, [x29, #-28]
	bl	_close
	b	LBB5_16
LBB5_9:
	ldur	x8, [x29, #-40]
	mov	x0, x8
	ldur	x8, [x29, #-48]
	mov	x1, x8
	ldr	x2, [sp, #72]
	add	x3, sp, #68
	bl	_sieve_of_eratosthenes
	add	x0, sp, #80
	mov	x1, #0
	bl	_gettimeofday
	ldr	x8, [sp, #80]
	ldur	x9, [x29, #-64]
	subs	x8, x8, x9
	mov	x9, #1000
	mul	x8, x8, x9
	ldr	w9, [sp, #88]
	ldur	w10, [x29, #-56]
	subs	w9, w9, w10
	mov	w10, #1000
	sdiv	w9, w9, w10
	add	x8, x8, w9, sxtw
	str	x8, [sp, #56]
	ldrsw	x8, [sp, #68]
	stur	x8, [x29, #-24]
	ldr	x8, [sp, #56]
	stur	x8, [x29, #-16]
	b	LBB5_10
LBB5_10:
	ldur	x0, [x29, #-24]
	bl	__OSSwapInt64
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
	b	LBB5_11
LBB5_11:
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	stur	x8, [x29, #-24]
	b	LBB5_12
LBB5_12:
	ldur	x0, [x29, #-16]
	bl	__OSSwapInt64
	str	x0, [sp, #24]                   ; 8-byte Folded Spill
	b	LBB5_13
LBB5_13:
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	sub	x1, x29, #24
	stur	x8, [x29, #-16]
	ldur	w0, [x29, #-28]
	mov	x2, #16
	bl	_write
	subs	x8, x0, #16
	cset	w8, eq
	tbnz	w8, #0, LBB5_15
	b	LBB5_14
LBB5_14:
	adrp	x0, l_.str.16@PAGE
	add	x0, x0, l_.str.16@PAGEOFF
	bl	_perror
	b	LBB5_15
LBB5_15:
	ldr	x0, [sp, #72]
	bl	_free
	ldur	w0, [x29, #-28]
	bl	_close
	b	LBB5_16
LBB5_16:
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB5_18
	b	LBB5_17
LBB5_17:
	bl	___stack_chk_fail
LBB5_18:
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	add	sp, sp, #176
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function _OSSwapInt64
__OSSwapInt64:                          ; @_OSSwapInt64
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	rev	x0, x8
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_start_slave_server             ; -- Begin function start_slave_server
	.p2align	2
_start_slave_server:                    ; @start_slave_server
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	mov	w1, #1
	str	w1, [sp, #12]
	mov	w8, #16
	str	w8, [sp, #8]
	mov	w0, #2
	mov	w2, #0
	bl	_socket
	stur	w0, [x29, #-12]
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_2
	b	LBB7_1
LBB7_1:
	adrp	x0, l_.str.17@PAGE
	add	x0, x0, l_.str.17@PAGEOFF
	bl	_error
	b	LBB7_2
LBB7_2:
	ldur	w0, [x29, #-12]
	mov	w1, #65535
	mov	w4, #4
	mov	x2, x4
	add	x3, sp, #12
	bl	_setsockopt
	subs	w8, w0, #0
	cset	w8, eq
	tbnz	w8, #0, LBB7_4
	b	LBB7_3
LBB7_3:
	adrp	x0, l_.str.11@PAGE
	add	x0, x0, l_.str.11@PAGEOFF
	bl	_error
	b	LBB7_4
LBB7_4:
	add	x1, sp, #16
	mov	w8, #2
	strb	w8, [sp, #17]
	str	wzr, [sp, #20]
	mov	w8, #12756
	strh	w8, [sp, #18]
	ldur	w0, [x29, #-12]
	mov	w2, #16
	bl	_bind
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB7_6
	b	LBB7_5
LBB7_5:
	adrp	x0, l_.str.18@PAGE
	add	x0, x0, l_.str.18@PAGEOFF
	bl	_error
	b	LBB7_6
LBB7_6:
	ldur	w0, [x29, #-12]
	mov	w1, #3
	bl	_listen
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB7_8
	b	LBB7_7
LBB7_7:
	adrp	x0, l_.str.19@PAGE
	add	x0, x0, l_.str.19@PAGEOFF
	bl	_error
	b	LBB7_8
LBB7_8:
	adrp	x0, l_.str.20@PAGE
	add	x0, x0, l_.str.20@PAGEOFF
	bl	_printf
	b	LBB7_9
LBB7_9:                                 ; =>This Inner Loop Header: Depth=1
	ldur	w0, [x29, #-12]
	add	x1, sp, #16
	add	x2, sp, #8
	bl	_accept
	stur	w0, [x29, #-16]
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB7_11
	b	LBB7_10
LBB7_10:                                ;   in Loop: Header=BB7_9 Depth=1
	adrp	x0, l_.str.21@PAGE
	add	x0, x0, l_.str.21@PAGEOFF
	bl	_perror
	b	LBB7_9
LBB7_11:                                ;   in Loop: Header=BB7_9 Depth=1
	ldursw	x3, [x29, #-16]
	mov	x0, sp
	mov	x1, #0
	adrp	x2, _handle_master_connection@PAGE
	add	x2, x2, _handle_master_connection@PAGEOFF
	bl	_pthread_create
	b	LBB7_9
	.cfi_endproc
                                        ; -- End function
	.globl	_respond_to_handshake           ; -- Begin function respond_to_handshake
	.p2align	2
_respond_to_handshake:                  ; @respond_to_handshake
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	sub	sp, sp, #1440
	stur	x0, [x29, #-24]
	mov	w8, #16
	str	w8, [sp, #364]
	mov	w1, #2
	mov	x0, x1
	mov	w2, #0
	bl	_socket
	stur	w0, [x29, #-28]
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB8_2
	b	LBB8_1
LBB8_1:
	adrp	x0, l_.str.10@PAGE
	add	x0, x0, l_.str.10@PAGEOFF
	bl	_error
	b	LBB8_2
LBB8_2:
	sub	x1, x29, #48
	stur	xzr, [x29, #-48]
	stur	xzr, [x29, #-40]
	stur	xzr, [x29, #-64]
	stur	xzr, [x29, #-56]
	mov	w8, #2
	sturb	w8, [x29, #-47]
	stur	wzr, [x29, #-44]
	mov	w8, #13012
	sturh	w8, [x29, #-46]
	ldur	w0, [x29, #-28]
	mov	w2, #16
	bl	_bind
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB8_4
	b	LBB8_3
LBB8_3:
	adrp	x0, l_.str.22@PAGE
	add	x0, x0, l_.str.22@PAGEOFF
	bl	_error
	b	LBB8_4
LBB8_4:
	b	LBB8_5
LBB8_5:                                 ; =>This Inner Loop Header: Depth=1
	ldur	w0, [x29, #-28]
	add	x1, sp, #368
	str	x1, [sp, #64]                   ; 8-byte Folded Spill
	mov	x2, #1024
	mov	w3, #0
	sub	x4, x29, #64
	add	x5, sp, #364
	bl	_recvfrom
	mov	x8, x0
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [sp, #360]
	ldrsw	x9, [sp, #360]
	mov	x8, x0
	add	x8, x8, x9
	strb	wzr, [x8]
	adrp	x1, l_.str.23@PAGE
	add	x1, x1, l_.str.23@PAGEOFF
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB8_7
	b	LBB8_6
LBB8_6:                                 ;   in Loop: Header=BB8_5 Depth=1
	add	x0, sp, #344
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
	bl	_get_ip_address
	mov	w0, #58
	bl	_sysconf
	mov	x8, x0
	str	w8, [sp, #340]
	mov	w0, #200
	bl	_sysconf
	str	x0, [sp, #40]                   ; 8-byte Folded Spill
	mov	w0, #29
	bl	_sysconf
	ldr	x11, [sp, #32]                  ; 8-byte Folded Reload
	mov	x8, x0
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	mul	x8, x0, x8
	str	x8, [sp, #328]
	ldr	w8, [sp, #340]
                                        ; implicit-def: $x10
	mov	x10, x8
	ldr	x8, [sp, #328]
	mov	x9, sp
	str	x11, [x9]
	str	x10, [x9, #8]
	str	x8, [x9, #16]
	add	x0, sp, #72
	str	x0, [sp, #48]                   ; 8-byte Folded Spill
	mov	x3, #256
	mov	x1, x3
	mov	w2, #0
	str	w2, [sp, #56]                   ; 4-byte Folded Spill
	adrp	x4, l_.str.9@PAGE
	add	x4, x4, l_.str.9@PAGEOFF
	bl	___snprintf_chk
	ldr	x0, [sp, #48]                   ; 8-byte Folded Reload
	ldur	w8, [x29, #-28]
	str	w8, [sp, #60]                   ; 4-byte Folded Spill
	bl	_strlen
	ldr	x1, [sp, #48]                   ; 8-byte Folded Reload
	ldr	w3, [sp, #56]                   ; 4-byte Folded Reload
	mov	x2, x0
	ldr	w0, [sp, #60]                   ; 4-byte Folded Reload
	ldr	w5, [sp, #364]
	sub	x4, x29, #64
	bl	_sendto
	ldur	w8, [x29, #-60]
	mov	x0, x8
	bl	_inet_ntoa
	mov	x8, sp
	str	x0, [x8]
	adrp	x0, l_.str.24@PAGE
	add	x0, x0, l_.str.24@PAGEOFF
	bl	_printf
	b	LBB8_7
LBB8_7:                                 ;   in Loop: Header=BB8_5 Depth=1
	b	LBB8_5
	.cfi_endproc
                                        ; -- End function
	.globl	_discover_slaves                ; -- Begin function discover_slaves
	.p2align	2
_discover_slaves:                       ; @discover_slaves
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	sub	sp, sp, #1168
	adrp	x8, _slaves@GOTPAGE
	ldr	x8, [x8, _slaves@GOTPAGEOFF]
	str	x8, [sp, #40]                   ; 8-byte Folded Spill
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #96]
	mov	w8, #16
	str	w8, [sp, #88]
	mov	w1, #2
	mov	x0, x1
	mov	w2, #0
	bl	_socket
	str	w0, [sp, #92]
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB9_2
	b	LBB9_1
LBB9_1:
	adrp	x0, l_.str.10@PAGE
	add	x0, x0, l_.str.10@PAGEOFF
	bl	_error
	b	LBB9_2
LBB9_2:
	add	x3, sp, #84
	mov	w8, #1
	str	w8, [sp, #84]
	ldr	w0, [sp, #92]
	mov	w1, #65535
	mov	w2, #32
	mov	w4, #4
	bl	_setsockopt
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB9_4
	b	LBB9_3
LBB9_3:
	adrp	x0, l_.str.11@PAGE
	add	x0, x0, l_.str.11@PAGEOFF
	bl	_error
	b	LBB9_4
LBB9_4:
	stur	xzr, [x29, #-40]
	stur	xzr, [x29, #-32]
	mov	w8, #2
	sturb	w8, [x29, #-39]
	mov	w8, #13012
	sturh	w8, [x29, #-38]
	adrp	x0, l_.str.12@PAGE
	add	x0, x0, l_.str.12@PAGEOFF
	bl	_inet_addr
	stur	w0, [x29, #-36]
	b	LBB9_5
LBB9_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB9_9 Depth 2
	adrp	x8, _start_calculations@PAGE
	ldrb	w8, [x8, _start_calculations@PAGEOFF]
	tbnz	w8, #0, LBB9_19
	b	LBB9_6
LBB9_6:                                 ;   in Loop: Header=BB9_5 Depth=1
	ldr	w0, [sp, #92]
	adrp	x1, l_.str.23@PAGE
	add	x1, x1, l_.str.23@PAGEOFF
	mov	x2, #9
	mov	w3, #0
	sub	x4, x29, #40
	str	x4, [sp, #32]                   ; 8-byte Folded Spill
	mov	w5, #16
	bl	_sendto
	mov	w0, #1
	bl	_sleep
	ldr	x4, [sp, #32]                   ; 8-byte Folded Reload
	ldr	w0, [sp, #92]
	add	x1, sp, #120
	mov	x2, #1024
	mov	w3, #128
	add	x5, sp, #88
	bl	_recvfrom
	mov	x8, x0
	str	w8, [sp, #80]
	ldr	w8, [sp, #80]
	subs	w8, w8, #0
	cset	w8, le
	tbnz	w8, #0, LBB9_18
	b	LBB9_7
LBB9_7:                                 ;   in Loop: Header=BB9_5 Depth=1
	ldrsw	x9, [sp, #80]
	add	x0, sp, #120
	mov	x8, x0
	add	x8, x8, x9
	strb	wzr, [x8]
	adrp	x1, l_.str.25@PAGE
	add	x1, x1, l_.str.25@PAGEOFF
	bl	_strtok
	str	x0, [sp, #72]
	ldr	x0, [sp, #72]
	adrp	x1, l_.str.26@PAGE
	add	x1, x1, l_.str.26@PAGEOFF
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB9_17
	b	LBB9_8
LBB9_8:                                 ;   in Loop: Header=BB9_5 Depth=1
	mov	x0, #0
	str	x0, [sp, #24]                   ; 8-byte Folded Spill
	adrp	x1, l_.str.25@PAGE
	add	x1, x1, l_.str.25@PAGEOFF
	str	x1, [sp, #16]                   ; 8-byte Folded Spill
	bl	_strtok
	str	x0, [sp, #72]
	ldr	x1, [sp, #72]
	add	x0, sp, #104
	mov	x2, #16
	bl	___strcpy_chk
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #24]                   ; 8-byte Folded Reload
	bl	_strtok
	str	x0, [sp, #72]
	ldr	x0, [sp, #72]
	bl	_atoi
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	mov	x8, x0
	ldr	x0, [sp, #24]                   ; 8-byte Folded Reload
	str	w8, [sp, #68]
	bl	_strtok
	str	x0, [sp, #72]
	ldr	x0, [sp, #72]
	bl	_atol
	str	x0, [sp, #56]
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	bl	_pthread_mutex_lock
	strb	wzr, [sp, #55]
	str	wzr, [sp, #48]
	b	LBB9_9
LBB9_9:                                 ;   Parent Loop BB9_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w8, [sp, #48]
	adrp	x9, _slave_count@PAGE
	ldr	w9, [x9, _slave_count@PAGEOFF]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB9_14
	b	LBB9_10
LBB9_10:                                ;   in Loop: Header=BB9_9 Depth=2
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x9, [sp, #48]
	mov	x10, #40
	mul	x9, x9, x10
	add	x0, x8, x9
	add	x1, sp, #104
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB9_12
	b	LBB9_11
LBB9_11:                                ;   in Loop: Header=BB9_5 Depth=1
	mov	w8, #1
	strb	w8, [sp, #55]
	b	LBB9_14
LBB9_12:                                ;   in Loop: Header=BB9_9 Depth=2
	b	LBB9_13
LBB9_13:                                ;   in Loop: Header=BB9_9 Depth=2
	ldr	w8, [sp, #48]
	add	w8, w8, #1
	str	w8, [sp, #48]
	b	LBB9_9
LBB9_14:                                ;   in Loop: Header=BB9_5 Depth=1
	ldrb	w8, [sp, #55]
	tbnz	w8, #0, LBB9_16
	b	LBB9_15
LBB9_15:                                ;   in Loop: Header=BB9_5 Depth=1
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	adrp	x9, _slave_count@PAGE
	str	x9, [sp, #8]                    ; 8-byte Folded Spill
	ldrsw	x9, [x9, _slave_count@PAGEOFF]
	mov	x10, #40
	str	x10, [sp]                       ; 8-byte Folded Spill
	mul	x9, x9, x10
	add	x0, x8, x9
	add	x1, sp, #104
	mov	x2, #16
	bl	___strcpy_chk
	ldr	x11, [sp]                       ; 8-byte Folded Reload
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldr	x9, [sp, #8]                    ; 8-byte Folded Reload
	ldr	w10, [sp, #68]
	ldrsw	x12, [x9, _slave_count@PAGEOFF]
	mul	x13, x12, x11
	mov	x12, x8
	add	x12, x12, x13
	str	w10, [x12, #16]
	ldr	x10, [sp, #56]
	ldrsw	x12, [x9, _slave_count@PAGEOFF]
	mul	x13, x12, x11
	mov	x12, x8
	add	x12, x12, x13
	str	x10, [x12, #24]
	ldrsw	x10, [x9, _slave_count@PAGEOFF]
	mul	x10, x10, x11
	add	x10, x8, x10
	mov	w8, #16960
	movk	w8, #15, lsl #16
	str	w8, [x10, #36]
	ldr	w8, [x9, _slave_count@PAGEOFF]
	add	w8, w8, #1
	str	w8, [x9, _slave_count@PAGEOFF]
	bl	_print_cluster_info
	b	LBB9_16
LBB9_16:                                ;   in Loop: Header=BB9_5 Depth=1
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	bl	_pthread_mutex_unlock
	b	LBB9_17
LBB9_17:                                ;   in Loop: Header=BB9_5 Depth=1
	b	LBB9_18
LBB9_18:                                ;   in Loop: Header=BB9_5 Depth=1
	b	LBB9_5
LBB9_19:
	ldr	w0, [sp, #92]
	bl	_close
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB9_21
	b	LBB9_20
LBB9_20:
	bl	___stack_chk_fail
LBB9_21:
	mov	x0, #0
	add	sp, sp, #1168
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_handle_user_input              ; -- Begin function handle_user_input
	.p2align	2
_handle_user_input:                     ; @handle_user_input
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	b	LBB10_1
LBB10_1:                                ; =>This Inner Loop Header: Depth=1
	adrp	x8, _start_calculations@PAGE
	ldrb	w8, [x8, _start_calculations@PAGEOFF]
	tbnz	w8, #0, LBB10_5
	b	LBB10_2
LBB10_2:                                ;   in Loop: Header=BB10_1 Depth=1
	mov	x9, sp
	sub	x8, x29, #9
	str	x8, [x9]
	adrp	x0, l_.str.27@PAGE
	add	x0, x0, l_.str.27@PAGEOFF
	bl	_scanf
	ldursb	w8, [x29, #-9]
	subs	w8, w8, #115
	cset	w8, ne
	tbnz	w8, #0, LBB10_4
	b	LBB10_3
LBB10_3:                                ;   in Loop: Header=BB10_1 Depth=1
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	bl	_pthread_mutex_lock
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	mov	w8, #1
	adrp	x9, _start_calculations@PAGE
	strb	w8, [x9, _start_calculations@PAGEOFF]
	bl	_pthread_mutex_unlock
	b	LBB10_4
LBB10_4:                                ;   in Loop: Header=BB10_1 Depth=1
	b	LBB10_1
LBB10_5:
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_assign_ranges_to_slave         ; -- Begin function assign_ranges_to_slave
	.p2align	2
_assign_ranges_to_slave:                ; @assign_ranges_to_slave
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	mov	w9, #2464
	movk	w9, #61, lsl #16
	adrp	x16, ___chkstk_darwin@GOTPAGE
	ldr	x16, [x16, ___chkstk_darwin@GOTPAGEOFF]
	blr	x16
	sub	sp, sp, #976, lsl #12           ; =3997696
	sub	sp, sp, #2464
	sub	x9, x29, #72
	str	x9, [sp, #32]                   ; 8-byte Folded Spill
	adrp	x8, _slaves@GOTPAGE
	ldr	x8, [x8, _slaves@GOTPAGEOFF]
	str	x8, [sp, #40]                   ; 8-byte Folded Spill
	mov	w8, #38528
	movk	w8, #152, lsl #16
	str	w8, [sp, #52]                   ; 4-byte Folded Spill
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #96]
	str	x1, [sp, #88]
	str	x2, [sp, #80]
	ldr	x8, [sp, #88]
	str	x8, [x9, #16]
	ldr	x8, [sp, #80]
	str	x8, [x9, #24]
	mov	w0, #2
	mov	w1, #1
	mov	w2, #0
	bl	_socket
	str	w0, [sp, #76]
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB11_2
	b	LBB11_1
LBB11_1:
	adrp	x0, l_.str.10@PAGE
	add	x0, x0, l_.str.10@PAGEOFF
	bl	_error
	b	LBB11_2
LBB11_2:
	ldr	x10, [sp, #32]                  ; 8-byte Folded Reload
	sub	x8, x29, #40
	str	xzr, [x10, #32]
	str	xzr, [x10, #40]
	mov	w9, #2
	strb	w9, [x10, #33]
	mov	w9, #12756
	strh	w9, [x10, #34]
	ldr	x1, [sp, #96]
	add	x2, x8, #4
	mov	w0, #2
	bl	_inet_pton
	subs	w8, w0, #0
	cset	w8, gt
	tbnz	w8, #0, LBB11_4
	b	LBB11_3
LBB11_3:
	adrp	x0, l_.str.28@PAGE
	add	x0, x0, l_.str.28@PAGEOFF
	bl	_perror
	ldr	w0, [sp, #76]
	bl	_close
	b	LBB11_31
LBB11_4:
	ldr	w0, [sp, #76]
	sub	x1, x29, #40
	mov	w2, #16
	bl	_connect
	subs	w8, w0, #0
	cset	w8, ge
	tbnz	w8, #0, LBB11_6
	b	LBB11_5
LBB11_5:
	adrp	x0, l_.str.29@PAGE
	add	x0, x0, l_.str.29@PAGEOFF
	bl	_perror
	ldr	w0, [sp, #76]
	bl	_close
	b	LBB11_31
LBB11_6:
	ldr	w0, [sp, #76]
	sub	x1, x29, #56
	mov	x2, #16
	str	x2, [sp, #24]                   ; 8-byte Folded Spill
	mov	w3, #0
	bl	_send
	ldr	x2, [sp, #24]                   ; 8-byte Folded Reload
	ldr	w0, [sp, #76]
	sub	x1, x29, #72
	bl	_read
	ldr	w0, [sp, #76]
	bl	_close
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	bl	_pthread_mutex_lock
	str	wzr, [sp, #72]
	b	LBB11_7
LBB11_7:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #72]
	adrp	x9, _slave_count@PAGE
	ldr	w9, [x9, _slave_count@PAGEOFF]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB11_24
	b	LBB11_8
LBB11_8:                                ;   in Loop: Header=BB11_7 Depth=1
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x9, [sp, #72]
	mov	x10, #40
	mul	x9, x9, x10
	add	x0, x8, x9
	ldr	x1, [sp, #96]
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB11_22
	b	LBB11_9
LBB11_9:                                ;   in Loop: Header=BB11_7 Depth=1
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
	ldr	x9, [x8, #8]
	ldrsw	x11, [sp, #72]
	mov	x12, #40
	mul	x11, x11, x12
	add	x10, x10, x11
                                        ; kill: def $w9 killed $w9 killed $x9
	str	w9, [x10, #32]
	ldr	x8, [x8, #8]
	subs	x8, x8, #1000
	cset	w8, hs
	tbnz	w8, #0, LBB11_15
	b	LBB11_10
LBB11_10:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	w9, [sp, #52]                   ; 4-byte Folded Reload
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x10, [sp, #72]
	mov	x11, #40
	mul	x10, x10, x11
	add	x8, x8, x10
	ldr	w8, [x8, #36]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB11_15
	b	LBB11_11
LBB11_11:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	w8, [sp, #52]                   ; 4-byte Folded Reload
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x10, [sp, #72]
	mov	x11, #40
	mul	x10, x10, x11
	add	x9, x9, x10
	ldr	w9, [x9, #36]
	subs	w8, w8, w9, lsl #1
	cset	w8, le
	tbnz	w8, #0, LBB11_13
	b	LBB11_12
LBB11_12:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x9, [sp, #72]
	mov	x10, #40
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	w8, [x8, #36]
	lsl	w8, w8, #1
	str	w8, [sp, #20]                   ; 4-byte Folded Spill
	b	LBB11_14
LBB11_13:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	w8, [sp, #52]                   ; 4-byte Folded Reload
	str	w8, [sp, #20]                   ; 4-byte Folded Spill
	b	LBB11_14
LBB11_14:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	ldr	w8, [sp, #20]                   ; 4-byte Folded Reload
	ldrsw	x10, [sp, #72]
	mov	x11, #40
	mul	x10, x10, x11
	add	x9, x9, x10
	str	w8, [x9, #36]
	b	LBB11_21
LBB11_15:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	ldr	x8, [x8, #8]
	subs	x8, x8, #2000
	cset	w8, ls
	tbnz	w8, #0, LBB11_20
	b	LBB11_16
LBB11_16:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x9, [sp, #72]
	mov	x10, #40
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	w8, [x8, #36]
	mov	w9, #2
	sdiv	w8, w8, w9
	mov	w9, #16960
	movk	w9, #15, lsl #16
	subs	w8, w8, w9
	cset	w8, le
	tbnz	w8, #0, LBB11_18
	b	LBB11_17
LBB11_17:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	ldrsw	x9, [sp, #72]
	mov	x10, #40
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	w8, [x8, #36]
	mov	w9, #2
	sdiv	w8, w8, w9
	str	w8, [sp, #16]                   ; 4-byte Folded Spill
	b	LBB11_19
LBB11_18:                               ;   in Loop: Header=BB11_7 Depth=1
	mov	w8, #16960
	movk	w8, #15, lsl #16
	str	w8, [sp, #16]                   ; 4-byte Folded Spill
	b	LBB11_19
LBB11_19:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	x9, [sp, #40]                   ; 8-byte Folded Reload
	ldr	w8, [sp, #16]                   ; 4-byte Folded Reload
	ldrsw	x10, [sp, #72]
	mov	x11, #40
	mul	x10, x10, x11
	add	x9, x9, x10
	str	w8, [x9, #36]
	b	LBB11_20
LBB11_20:                               ;   in Loop: Header=BB11_7 Depth=1
	b	LBB11_21
LBB11_21:                               ;   in Loop: Header=BB11_7 Depth=1
	b	LBB11_22
LBB11_22:                               ;   in Loop: Header=BB11_7 Depth=1
	b	LBB11_23
LBB11_23:                               ;   in Loop: Header=BB11_7 Depth=1
	ldr	w8, [sp, #72]
	add	w8, w8, #1
	str	w8, [sp, #72]
	b	LBB11_7
LBB11_24:
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	bl	_pthread_mutex_unlock
	adrp	x0, l_.str.30@PAGE
	add	x0, x0, l_.str.30@PAGEOFF
	adrp	x1, l_.str.31@PAGE
	add	x1, x1, l_.str.31@PAGEOFF
	bl	_fopen
	str	x0, [sp, #64]
	ldr	x8, [sp, #64]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB11_26
	b	LBB11_25
LBB11_25:
	adrp	x0, l_.str.32@PAGE
	add	x0, x0, l_.str.32@PAGEOFF
	bl	_perror
	b	LBB11_31
LBB11_26:
	ldr	x8, [sp, #88]
	mov	x0, x8
	ldr	x8, [sp, #80]
	mov	x1, x8
	add	x2, sp, #104
	add	x3, sp, #60
	bl	_sieve_of_eratosthenes
	str	wzr, [sp, #56]
	b	LBB11_27
LBB11_27:                               ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #56]
	ldr	w9, [sp, #60]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB11_30
	b	LBB11_28
LBB11_28:                               ;   in Loop: Header=BB11_27 Depth=1
	ldr	x0, [sp, #64]
	ldrsw	x9, [sp, #56]
	add	x8, sp, #104
	ldr	w9, [x8, x9, lsl #2]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x1, l_.str.33@PAGE
	add	x1, x1, l_.str.33@PAGEOFF
	bl	_fprintf
	b	LBB11_29
LBB11_29:                               ;   in Loop: Header=BB11_27 Depth=1
	ldr	w8, [sp, #56]
	add	w8, w8, #1
	str	w8, [sp, #56]
	b	LBB11_27
LBB11_30:
	ldr	x0, [sp, #64]
	bl	_fclose
	b	LBB11_31
LBB11_31:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB11_33
	b	LBB11_32
LBB11_32:
	bl	___stack_chk_fail
LBB11_33:
	add	sp, sp, #976, lsl #12           ; =3997696
	add	sp, sp, #2464
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_calculate_primes_master        ; -- Begin function calculate_primes_master
	.p2align	2
_calculate_primes_master:               ; @calculate_primes_master
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	mov	w9, #2432
	movk	w9, #61, lsl #16
	adrp	x16, ___chkstk_darwin@GOTPAGE
	ldr	x16, [x16, ___chkstk_darwin@GOTPAGEOFF]
	blr	x16
	sub	sp, sp, #976, lsl #12           ; =3997696
	sub	sp, sp, #2432
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #112]
	str	x1, [sp, #104]
	add	x0, sp, #88
	mov	x1, #0
	str	x1, [sp, #32]                   ; 8-byte Folded Spill
	bl	_gettimeofday
	ldr	x8, [sp, #112]
	mov	x0, x8
	ldr	x8, [sp, #104]
	mov	x1, x8
	add	x2, sp, #120
	add	x3, sp, #68
	bl	_sieve_of_eratosthenes
	ldr	x1, [sp, #32]                   ; 8-byte Folded Reload
	add	x0, sp, #72
	bl	_gettimeofday
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
	subs	x8, x8, x9
	mov	x9, #1000
	mul	x8, x8, x9
	ldr	w9, [sp, #80]
	ldr	w10, [sp, #96]
	subs	w9, w9, w10
	mov	w10, #1000
	sdiv	w9, w9, w10
	add	x8, x8, w9, sxtw
	str	x8, [sp, #56]
	adrp	x0, l_.str.30@PAGE
	add	x0, x0, l_.str.30@PAGEOFF
	adrp	x1, l_.str.31@PAGE
	add	x1, x1, l_.str.31@PAGEOFF
	bl	_fopen
	str	x0, [sp, #48]
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB12_2
	b	LBB12_1
LBB12_1:
	adrp	x0, l_.str.32@PAGE
	add	x0, x0, l_.str.32@PAGEOFF
	bl	_perror
	b	LBB12_7
LBB12_2:
	str	wzr, [sp, #44]
	b	LBB12_3
LBB12_3:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #44]
	ldr	w9, [sp, #68]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB12_6
	b	LBB12_4
LBB12_4:                                ;   in Loop: Header=BB12_3 Depth=1
	ldr	x0, [sp, #48]
	ldrsw	x9, [sp, #44]
	add	x8, sp, #120
	ldr	w9, [x8, x9, lsl #2]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x1, l_.str.33@PAGE
	add	x1, x1, l_.str.33@PAGEOFF
	bl	_fprintf
	b	LBB12_5
LBB12_5:                                ;   in Loop: Header=BB12_3 Depth=1
	ldr	w8, [sp, #44]
	add	w8, w8, #1
	str	w8, [sp, #44]
	b	LBB12_3
LBB12_6:
	ldr	x0, [sp, #48]
	bl	_fclose
	ldr	w8, [sp, #68]
                                        ; implicit-def: $x12
	mov	x12, x8
	ldr	x11, [sp, #112]
	ldr	x10, [sp, #104]
	ldr	x8, [sp, #56]
	mov	x9, sp
	str	x12, [x9]
	str	x11, [x9, #8]
	str	x10, [x9, #16]
	str	x8, [x9, #24]
	adrp	x0, l_.str.34@PAGE
	add	x0, x0, l_.str.34@PAGEOFF
	bl	_printf
	b	LBB12_7
LBB12_7:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB12_9
	b	LBB12_8
LBB12_8:
	bl	___stack_chk_fail
LBB12_9:
	add	sp, sp, #976, lsl #12           ; =3997696
	add	sp, sp, #2432
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_distribute_workload            ; -- Begin function distribute_workload
	.p2align	2
_distribute_workload:                   ; @distribute_workload
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, _lock@GOTPAGE
	ldr	x8, [x8, _lock@GOTPAGEOFF]
	str	x8, [sp, #40]                   ; 8-byte Folded Spill
	mov	x8, #16960
	movk	x8, #15, lsl #16
	str	x8, [sp, #48]                   ; 8-byte Folded Spill
	adrp	x8, _slaves@GOTPAGE
	ldr	x8, [x8, _slaves@GOTPAGEOFF]
	stur	x8, [x29, #-40]                 ; 8-byte Folded Spill
	stur	x0, [x29, #-8]
	b	LBB13_1
LBB13_1:                                ; =>This Inner Loop Header: Depth=1
	adrp	x8, _start_calculations@PAGE
	ldrb	w8, [x8, _start_calculations@PAGEOFF]
	tbnz	w8, #0, LBB13_3
	b	LBB13_2
LBB13_2:                                ;   in Loop: Header=BB13_1 Depth=1
	mov	w0, #1
	bl	_sleep
	b	LBB13_1
LBB13_3:
	b	LBB13_4
LBB13_4:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB13_5 Depth 2
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	bl	_pthread_mutex_lock
	stur	wzr, [x29, #-12]
	b	LBB13_5
LBB13_5:                                ;   Parent Loop BB13_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldur	w8, [x29, #-12]
	adrp	x9, _slave_count@PAGE
	ldr	w9, [x9, _slave_count@PAGEOFF]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB13_10
	b	LBB13_6
LBB13_6:                                ;   in Loop: Header=BB13_5 Depth=2
	ldur	x9, [x29, #-40]                 ; 8-byte Folded Reload
	ldur	x8, [x29, #-8]
	stur	x8, [x29, #-24]
	ldur	x8, [x29, #-8]
	ldursw	x10, [x29, #-12]
	mov	x11, #40
	mul	x10, x10, x11
	add	x9, x9, x10
	ldrsw	x9, [x9, #36]
	add	x8, x8, x9
	subs	x8, x8, #1
	stur	x8, [x29, #-32]
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-24]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB13_8
	b	LBB13_7
LBB13_7:
	ldur	x10, [x29, #-24]
	ldur	x8, [x29, #-32]
	mov	x9, sp
	str	x10, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.35@PAGE
	add	x0, x0, l_.str.35@PAGEOFF
	bl	_printf
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	bl	_pthread_mutex_unlock
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB13_8:                                ;   in Loop: Header=BB13_5 Depth=2
	ldur	x8, [x29, #-40]                 ; 8-byte Folded Reload
	ldur	x11, [x29, #-24]
	ldur	x10, [x29, #-32]
	ldursw	x9, [x29, #-12]
	mov	x12, #40
	str	x12, [sp, #32]                  ; 8-byte Folded Spill
	mul	x9, x9, x12
	add	x8, x8, x9
	mov	x9, sp
	str	x11, [x9]
	str	x10, [x9, #8]
	str	x8, [x9, #16]
	adrp	x0, l_.str.36@PAGE
	add	x0, x0, l_.str.36@PAGEOFF
	bl	_printf
	ldr	x10, [sp, #32]                  ; 8-byte Folded Reload
	ldur	x8, [x29, #-40]                 ; 8-byte Folded Reload
	ldursw	x9, [x29, #-12]
	mul	x9, x9, x10
	add	x0, x8, x9
	ldur	x1, [x29, #-24]
	ldur	x2, [x29, #-32]
	bl	_assign_ranges_to_slave
	ldur	x8, [x29, #-32]
	add	x8, x8, #1
	stur	x8, [x29, #-8]
	b	LBB13_9
LBB13_9:                                ;   in Loop: Header=BB13_5 Depth=2
	ldur	w8, [x29, #-12]
	add	w8, w8, #1
	stur	w8, [x29, #-12]
	b	LBB13_5
LBB13_10:                               ;   in Loop: Header=BB13_4 Depth=1
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	bl	_pthread_mutex_unlock
	ldr	x9, [sp, #48]                   ; 8-byte Folded Reload
	ldur	x10, [x29, #-8]
	ldur	x8, [x29, #-8]
	add	x8, x8, x9
	subs	x8, x8, #1
	mov	x9, sp
	str	x10, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.37@PAGE
	add	x0, x0, l_.str.37@PAGEOFF
	bl	_printf
	ldr	x9, [sp, #48]                   ; 8-byte Folded Reload
	ldur	x0, [x29, #-8]
	ldur	x8, [x29, #-8]
	add	x8, x8, x9
	subs	x1, x8, #1
	bl	_calculate_primes_master
	ldr	x9, [sp, #48]                   ; 8-byte Folded Reload
	ldur	x8, [x29, #-8]
	add	x8, x8, x9
	stur	x8, [x29, #-8]
	b	LBB13_4
	.cfi_endproc
                                        ; -- End function
	.globl	_start_master                   ; -- Begin function start_master
	.p2align	2
_start_master:                          ; @start_master
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x0, l_.str.38@PAGE
	add	x0, x0, l_.str.38@PAGEOFF
	bl	_printf
	sub	x0, x29, #8
	mov	x3, #0
	str	x3, [sp]                        ; 8-byte Folded Spill
	mov	x1, x3
	adrp	x2, _discover_slaves@PAGE
	add	x2, x2, _discover_slaves@PAGEOFF
	bl	_pthread_create
	ldr	x3, [sp]                        ; 8-byte Folded Reload
	add	x0, sp, #16
	mov	x1, x3
	adrp	x2, _handle_user_input@PAGE
	add	x2, x2, _handle_user_input@PAGEOFF
	bl	_pthread_create
	mov	x8, #2
	str	x8, [sp, #8]
	ldr	x0, [sp, #8]
	bl	_distribute_workload
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_broadcast_and_serve_slave      ; -- Begin function broadcast_and_serve_slave
	.p2align	2
_broadcast_and_serve_slave:             ; @broadcast_and_serve_slave
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sub	x0, x29, #8
	mov	x3, #0
	str	x3, [sp]                        ; 8-byte Folded Spill
	mov	x1, x3
	adrp	x2, _broadcast_presence@PAGE
	add	x2, x2, _broadcast_presence@PAGEOFF
	bl	_pthread_create
	ldr	x3, [sp]                        ; 8-byte Folded Reload
	add	x0, sp, #16
	mov	x1, x3
	adrp	x2, _respond_to_handshake@PAGE
	add	x2, x2, _respond_to_handshake@PAGEOFF
	bl	_pthread_create
	ldr	x3, [sp]                        ; 8-byte Folded Reload
	add	x0, sp, #8
	mov	x1, x3
	adrp	x2, _start_slave_server@PAGE
	add	x2, x2, _start_slave_server@PAGEOFF
	bl	_pthread_create
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	ldur	x0, [x29, #-8]
	bl	_pthread_join
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	ldr	x0, [sp, #16]
	bl	_pthread_join
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	ldr	x0, [sp, #8]
	bl	_pthread_join
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	wzr, [x29, #-4]
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	mov	x1, #0
	bl	_pthread_mutex_init
	adrp	x0, l_.str.39@PAGE
	add	x0, x0, l_.str.39@PAGEOFF
	bl	_printf
	mov	x9, sp
	add	x8, sp, #8
	str	x8, [x9]
	adrp	x0, l_.str.40@PAGE
	add	x0, x0, l_.str.40@PAGEOFF
	bl	_scanf
	ldr	w8, [sp, #8]
	subs	w8, w8, #1
	cset	w8, ne
	tbnz	w8, #0, LBB16_2
	b	LBB16_1
LBB16_1:
	bl	_start_master
	b	LBB16_6
LBB16_2:
	ldr	w8, [sp, #8]
	subs	w8, w8, #2
	cset	w8, ne
	tbnz	w8, #0, LBB16_4
	b	LBB16_3
LBB16_3:
	bl	_broadcast_and_serve_slave
	b	LBB16_5
LBB16_4:
	adrp	x8, ___stderrp@GOTPAGE
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
	ldr	x0, [x8]
	adrp	x1, l_.str.41@PAGE
	add	x1, x1, l_.str.41@PAGEOFF
	bl	_fprintf
	mov	w8, #1
	stur	w8, [x29, #-4]
	b	LBB16_7
LBB16_5:
	b	LBB16_6
LBB16_6:
	adrp	x0, _lock@GOTPAGE
	ldr	x0, [x0, _lock@GOTPAGEOFF]
	bl	_pthread_mutex_destroy
	stur	wzr, [x29, #-4]
	b	LBB16_7
LBB16_7:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_slave_count                    ; @slave_count
.zerofill __DATA,__common,_slave_count,4,2
	.globl	_start_calculations             ; @start_calculations
.zerofill __DATA,__common,_start_calculations,1,0
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"\nCluster Information:\n"

l_.str.1:                               ; @.str.1
	.asciz	"Slave Name\tIP Address\tCores\tRAM\n"

l_.str.2:                               ; @.str.2
	.asciz	"Slave-%d\t%s\t%d\t%ld GB\n"

	.comm	_slaves,4000,3                  ; @slaves
l_.str.3:                               ; @.str.3
	.asciz	"Master\t\tN/A\t\t%d\t%ld GB\n"

l_.str.4:                               ; @.str.4
	.asciz	"\n"

l_.str.5:                               ; @.str.5
	.asciz	"getifaddrs"

l_.str.6:                               ; @.str.6
	.asciz	"en0"

l_.str.7:                               ; @.str.7
	.asciz	"eth0"

l_.str.8:                               ; @.str.8
	.asciz	"Failed to allocate memory for sieve"

l_.str.9:                               ; @.str.9
	.asciz	"SLAVE:%s:%d:%ld"

l_.str.10:                              ; @.str.10
	.asciz	"socket"

l_.str.11:                              ; @.str.11
	.asciz	"setsockopt"

l_.str.12:                              ; @.str.12
	.asciz	"255.255.255.255"

l_.str.13:                              ; @.str.13
	.asciz	"Error reading range"

l_.str.14:                              ; @.str.14
	.asciz	"Received range: %lu to %lu\n"

l_.str.15:                              ; @.str.15
	.asciz	"Failed to allocate memory for primes"

l_.str.16:                              ; @.str.16
	.asciz	"Error writing result"

l_.str.17:                              ; @.str.17
	.asciz	"socket failed"

l_.str.18:                              ; @.str.18
	.asciz	"bind failed"

l_.str.19:                              ; @.str.19
	.asciz	"listen"

l_.str.20:                              ; @.str.20
	.asciz	"Slave server listening for master connections...\n"

l_.str.21:                              ; @.str.21
	.asciz	"accept"

l_.str.22:                              ; @.str.22
	.asciz	"bind"

l_.str.23:                              ; @.str.23
	.asciz	"HANDSHAKE"

l_.str.24:                              ; @.str.24
	.asciz	"Responded to handshake with %s\n"

l_.str.25:                              ; @.str.25
	.asciz	":"

l_.str.26:                              ; @.str.26
	.asciz	"SLAVE"

	.comm	_lock,64,3                      ; @lock
l_.str.27:                              ; @.str.27
	.asciz	" %c"

l_.str.28:                              ; @.str.28
	.asciz	"inet_pton"

l_.str.29:                              ; @.str.29
	.asciz	"connect"

l_.str.30:                              ; @.str.30
	.asciz	"primes.txt"

l_.str.31:                              ; @.str.31
	.asciz	"a"

l_.str.32:                              ; @.str.32
	.asciz	"fopen"

l_.str.33:                              ; @.str.33
	.asciz	"%d\n"

l_.str.34:                              ; @.str.34
	.asciz	"Master found %d primes in range %lu to %lu in %ld milliseconds\n"

l_.str.35:                              ; @.str.35
	.asciz	"Invalid range: start %lu, end %lu\n"

l_.str.36:                              ; @.str.36
	.asciz	"Assigning range %lu to %lu to slave %s\n"

l_.str.37:                              ; @.str.37
	.asciz	"Master calculating range %lu to %lu\n"

l_.str.38:                              ; @.str.38
	.asciz	"Starting master...\n"

l_.str.39:                              ; @.str.39
	.asciz	"1. Master\n2. Slave\nChoose mode: "

l_.str.40:                              ; @.str.40
	.asciz	"%d"

l_.str.41:                              ; @.str.41
	.asciz	"Invalid choice.\n"

.subsections_via_symbols
