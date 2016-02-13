	.data
l.6888:	 # 128.000000
	.word	1124073472
l.6855:	 # 0.900000
	.word	1063675494
l.6854:	 # 0.200000
	.word	1045220557
l.6760:	 # 150.000000
	.word	1125515264
	.text
_min_caml_start:
	syscall
	j	min_caml_print_byte
	jal	min_caml_fiszero
	bc1t	0, mincaml_fiszero_true
	bc1f	0, mincaml_fiszero_false
	jr	$ra
	blez	$t3, div10_return
	bgez	$t3, div10_calc
	bltz	$a0, min_caml_print_int_minus
	bgtz	$v0, min_caml_print_int_rec
	li	$v0, 0
	lui	$v0, 0
	mfc1	$v0, $f12
	mtc1	$r0, $f5
	jalr	$ra, $t8
	sll	$a1, $a1, 1
	srl	$a0, $a0, 1
	addi	$sp, $sp, -1
	addiu	$sp, $sp, -1
	ori	$v0, $r0, 12
	beq	$t2, $v0, min_caml_read_token_l1
	bne	$s0, $zero, min_caml_read_token_finish
	lw	$ra, 0($sp)
	sw	$ra, 0($sp)
	lwc1	$f2, 0($hp)
	swc1	$f12, 0($hp)
	add	$at, $a0, $v0
	sub	$at, $a0, $v0
	slt	$at, $a0, $v0
	and	$s0, $a0, $v0
	or	$v0, $v0, $zero
	xor	$v0, $v1, $t1
	sllv	$v0, $v0, $v0
	inv.s	$f0, $f12
	sqrt.s	$f0, $f12
	mov.s	$f1, $f2
	neg.s	$f1, $f1
	trunc.w.s	$f12, $f12
	cvt.s.w	$f12, $f12
	c.eq.s	0, $f12, $f13
	c.olt.s	0, $f12, $f13
	c.ole.s 0, $f12, $f13
	add.s	$f0, $f12, $f13
	sub.s	$f0, $f12, $f13
	mul.s	$f0, $f12, $f13
