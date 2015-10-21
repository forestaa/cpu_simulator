f.4:
	li	$v0, 1
	add	$v0, $a0, $v0
	jr	$ra
_min_caml_start:
	li	$v0, 3
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 4($sp)
	addi	$sp, $sp, 8
	jal	f.4
	addi	$sp, $sp, -8
	lw	$t8, 4($sp)
	move	$ra, $t8
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 4($sp)
	addi	$sp, $sp, 8
	jal	min_caml_print_int
	addi	$sp, $sp, -8
	lw	$t8, 4($sp)
	move	$ra, $t8
