	.data
l.6888:	 # 128.000000
	.word	1124073472
l.6855:	 # 0.900000
	.word	1063675494
l.6854:	 # 0.200000
	.word	1045220557
l.6760:	 # 150.000000
	.word	1125515264
l.6758:	 # -150.000000
	.word	-1021968384
l.6742:	 # 0.100000
	.word	1036831949
l.6739:	 # -2.000000
	.word	-1073741824
l.6737:	 # 0.003906
	.word	998244352
l.6715:	 # 20.000000
	.word	1101004800
l.6714:	 # 0.050000
	.word	1028443341
l.6710:	 # 0.250000
	.word	1048576000
l.6706:	 # 10.000000
	.word	1092616192
l.6702:	 # 0.300000
	.word	1050253722
l.6701:	 # 255.000000
	.word	1132396544
l.6700:	 # 0.500000
	.word	1056964608
l.6699:	 # 0.150000
	.word	1041865114
l.6697:	 # 3.141593
	.word	1078530011
l.6696:	 # 30.000000
	.word	1106247680
l.6695:	 # 15.000000
	.word	1097859072
l.6694:	 # 0.000100
	.word	953267991
l.6651:	 # 100000000.000000
	.word	1287568416
l.6647:	 # 1000000000.000000
	.word	1315859240
l.6627:	 # -0.100000
	.word	-1110651699
l.6614:	 # 0.010000
	.word	1008981770
l.6613:	 # -0.200000
	.word	-1102263091
l.6422:	 # 2.000000
	.word	1073741824
l.6388:	 # -200.000000
	.word	-1018691584
l.6386:	 # 200.000000
	.word	1128792064
l.6382:	 # 0.017453
	.word	1016003125
l.6299:	 # -1.000000
	.word	-1082130432
l.6298:	 # 1.000000
	.word	1065353216
l.6297:	 # 0.000000
	.word	0
	.text
xor.2602:
	li	$v0, 0
	bne	$a0, $v0, beq_else.8424
	move	$v0, $a1
	jr	$ra
beq_else.8424:
	li	$v0, 0
	bne	$a1, $v0, beq_else.8425
	li	$v0, 1
	jr	$ra
beq_else.8425:
	li	$v0, 0
	jr	$ra
sgn.2605:
	swc1	$f12, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_fiszero
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8426
	lwc1	$f2, 0($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_fispos
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8427
	lwc1	$f0, 0(l.6299)
	jr	$ra
beq_else.8427:
	lwc1	$f0, 0(l.6298)
	jr	$ra
beq_else.8426:
	lwc1	$f0, 0(l.6297)
	jr	$ra
fneg_cond.2607:
	li	$v0, 0
	bne	$a0, $v0, beq_else.8428
	j	min_caml_fneg
beq_else.8428:
	mov.s	$f0, $f12
	jr	$ra
add_mod5.2610:
	add	$v0, $a0, $a1
	li	$v1, 5
	sub	$at, $v1, $v0
	bgtz	$at, ble_else.8429
	li	$v1, 5
	sub	$v0, $v0, $v1
	jr	$ra
ble_else.8429:
	jr	$ra
vecset.2613:
	li	$v0, 0
	add	$at, $a0, $v0
	swc1	$f12, 0($at)
	li	$v0, 1
	add	$at, $a0, $v0
	swc1	$f13, 0($at)
	li	$v0, 2
	add	$at, $a0, $v0
	swc1	$f14, 0($at)
	jr	$ra
vecfill.2618:
	li	$v0, 0
	add	$at, $a0, $v0
	swc1	$f12, 0($at)
	li	$v0, 1
	add	$at, $a0, $v0
	swc1	$f12, 0($at)
	li	$v0, 2
	add	$at, $a0, $v0
	swc1	$f12, 0($at)
	jr	$ra
vecbzero.2621:
	lwc1	$f2, 0(l.6297)
	mov.s	$f12, $f2
	j	vecfill.2618
veccpy.2623:
	li	$v0, 0
	li	$v1, 0
	add	$at, $a1, $v1
	lwc1	$f2, 0($at)
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	li	$v1, 1
	add	$at, $a1, $v1
	lwc1	$f2, 0($at)
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$v1, 2
	add	$at, $a1, $v1
	lwc1	$f2, 0($at)
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	jr	$ra
vecunit_sgn.2631:
	li	$v0, 0
	add	$at, $a0, $v0
	lwc1	$f2, 0($at)
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_fsqr
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -2($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fsqr
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	add.s	$f2, $f3, $f2
	li	$v0, 2
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fsqr
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_sqrt
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fiszero
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8433
	li	$v0, 0
	lw	$v1, 0($sp)
	bne	$v1, $v0, beq_else.8435
	lwc1	$f2, 0(l.6298)
	lwc1	$f3, -4($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	j	beq_cont.8436
beq_else.8435:
	lwc1	$f2, 0(l.6299)
	lwc1	$f3, -4($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
beq_cont.8436:
	j	beq_cont.8434
beq_else.8433:
	lwc1	$f2, 0(l.6298)
beq_cont.8434:
	li	$v0, 0
	li	$v1, 0
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f2
	add	$at, $a0, $v0
	swc1	$f3, 0($at)
	li	$v0, 1
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f2
	add	$at, $a0, $v0
	swc1	$f3, 0($at)
	li	$v0, 2
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f3, 0($at)
	mul.s	$f2, $f3, $f2
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	jr	$ra
veciprod.2634:
	li	$v0, 0
	add	$at, $a0, $v0
	lwc1	$f2, 0($at)
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	li	$v0, 1
	add	$at, $a0, $v0
	lwc1	$f3, 0($at)
	li	$v0, 1
	add	$at, $a1, $v0
	lwc1	$f4, 0($at)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	li	$v0, 2
	add	$at, $a0, $v0
	lwc1	$f3, 0($at)
	li	$v0, 2
	add	$at, $a1, $v0
	lwc1	$f4, 0($at)
	mul.s	$f3, $f3, $f4
	add.s	$f0, $f2, $f3
	jr	$ra
veciprod2.2637:
	li	$v0, 0
	add	$at, $a0, $v0
	lwc1	$f2, 0($at)
	mul.s	$f2, $f2, $f12
	li	$v0, 1
	add	$at, $a0, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f13
	add.s	$f2, $f2, $f3
	li	$v0, 2
	add	$at, $a0, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f14
	add.s	$f0, $f2, $f3
	jr	$ra
vecaccum.2642:
	li	$v0, 0
	li	$v1, 0
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 0
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f12, $f3
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 1
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f12, $f3
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 2
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f12, $f3
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	jr	$ra
vecadd.2646:
	li	$v0, 0
	li	$v1, 0
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 0
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 1
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 2
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	jr	$ra
vecscale.2652:
	li	$v0, 0
	li	$v1, 0
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	mul.s	$f2, $f2, $f12
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	mul.s	$f2, $f2, $f12
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	mul.s	$f2, $f2, $f12
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	jr	$ra
vecaccumv.2655:
	li	$v0, 0
	li	$v1, 0
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 0
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	li	$v1, 0
	add	$at, $a2, $v1
	lwc1	$f4, 0($at)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 1
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	li	$v1, 1
	add	$at, $a2, $v1
	lwc1	$f4, 0($at)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 2
	add	$at, $a1, $v1
	lwc1	$f3, 0($at)
	li	$v1, 2
	add	$at, $a2, $v1
	lwc1	$f4, 0($at)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	add	$at, $a0, $v0
	swc1	$f2, 0($at)
	jr	$ra
o_texturetype.2659:
	lw	$v0, 0($a0)
	jr	$ra
o_form.2661:
	lw	$v0, 1($a0)
	jr	$ra
o_reflectiontype.2663:
	lw	$v0, 2($a0)
	jr	$ra
o_isinvert.2665:
	lw	$v0, 6($a0)
	jr	$ra
o_isrot.2667:
	lw	$v0, 3($a0)
	jr	$ra
o_param_a.2669:
	lw	$v0, 4($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_b.2671:
	lw	$v0, 4($a0)
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_c.2673:
	lw	$v0, 4($a0)
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_abc.2675:
	lw	$v0, 4($a0)
	jr	$ra
o_param_x.2677:
	lw	$v0, 5($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_y.2679:
	lw	$v0, 5($a0)
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_z.2681:
	lw	$v0, 5($a0)
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_diffuse.2683:
	lw	$v0, 7($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_hilight.2685:
	lw	$v0, 7($a0)
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_color_red.2687:
	lw	$v0, 8($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_color_green.2689:
	lw	$v0, 8($a0)
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_color_blue.2691:
	lw	$v0, 8($a0)
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_r1.2693:
	lw	$v0, 9($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_r2.2695:
	lw	$v0, 9($a0)
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_r3.2697:
	lw	$v0, 9($a0)
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f0, 0($at)
	jr	$ra
o_param_ctbl.2699:
	lw	$v0, 10($a0)
	jr	$ra
p_rgb.2701:
	lw	$v0, 0($a0)
	jr	$ra
p_intersection_points.2703:
	lw	$v0, 1($a0)
	jr	$ra
p_surface_ids.2705:
	lw	$v0, 2($a0)
	jr	$ra
p_calc_diffuse.2707:
	lw	$v0, 3($a0)
	jr	$ra
p_energy.2709:
	lw	$v0, 4($a0)
	jr	$ra
p_received_ray_20percent.2711:
	lw	$v0, 5($a0)
	jr	$ra
p_group_id.2713:
	lw	$v0, 6($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	jr	$ra
p_set_group_id.2715:
	lw	$v0, 6($a0)
	li	$v1, 0
	add	$at, $v0, $v1
	sw	$a1, 0($at)
	jr	$ra
p_nvectors.2718:
	lw	$v0, 7($a0)
	jr	$ra
d_vec.2720:
	lw	$v0, 0($a0)
	jr	$ra
d_const.2722:
	lw	$v0, 1($a0)
	jr	$ra
r_surface_id.2724:
	lw	$v0, 0($a0)
	jr	$ra
r_dvec.2726:
	lw	$v0, 1($a0)
	jr	$ra
r_bright.2728:
	lwc1	$f2, 2($a0)
	mov.s	$f0, $f2
	jr	$ra
rad.2730:
	lwc1	$f2, 0(l.6382)
	mul.s	$f0, $f12, $f2
	jr	$ra
read_screen_settings.2732:
	li	$v0, min_caml_screen
	li	$v1, 0
	sw	$v1, 0($sp)
	sw	$v0, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_read_float
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, 0($sp)
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_screen
	li	$v1, 1
	sw	$v1, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_read_float
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -2($sp)
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_screen
	li	$v1, 2
	sw	$v1, -4($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_read_float
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -4($sp)
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_read_float
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	rad.2730
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -6($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_cos
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_sin
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -8($sp)
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_read_float
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	rad.2730
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_cos
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	swc1	$f2, -10($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_sin
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_screenz_dir
	li	$v1, 0
	lwc1	$f3, -7($sp)
	mul.s	$f4, $f3, $f2
	lwc1	$f5, 0(l.6386)
	mul.s	$f4, $f4, $f5
	add	$at, $v0, $v1
	swc1	$f4, 0($at)
	li	$v0, min_caml_screenz_dir
	li	$v1, 1
	lwc1	$f4, 0(l.6388)
	lwc1	$f5, -8($sp)
	mul.s	$f4, $f5, $f4
	add	$at, $v0, $v1
	swc1	$f4, 0($at)
	li	$v0, min_caml_screenz_dir
	li	$v1, 2
	lwc1	$f4, -10($sp)
	mul.s	$f6, $f3, $f4
	lwc1	$f7, 0(l.6386)
	mul.s	$f6, $f6, $f7
	add	$at, $v0, $v1
	swc1	$f6, 0($at)
	li	$v0, min_caml_screenx_dir
	li	$v1, 0
	add	$at, $v0, $v1
	swc1	$f4, 0($at)
	li	$v0, min_caml_screenx_dir
	li	$v1, 1
	lwc1	$f6, 0(l.6297)
	add	$at, $v0, $v1
	swc1	$f6, 0($at)
	li	$v0, min_caml_screenx_dir
	li	$v1, 2
	swc1	$f2, -11($sp)
	sw	$v1, -12($sp)
	sw	$v0, -13($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fneg
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -12($sp)
	lw	$v1, -13($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_screeny_dir
	li	$v1, 0
	lwc1	$f2, -8($sp)
	sw	$v1, -14($sp)
	sw	$v0, -15($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	min_caml_fneg
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -11($sp)
	mul.s	$f2, $f2, $f3
	lw	$v0, -14($sp)
	lw	$v1, -15($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_screeny_dir
	li	$v1, 1
	lwc1	$f2, -7($sp)
	sw	$v1, -16($sp)
	sw	$v0, -17($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	min_caml_fneg
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -16($sp)
	lw	$v1, -17($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_screeny_dir
	li	$v1, 2
	lwc1	$f2, -8($sp)
	sw	$v1, -18($sp)
	sw	$v0, -19($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	min_caml_fneg
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -10($sp)
	mul.s	$f2, $f2, $f3
	lw	$v0, -18($sp)
	lw	$v1, -19($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_viewpoint
	li	$v1, 0
	li	$a0, min_caml_screen
	li	$a1, 0
	add	$at, $a0, $a1
	lwc1	$f2, 0($at)
	li	$a0, min_caml_screenz_dir
	li	$a1, 0
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	sub.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_viewpoint
	li	$v1, 1
	li	$a0, min_caml_screen
	li	$a1, 1
	add	$at, $a0, $a1
	lwc1	$f2, 0($at)
	li	$a0, min_caml_screenz_dir
	li	$a1, 1
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	sub.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_viewpoint
	li	$v1, 2
	li	$a0, min_caml_screen
	li	$a1, 2
	add	$at, $a0, $a1
	lwc1	$f2, 0($at)
	li	$a0, min_caml_screenz_dir
	li	$a1, 2
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	sub.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	jr	$ra
read_light.2734:
	move	$t8, $ra
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_read_int
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	move	$t8, $ra
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_read_float
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	rad.2730
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, 0($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_sin
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_light
	li	$v1, 1
	sw	$v1, -1($sp)
	sw	$v0, -2($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fneg
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -1($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_read_float
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	rad.2730
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0($sp)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_cos
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_sin
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_light
	li	$v1, 0
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	lwc1	$f2, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_cos
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_light
	li	$v1, 2
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_beam
	li	$v1, 0
	sw	$v1, -5($sp)
	sw	$v0, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_read_float
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -5($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	jr	$ra
rotate_quadratic_matrix.2736:
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f2, 0($at)
	sw	$a0, 0($sp)
	sw	$a1, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_cos
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 0
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -2($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_sin
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_cos
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_sin
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 2
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_cos
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 2
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_sin
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	lwc1	$f4, -4($sp)
	mul.s	$f5, $f4, $f3
	lwc1	$f6, -5($sp)
	lwc1	$f7, -3($sp)
	mul.s	$f8, $f7, $f6
	mul.s	$f8, $f8, $f3
	lwc1	$f9, -2($sp)
	mul.s	$f10, $f9, $f2
	sub.s	$f8, $f8, $f10
	mul.s	$f10, $f9, $f6
	mul.s	$f10, $f10, $f3
	mul.s	$f11, $f7, $f2
	add.s	$f10, $f10, $f11
	mul.s	$f11, $f4, $f2
	mul.s	$f12, $f7, $f6
	mul.s	$f12, $f12, $f2
	mul.s	$f13, $f9, $f3
	add.s	$f12, $f12, $f13
	mul.s	$f13, $f9, $f6
	mul.s	$f2, $f13, $f2
	mul.s	$f3, $f7, $f3
	sub.s	$f2, $f2, $f3
	swc1	$f2, -7($sp)
	swc1	$f10, -8($sp)
	swc1	$f12, -9($sp)
	swc1	$f8, -10($sp)
	swc1	$f11, -11($sp)
	swc1	$f5, -12($sp)
	move	$t8, $ra
	mov.s	$f12, $f6
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_fneg
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	lwc1	$f4, -3($sp)
	mul.s	$f4, $f4, $f3
	lwc1	$f5, -2($sp)
	mul.s	$f3, $f5, $f3
	li	$v0, 0
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f5, 0($at)
	li	$v0, 1
	add	$at, $v1, $v0
	lwc1	$f6, 0($at)
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f7, 0($at)
	li	$v0, 0
	lwc1	$f8, -12($sp)
	swc1	$f3, -13($sp)
	swc1	$f4, -14($sp)
	sw	$v0, -15($sp)
	swc1	$f7, -16($sp)
	swc1	$f2, -17($sp)
	swc1	$f6, -18($sp)
	swc1	$f5, -19($sp)
	move	$t8, $ra
	mov.s	$f12, $f8
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	min_caml_fsqr
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -19($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -11($sp)
	swc1	$f2, -20($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -21($sp)
	addi	$sp, $sp, -22
	jal	min_caml_fsqr
	addi	$sp, $sp, 22
	lw	$t8, -21($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -18($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -20($sp)
	add.s	$f2, $f4, $f2
	lwc1	$f4, -17($sp)
	swc1	$f2, -21($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -22($sp)
	addi	$sp, $sp, -23
	jal	min_caml_fsqr
	addi	$sp, $sp, 23
	lw	$t8, -22($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -16($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -21($sp)
	add.s	$f2, $f4, $f2
	lw	$v0, -15($sp)
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	lwc1	$f2, -10($sp)
	sw	$v0, -22($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -23($sp)
	addi	$sp, $sp, -24
	jal	min_caml_fsqr
	addi	$sp, $sp, 24
	lw	$t8, -23($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -19($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -9($sp)
	swc1	$f2, -23($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -24($sp)
	addi	$sp, $sp, -25
	jal	min_caml_fsqr
	addi	$sp, $sp, 25
	lw	$t8, -24($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -18($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -23($sp)
	add.s	$f2, $f4, $f2
	lwc1	$f4, -14($sp)
	swc1	$f2, -24($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -25($sp)
	addi	$sp, $sp, -26
	jal	min_caml_fsqr
	addi	$sp, $sp, 26
	lw	$t8, -25($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -16($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -24($sp)
	add.s	$f2, $f4, $f2
	lw	$v0, -22($sp)
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	lwc1	$f2, -8($sp)
	sw	$v0, -25($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -26($sp)
	addi	$sp, $sp, -27
	jal	min_caml_fsqr
	addi	$sp, $sp, 27
	lw	$t8, -26($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -19($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -7($sp)
	swc1	$f2, -26($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -27($sp)
	addi	$sp, $sp, -28
	jal	min_caml_fsqr
	addi	$sp, $sp, 28
	lw	$t8, -27($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -18($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -26($sp)
	add.s	$f2, $f4, $f2
	lwc1	$f4, -13($sp)
	swc1	$f2, -27($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	min_caml_fsqr
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -16($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -27($sp)
	add.s	$f2, $f4, $f2
	lw	$v0, -25($sp)
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 0
	lwc1	$f2, 0(l.6422)
	lwc1	$f4, -10($sp)
	lwc1	$f5, -19($sp)
	mul.s	$f6, $f5, $f4
	lwc1	$f7, -8($sp)
	mul.s	$f6, $f6, $f7
	lwc1	$f8, -9($sp)
	lwc1	$f9, -18($sp)
	mul.s	$f10, $f9, $f8
	lwc1	$f11, -7($sp)
	mul.s	$f10, $f10, $f11
	add.s	$f6, $f6, $f10
	lwc1	$f10, -14($sp)
	mul.s	$f12, $f3, $f10
	lwc1	$f13, -13($sp)
	mul.s	$f12, $f12, $f13
	add.s	$f6, $f6, $f12
	mul.s	$f2, $f2, $f6
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	lwc1	$f2, 0(l.6422)
	lwc1	$f6, -12($sp)
	mul.s	$f12, $f5, $f6
	mul.s	$f7, $f12, $f7
	lwc1	$f12, -11($sp)
	mul.s	$f14, $f9, $f12
	mul.s	$f11, $f14, $f11
	add.s	$f7, $f7, $f11
	lwc1	$f11, -17($sp)
	mul.s	$f14, $f3, $f11
	mul.s	$f13, $f14, $f13
	add.s	$f7, $f7, $f13
	mul.s	$f2, $f2, $f7
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	lwc1	$f2, 0(l.6422)
	mul.s	$f5, $f5, $f6
	mul.s	$f4, $f5, $f4
	mul.s	$f5, $f9, $f12
	mul.s	$f5, $f5, $f8
	add.s	$f4, $f4, $f5
	mul.s	$f3, $f3, $f11
	mul.s	$f3, $f3, $f10
	add.s	$f3, $f4, $f3
	mul.s	$f2, $f2, $f3
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	jr	$ra
read_nth_object.2739:
	sw	$a0, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_read_int
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, -1
	bne	$v0, $v1, beq_else.8446
	li	$v0, 0
	jr	$ra
beq_else.8446:
	sw	$v0, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_read_int
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	sw	$v0, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_read_int
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	sw	$v0, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_read_int
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 3
	lwc1	$f2, 0(l.6297)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_create_float_array
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	sw	$v1, -5($sp)
	sw	$v0, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_read_float
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -5($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	sw	$v0, -7($sp)
	move	$t8, $ra
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_read_float
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -7($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	sw	$v0, -8($sp)
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_read_float
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -8($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_create_float_array
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	sw	$v1, -9($sp)
	sw	$v0, -10($sp)
	move	$t8, $ra
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_read_float
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -9($sp)
	lw	$v1, -10($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	sw	$v0, -11($sp)
	move	$t8, $ra
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_read_float
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -11($sp)
	lw	$v1, -10($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	sw	$v0, -12($sp)
	move	$t8, $ra
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_read_float
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -12($sp)
	lw	$v1, -10($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	move	$t8, $ra
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_read_float
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_fisneg
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	move	$ra, $t8
	li	$v1, 2
	lwc1	$f2, 0(l.6297)
	sw	$v0, -13($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_create_float_array
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	li	$v1, 0
	sw	$v1, -14($sp)
	sw	$v0, -15($sp)
	move	$t8, $ra
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	min_caml_read_float
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -14($sp)
	lw	$v1, -15($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	sw	$v0, -16($sp)
	move	$t8, $ra
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	min_caml_read_float
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -16($sp)
	lw	$v1, -15($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	min_caml_create_float_array
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	move	$ra, $t8
	li	$v1, 0
	sw	$v1, -17($sp)
	sw	$v0, -18($sp)
	move	$t8, $ra
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	min_caml_read_float
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -17($sp)
	lw	$v1, -18($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	sw	$v0, -19($sp)
	move	$t8, $ra
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	min_caml_read_float
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -19($sp)
	lw	$v1, -18($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	sw	$v0, -20($sp)
	move	$t8, $ra
	sw	$t8, -21($sp)
	addi	$sp, $sp, -22
	jal	min_caml_read_float
	addi	$sp, $sp, 22
	lw	$t8, -21($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -20($sp)
	lw	$v1, -18($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -21($sp)
	addi	$sp, $sp, -22
	jal	min_caml_create_float_array
	addi	$sp, $sp, 22
	lw	$t8, -21($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -4($sp)
	sw	$v0, -21($sp)
	bne	$a0, $v1, beq_else.8447
	j	beq_cont.8448
beq_else.8447:
	li	$v1, 0
	sw	$v1, -22($sp)
	move	$t8, $ra
	sw	$t8, -23($sp)
	addi	$sp, $sp, -24
	jal	min_caml_read_float
	addi	$sp, $sp, 24
	lw	$t8, -23($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -23($sp)
	addi	$sp, $sp, -24
	jal	rad.2730
	addi	$sp, $sp, 24
	lw	$t8, -23($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -22($sp)
	lw	$v1, -21($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	sw	$v0, -23($sp)
	move	$t8, $ra
	sw	$t8, -24($sp)
	addi	$sp, $sp, -25
	jal	min_caml_read_float
	addi	$sp, $sp, 25
	lw	$t8, -24($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -24($sp)
	addi	$sp, $sp, -25
	jal	rad.2730
	addi	$sp, $sp, 25
	lw	$t8, -24($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -23($sp)
	lw	$v1, -21($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	sw	$v0, -24($sp)
	move	$t8, $ra
	sw	$t8, -25($sp)
	addi	$sp, $sp, -26
	jal	min_caml_read_float
	addi	$sp, $sp, 26
	lw	$t8, -25($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -25($sp)
	addi	$sp, $sp, -26
	jal	rad.2730
	addi	$sp, $sp, 26
	lw	$t8, -25($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -24($sp)
	lw	$v1, -21($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8448:
	li	$v0, 2
	lw	$v1, -2($sp)
	bne	$v1, $v0, beq_else.8449
	li	$v0, 1
	j	beq_cont.8450
beq_else.8449:
	lw	$v0, -13($sp)
beq_cont.8450:
	li	$a0, 4
	lwc1	$f2, 0(l.6297)
	sw	$v0, -25($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -26($sp)
	addi	$sp, $sp, -27
	jal	min_caml_create_float_array
	addi	$sp, $sp, 27
	lw	$t8, -26($sp)
	move	$ra, $t8
	move	$v1, $hp
	addi	$hp, $hp, 11
	sw	$v0, 10($v1)
	lw	$v0, -21($sp)
	sw	$v0, 9($v1)
	lw	$a0, -18($sp)
	sw	$a0, 8($v1)
	lw	$a0, -15($sp)
	sw	$a0, 7($v1)
	lw	$a0, -25($sp)
	sw	$a0, 6($v1)
	lw	$a0, -10($sp)
	sw	$a0, 5($v1)
	lw	$a0, -6($sp)
	sw	$a0, 4($v1)
	lw	$a1, -4($sp)
	sw	$a1, 3($v1)
	lw	$a2, -3($sp)
	sw	$a2, 2($v1)
	lw	$a2, -2($sp)
	sw	$a2, 1($v1)
	lw	$a3, -1($sp)
	sw	$a3, 0($v1)
	li	$a3, min_caml_objects
	lw	$t0, 0($sp)
	add	$at, $a3, $t0
	sw	$v1, 0($at)
	li	$v1, 3
	bne	$a2, $v1, beq_else.8451
	li	$v1, 0
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 0
	sw	$v1, -26($sp)
	swc1	$f2, -27($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	min_caml_fiszero
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8453
	lwc1	$f2, -27($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	sgn.2605
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -27($sp)
	swc1	$f2, -28($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -29($sp)
	addi	$sp, $sp, -30
	jal	min_caml_fsqr
	addi	$sp, $sp, 30
	lw	$t8, -29($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -28($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	j	beq_cont.8454
beq_else.8453:
	lwc1	$f2, 0(l.6297)
beq_cont.8454:
	lw	$v0, -26($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	li	$v0, 1
	sw	$v0, -29($sp)
	swc1	$f2, -30($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -31($sp)
	addi	$sp, $sp, -32
	jal	min_caml_fiszero
	addi	$sp, $sp, 32
	lw	$t8, -31($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8455
	lwc1	$f2, -30($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -31($sp)
	addi	$sp, $sp, -32
	jal	sgn.2605
	addi	$sp, $sp, 32
	lw	$t8, -31($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -30($sp)
	swc1	$f2, -31($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -32($sp)
	addi	$sp, $sp, -33
	jal	min_caml_fsqr
	addi	$sp, $sp, 33
	lw	$t8, -32($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -31($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	j	beq_cont.8456
beq_else.8455:
	lwc1	$f2, 0(l.6297)
beq_cont.8456:
	lw	$v0, -29($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	li	$v0, 2
	sw	$v0, -32($sp)
	swc1	$f2, -33($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -34($sp)
	addi	$sp, $sp, -35
	jal	min_caml_fiszero
	addi	$sp, $sp, 35
	lw	$t8, -34($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8457
	lwc1	$f2, -33($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -34($sp)
	addi	$sp, $sp, -35
	jal	sgn.2605
	addi	$sp, $sp, 35
	lw	$t8, -34($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -33($sp)
	swc1	$f2, -34($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -35($sp)
	addi	$sp, $sp, -36
	jal	min_caml_fsqr
	addi	$sp, $sp, 36
	lw	$t8, -35($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -34($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	j	beq_cont.8458
beq_else.8457:
	lwc1	$f2, 0(l.6297)
beq_cont.8458:
	lw	$v0, -32($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8452
beq_else.8451:
	li	$v1, 2
	bne	$a2, $v1, beq_else.8459
	li	$v1, 0
	lw	$a2, -13($sp)
	bne	$a2, $v1, beq_else.8461
	li	$v1, 1
	j	beq_cont.8462
beq_else.8461:
	li	$v1, 0
beq_cont.8462:
	move	$t8, $ra
	move	$a1, $v1
	sw	$t8, -35($sp)
	addi	$sp, $sp, -36
	jal	vecunit_sgn.2631
	addi	$sp, $sp, 36
	lw	$t8, -35($sp)
	move	$ra, $t8
	j	beq_cont.8460
beq_else.8459:
beq_cont.8460:
beq_cont.8452:
	li	$v0, 0
	lw	$v1, -4($sp)
	bne	$v1, $v0, beq_else.8463
	j	beq_cont.8464
beq_else.8463:
	lw	$v0, -6($sp)
	lw	$v1, -21($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -35($sp)
	addi	$sp, $sp, -36
	jal	rotate_quadratic_matrix.2736
	addi	$sp, $sp, 36
	lw	$t8, -35($sp)
	move	$ra, $t8
beq_cont.8464:
	li	$v0, 1
	jr	$ra
read_object.2741:
	li	$v0, 60
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8465
	jr	$ra
ble_else.8465:
	sw	$a0, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	read_nth_object.2739
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8467
	li	$v0, min_caml_n_objects
	li	$v1, 0
	lw	$a0, 0($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	jr	$ra
beq_else.8467:
	li	$v0, 1
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	move	$a0, $v0
	j	read_object.2741
read_all_object.2743:
	li	$v0, 0
	move	$a0, $v0
	j	read_object.2741
read_net_item.2745:
	sw	$a0, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_read_int
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, -1
	bne	$v0, $v1, beq_else.8469
	li	$v0, 1
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	li	$v1, -1
	move	$a1, $v1
	move	$a0, $v0
	j	min_caml_create_array
beq_else.8469:
	li	$v1, 1
	lw	$a0, 0($sp)
	add	$v1, $a0, $v1
	sw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	read_net_item.2745
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	jr	$ra
read_or_network.2747:
	li	$v0, 0
	sw	$a0, 0($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	read_net_item.2745
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v1, 0($at)
	li	$a0, -1
	bne	$v1, $a0, beq_else.8470
	li	$v1, 1
	lw	$a0, 0($sp)
	add	$v1, $a0, $v1
	move	$a1, $v0
	move	$a0, $v1
	j	min_caml_create_array
beq_else.8470:
	li	$v1, 1
	lw	$a0, 0($sp)
	add	$v1, $a0, $v1
	sw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	read_or_network.2747
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	jr	$ra
read_and_network.2749:
	li	$v0, 0
	sw	$a0, 0($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	read_net_item.2745
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v1, 0($at)
	li	$a0, -1
	bne	$v1, $a0, beq_else.8471
	jr	$ra
beq_else.8471:
	li	$v1, min_caml_and_net
	lw	$a0, 0($sp)
	add	$at, $v1, $a0
	sw	$v0, 0($at)
	li	$v0, 1
	add	$v0, $a0, $v0
	move	$a0, $v0
	j	read_and_network.2749
read_parameter.2751:
	move	$t8, $ra
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	read_screen_settings.2732
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	move	$t8, $ra
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	read_light.2734
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	move	$t8, $ra
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	read_all_object.2743
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 0
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	read_and_network.2749
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_or_net
	li	$v1, 0
	li	$a0, 0
	sw	$v1, 0($sp)
	sw	$v0, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	read_or_network.2747
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	jr	$ra
solver_rect_surface.2753:
	add	$at, $a1, $a2
	lwc1	$f2, 0($at)
	swc1	$f14, 0($sp)
	sw	$t0, -1($sp)
	swc1	$f13, -2($sp)
	sw	$a3, -3($sp)
	swc1	$f12, -4($sp)
	sw	$a2, -5($sp)
	sw	$a1, -6($sp)
	sw	$a0, -7($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_fiszero
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8474
	lw	$v0, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_abc.2675
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	lw	$v1, -7($sp)
	sw	$v0, -8($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_isinvert.2665
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	lw	$a0, -6($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	sw	$v0, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fisneg
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v1, -9($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	xor.2602
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	lw	$a0, -8($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	fneg_cond.2607
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	sub.s	$f2, $f2, $f3
	lw	$v0, -5($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	lw	$v0, -3($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f2, $f3
	lwc1	$f4, -2($sp)
	add.s	$f3, $f3, $f4
	swc1	$f2, -10($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fabs
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	lw	$v1, -8($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fless
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8475
	li	$v0, 0
	jr	$ra
beq_else.8475:
	lw	$v0, -1($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -10($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, 0($sp)
	add.s	$f2, $f2, $f4
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fabs
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -1($sp)
	lw	$v1, -8($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fless
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8476
	li	$v0, 0
	jr	$ra
beq_else.8476:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -10($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 1
	jr	$ra
beq_else.8474:
	li	$v0, 0
	jr	$ra
solver_rect.2762:
	li	$v0, 0
	li	$v1, 1
	li	$a2, 2
	swc1	$f12, 0($sp)
	swc1	$f14, -1($sp)
	swc1	$f13, -2($sp)
	sw	$a1, -3($sp)
	sw	$a0, -4($sp)
	move	$t8, $ra
	move	$t0, $a2
	move	$a3, $v1
	move	$a2, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	solver_rect_surface.2753
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8477
	li	$v0, 1
	li	$v1, 2
	li	$a0, 0
	lwc1	$f2, -2($sp)
	lwc1	$f3, -1($sp)
	lwc1	$f4, 0($sp)
	lw	$a1, -4($sp)
	lw	$a2, -3($sp)
	move	$t8, $ra
	move	$t0, $a0
	move	$a3, $v1
	move	$a0, $a1
	move	$a1, $a2
	move	$a2, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	solver_rect_surface.2753
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8478
	li	$v0, 2
	li	$v1, 0
	li	$a0, 1
	lwc1	$f2, -1($sp)
	lwc1	$f3, 0($sp)
	lwc1	$f4, -2($sp)
	lw	$a1, -4($sp)
	lw	$a2, -3($sp)
	move	$t8, $ra
	move	$t0, $a0
	move	$a3, $v1
	move	$a0, $a1
	move	$a1, $a2
	move	$a2, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	solver_rect_surface.2753
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8479
	li	$v0, 0
	jr	$ra
beq_else.8479:
	li	$v0, 3
	jr	$ra
beq_else.8478:
	li	$v0, 2
	jr	$ra
beq_else.8477:
	li	$v0, 1
	jr	$ra
solver_surface.2768:
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	swc1	$f12, -2($sp)
	sw	$a1, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_abc.2675
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	veciprod.2634
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fispos
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8480
	li	$v0, 0
	jr	$ra
beq_else.8480:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -2($sp)
	lwc1	$f3, -1($sp)
	lwc1	$f4, 0($sp)
	lw	$a0, -4($sp)
	sw	$v1, -6($sp)
	sw	$v0, -7($sp)
	move	$t8, $ra
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	veciprod2.2637
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_fneg
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	lw	$v0, -6($sp)
	lw	$v1, -7($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	jr	$ra
quadratic.2774:
	swc1	$f12, 0($sp)
	swc1	$f14, -1($sp)
	swc1	$f13, -2($sp)
	sw	$a0, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fsqr
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_param_a.2669
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -2($sp)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fsqr
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_param_b.2671
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -5($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, -1($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_fsqr
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_c.2673
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -7($sp)
	add.s	$f2, $f3, $f2
	lw	$v0, -3($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_isrot.2667
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8481
	lwc1	$f2, -9($sp)
	mov.s	$f0, $f2
	jr	$ra
beq_else.8481:
	lwc1	$f2, -1($sp)
	lwc1	$f3, -2($sp)
	mul.s	$f4, $f3, $f2
	lw	$v0, -3($sp)
	swc1	$f4, -10($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	o_param_r1.2693
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -10($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -9($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, 0($sp)
	lwc1	$f4, -1($sp)
	mul.s	$f4, $f4, $f3
	lw	$v0, -3($sp)
	swc1	$f2, -11($sp)
	swc1	$f4, -12($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	o_param_r2.2695
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -12($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -11($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, -2($sp)
	lwc1	$f4, 0($sp)
	mul.s	$f3, $f4, $f3
	lw	$v0, -3($sp)
	swc1	$f2, -13($sp)
	swc1	$f3, -14($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	o_param_r3.2697
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -14($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -13($sp)
	add.s	$f0, $f3, $f2
	jr	$ra
bilinear.2779:
	mul.s	$f2, $f12, $f15
	swc1	$f15, 0($sp)
	swc1	$f12, -1($sp)
	swc1	$f17, -2($sp)
	swc1	$f14, -3($sp)
	sw	$a0, -4($sp)
	swc1	$f16, -5($sp)
	swc1	$f13, -6($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_a.2669
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -5($sp)
	lwc1	$f4, -6($sp)
	mul.s	$f5, $f4, $f3
	lw	$v0, -4($sp)
	swc1	$f2, -8($sp)
	swc1	$f5, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_param_b.2671
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -8($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, -2($sp)
	lwc1	$f4, -3($sp)
	mul.s	$f5, $f4, $f3
	lw	$v0, -4($sp)
	swc1	$f2, -10($sp)
	swc1	$f5, -11($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_c.2673
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -11($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -10($sp)
	add.s	$f2, $f3, $f2
	lw	$v0, -4($sp)
	swc1	$f2, -12($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	o_isrot.2667
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8482
	lwc1	$f2, -12($sp)
	mov.s	$f0, $f2
	jr	$ra
beq_else.8482:
	lwc1	$f2, -5($sp)
	lwc1	$f3, -3($sp)
	mul.s	$f4, $f3, $f2
	lwc1	$f5, -2($sp)
	lwc1	$f6, -6($sp)
	mul.s	$f7, $f6, $f5
	add.s	$f4, $f4, $f7
	lw	$v0, -4($sp)
	swc1	$f4, -13($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	o_param_r1.2693
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -13($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -2($sp)
	lwc1	$f4, -1($sp)
	mul.s	$f3, $f4, $f3
	lwc1	$f5, 0($sp)
	lwc1	$f6, -3($sp)
	mul.s	$f6, $f6, $f5
	add.s	$f3, $f3, $f6
	lw	$v0, -4($sp)
	swc1	$f2, -14($sp)
	swc1	$f3, -15($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	o_param_r2.2695
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -15($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -14($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, -5($sp)
	lwc1	$f4, -1($sp)
	mul.s	$f3, $f4, $f3
	lwc1	$f4, 0($sp)
	lwc1	$f5, -6($sp)
	mul.s	$f4, $f5, $f4
	add.s	$f3, $f3, $f4
	lw	$v0, -4($sp)
	swc1	$f2, -16($sp)
	swc1	$f3, -17($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	o_param_r3.2697
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -17($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -16($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	min_caml_fhalf
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -12($sp)
	add.s	$f0, $f3, $f2
	jr	$ra
solver_second.2787:
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f2, 0($at)
	li	$v0, 1
	add	$at, $a1, $v0
	lwc1	$f3, 0($at)
	li	$v0, 2
	add	$at, $a1, $v0
	lwc1	$f4, 0($at)
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	swc1	$f12, -2($sp)
	sw	$a0, -3($sp)
	sw	$a1, -4($sp)
	move	$t8, $ra
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	quadratic.2774
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fiszero
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8483
	li	$v0, 0
	lw	$v1, -4($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	li	$v0, 1
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	lwc1	$f5, -2($sp)
	lwc1	$f6, -1($sp)
	lwc1	$f7, 0($sp)
	lw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f17, $f7
	mov.s	$f16, $f6
	mov.s	$f15, $f5
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	bilinear.2779
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	lwc1	$f4, -1($sp)
	lwc1	$f5, 0($sp)
	lw	$v0, -3($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f5
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	quadratic.2774
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_form.2661
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, 3
	bne	$v0, $v1, beq_else.8484
	lwc1	$f2, 0(l.6298)
	lwc1	$f3, -7($sp)
	sub.s	$f2, $f3, $f2
	j	beq_cont.8485
beq_else.8484:
	lwc1	$f2, -7($sp)
beq_cont.8485:
	lwc1	$f3, -6($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fsqr
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	lwc1	$f4, -5($sp)
	mul.s	$f3, $f4, $f3
	sub.s	$f2, $f2, $f3
	swc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fispos
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8486
	li	$v0, 0
	jr	$ra
beq_else.8486:
	lwc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_sqrt
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	swc1	$f2, -10($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	o_isinvert.2665
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8487
	lwc1	$f2, -10($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fneg
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	j	beq_cont.8488
beq_else.8487:
	lwc1	$f2, -10($sp)
beq_cont.8488:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f3, -6($sp)
	sub.s	$f2, $f2, $f3
	lwc1	$f3, -5($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 1
	jr	$ra
beq_else.8483:
	li	$v0, 0
	jr	$ra
solver.2793:
	li	$v0, min_caml_objects
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	li	$v1, 0
	add	$at, $a2, $v1
	lwc1	$f2, 0($at)
	sw	$a1, 0($sp)
	sw	$v0, -1($sp)
	sw	$a2, -2($sp)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_x.2677
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -4($sp)
	swc1	$f3, -5($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_y.2679
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 2
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -6($sp)
	swc1	$f3, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_z.2681
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -1($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_form.2661
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8489
	lwc1	$f2, -4($sp)
	lwc1	$f3, -6($sp)
	lwc1	$f4, -8($sp)
	lw	$v0, -1($sp)
	lw	$v1, 0($sp)
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_rect.2762
beq_else.8489:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8490
	lwc1	$f2, -4($sp)
	lwc1	$f3, -6($sp)
	lwc1	$f4, -8($sp)
	lw	$v0, -1($sp)
	lw	$v1, 0($sp)
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_surface.2768
beq_else.8490:
	lwc1	$f2, -4($sp)
	lwc1	$f3, -6($sp)
	lwc1	$f4, -8($sp)
	lw	$v0, -1($sp)
	lw	$v1, 0($sp)
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_second.2787
solver_rect_fast.2797:
	li	$v0, 0
	add	$at, $a2, $v0
	lwc1	$f2, 0($at)
	sub.s	$f2, $f2, $f12
	li	$v0, 1
	add	$at, $a2, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	li	$v0, 1
	add	$at, $a1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f2, $f3
	add.s	$f3, $f3, $f13
	swc1	$f12, 0($sp)
	swc1	$f13, -1($sp)
	sw	$a2, -2($sp)
	swc1	$f14, -3($sp)
	swc1	$f2, -4($sp)
	sw	$a1, -5($sp)
	sw	$a0, -6($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fabs
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_b.2671
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_fless
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8491
	li	$v0, 0
	j	beq_cont.8492
beq_else.8491:
	li	$v0, 2
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -3($sp)
	add.s	$f2, $f2, $f4
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_fabs
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_c.2673
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fless
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8493
	li	$v0, 0
	j	beq_cont.8494
beq_else.8493:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fiszero
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8495
	li	$v0, 1
	j	beq_cont.8496
beq_else.8495:
	li	$v0, 0
beq_cont.8496:
beq_cont.8494:
beq_cont.8492:
	li	$v1, 0
	bne	$v0, $v1, beq_else.8497
	li	$v0, 2
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -1($sp)
	sub.s	$f2, $f2, $f3
	li	$v0, 3
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	mul.s	$f2, $f2, $f4
	li	$v0, 0
	lw	$a0, -5($sp)
	add	$at, $a0, $v0
	lwc1	$f4, 0($at)
	mul.s	$f4, $f2, $f4
	lwc1	$f5, 0($sp)
	add.s	$f4, $f4, $f5
	swc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fabs
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -10($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	o_param_a.2669
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -10($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fless
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8498
	li	$v0, 0
	j	beq_cont.8499
beq_else.8498:
	li	$v0, 2
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -9($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -3($sp)
	add.s	$f2, $f2, $f4
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fabs
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -11($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_c.2673
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -11($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_fless
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8500
	li	$v0, 0
	j	beq_cont.8501
beq_else.8500:
	li	$v0, 3
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_fiszero
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8502
	li	$v0, 1
	j	beq_cont.8503
beq_else.8502:
	li	$v0, 0
beq_cont.8503:
beq_cont.8501:
beq_cont.8499:
	li	$v1, 0
	bne	$v0, $v1, beq_else.8504
	li	$v0, 4
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -3($sp)
	sub.s	$f2, $f2, $f3
	li	$v0, 5
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	li	$v0, 0
	lw	$a0, -5($sp)
	add	$at, $a0, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f2, $f3
	lwc1	$f4, 0($sp)
	add.s	$f3, $f3, $f4
	swc1	$f2, -12($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_fabs
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -13($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	o_param_a.2669
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -13($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fless
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8505
	li	$v0, 0
	j	beq_cont.8506
beq_else.8505:
	li	$v0, 1
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -12($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -1($sp)
	add.s	$f2, $f2, $f4
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fabs
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -14($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	o_param_b.2671
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -14($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	min_caml_fless
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8507
	li	$v0, 0
	j	beq_cont.8508
beq_else.8507:
	li	$v0, 5
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	min_caml_fiszero
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8509
	li	$v0, 1
	j	beq_cont.8510
beq_else.8509:
	li	$v0, 0
beq_cont.8510:
beq_cont.8508:
beq_cont.8506:
	li	$v1, 0
	bne	$v0, $v1, beq_else.8511
	li	$v0, 0
	jr	$ra
beq_else.8511:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -12($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 3
	jr	$ra
beq_else.8504:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -9($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 2
	jr	$ra
beq_else.8497:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -4($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 1
	jr	$ra
solver_surface_fast.2804:
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f2, 0($at)
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	swc1	$f12, -2($sp)
	sw	$a1, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fisneg
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8512
	li	$v0, 0
	jr	$ra
beq_else.8512:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	li	$a0, 1
	lw	$a1, -3($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	lwc1	$f3, -2($sp)
	mul.s	$f2, $f2, $f3
	li	$a0, 2
	add	$at, $a1, $a0
	lwc1	$f3, 0($at)
	lwc1	$f4, -1($sp)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	li	$a0, 3
	add	$at, $a1, $a0
	lwc1	$f3, 0($at)
	lwc1	$f4, 0($sp)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 1
	jr	$ra
solver_second_fast.2810:
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f2, 0($at)
	swc1	$f2, 0($sp)
	sw	$a0, -1($sp)
	swc1	$f14, -2($sp)
	swc1	$f13, -3($sp)
	swc1	$f12, -4($sp)
	sw	$a1, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fiszero
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8513
	li	$v0, 1
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	lwc1	$f5, -3($sp)
	mul.s	$f4, $f4, $f5
	add.s	$f2, $f2, $f4
	li	$v0, 3
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	lwc1	$f6, -2($sp)
	mul.s	$f4, $f4, $f6
	add.s	$f2, $f2, $f4
	lw	$v0, -1($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f6
	mov.s	$f13, $f5
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	quadratic.2774
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -1($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_form.2661
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, 3
	bne	$v0, $v1, beq_else.8514
	lwc1	$f2, 0(l.6298)
	lwc1	$f3, -7($sp)
	sub.s	$f2, $f3, $f2
	j	beq_cont.8515
beq_else.8514:
	lwc1	$f2, -7($sp)
beq_cont.8515:
	lwc1	$f3, -6($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fsqr
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	lwc1	$f4, 0($sp)
	mul.s	$f3, $f4, $f3
	sub.s	$f2, $f2, $f3
	swc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fispos
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8516
	li	$v0, 0
	jr	$ra
beq_else.8516:
	lw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_isinvert.2665
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8517
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -9($sp)
	sw	$v1, -10($sp)
	sw	$v0, -11($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_sqrt
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 4
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	lw	$v0, -10($sp)
	lw	$v1, -11($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8518
beq_else.8517:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -9($sp)
	sw	$v1, -12($sp)
	sw	$v0, -13($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_sqrt
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	add.s	$f2, $f3, $f2
	li	$v0, 4
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	lw	$v0, -12($sp)
	lw	$v1, -13($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8518:
	li	$v0, 1
	jr	$ra
beq_else.8513:
	li	$v0, 0
	jr	$ra
solver_fast.2816:
	li	$v0, min_caml_objects
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	li	$v1, 0
	add	$at, $a2, $v1
	lwc1	$f2, 0($at)
	sw	$a0, 0($sp)
	sw	$a1, -1($sp)
	sw	$v0, -2($sp)
	sw	$a2, -3($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_param_x.2677
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 1
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -2($sp)
	swc1	$f2, -5($sp)
	swc1	$f3, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_param_y.2679
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 2
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -2($sp)
	swc1	$f2, -7($sp)
	swc1	$f3, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_z.2681
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -1($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	d_const.2722
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	lw	$v1, -2($sp)
	sw	$v0, -10($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	o_form.2661
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8519
	lw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	d_vec.2720
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	lwc1	$f2, -5($sp)
	lwc1	$f3, -7($sp)
	lwc1	$f4, -9($sp)
	lw	$v1, -2($sp)
	lw	$a0, -10($sp)
	move	$a2, $a0
	move	$a1, $v0
	move	$a0, $v1
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_rect_fast.2797
beq_else.8519:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8520
	lwc1	$f2, -5($sp)
	lwc1	$f3, -7($sp)
	lwc1	$f4, -9($sp)
	lw	$v0, -2($sp)
	lw	$v1, -10($sp)
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_surface_fast.2804
beq_else.8520:
	lwc1	$f2, -5($sp)
	lwc1	$f3, -7($sp)
	lwc1	$f4, -9($sp)
	lw	$v0, -2($sp)
	lw	$v1, -10($sp)
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_second_fast.2810
solver_surface_fast2.2820:
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f2, 0($at)
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_fisneg
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8521
	li	$v0, 0
	jr	$ra
beq_else.8521:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	li	$a0, 0
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	li	$a0, 3
	lw	$a1, 0($sp)
	add	$at, $a1, $a0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 1
	jr	$ra
solver_second_fast2.2827:
	li	$v0, 0
	add	$at, $a1, $v0
	lwc1	$f2, 0($at)
	sw	$a0, 0($sp)
	swc1	$f2, -1($sp)
	sw	$a2, -2($sp)
	swc1	$f14, -3($sp)
	swc1	$f13, -4($sp)
	swc1	$f12, -5($sp)
	sw	$a1, -6($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fiszero
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8522
	li	$v0, 1
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, -5($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lwc1	$f4, -4($sp)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	li	$v0, 3
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lwc1	$f4, -3($sp)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	li	$v0, 3
	lw	$a0, -2($sp)
	add	$at, $a0, $v0
	lwc1	$f3, 0($at)
	swc1	$f2, -7($sp)
	swc1	$f3, -8($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fsqr
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	lwc1	$f4, -1($sp)
	mul.s	$f3, $f4, $f3
	sub.s	$f2, $f2, $f3
	swc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fispos
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8523
	li	$v0, 0
	jr	$ra
beq_else.8523:
	lw	$v0, 0($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_isinvert.2665
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8524
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -9($sp)
	sw	$v1, -10($sp)
	sw	$v0, -11($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_sqrt
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 4
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	lw	$v0, -10($sp)
	lw	$v1, -11($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8525
beq_else.8524:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	lwc1	$f2, -9($sp)
	sw	$v1, -12($sp)
	sw	$v0, -13($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_sqrt
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	add.s	$f2, $f3, $f2
	li	$v0, 4
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	lw	$v0, -12($sp)
	lw	$v1, -13($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8525:
	li	$v0, 1
	jr	$ra
beq_else.8522:
	li	$v0, 0
	jr	$ra
solver_fast2.2834:
	li	$v0, min_caml_objects
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	sw	$v0, 0($sp)
	sw	$a0, -1($sp)
	sw	$a1, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	o_param_ctbl.2699
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	lw	$v1, -2($sp)
	sw	$v0, -3($sp)
	swc1	$f4, -4($sp)
	swc1	$f3, -5($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	d_const.2722
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	lw	$v1, -1($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	lw	$v1, 0($sp)
	sw	$v0, -7($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_form.2661
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8526
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	d_vec.2720
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	lwc1	$f2, -6($sp)
	lwc1	$f3, -5($sp)
	lwc1	$f4, -4($sp)
	lw	$v1, 0($sp)
	lw	$a0, -7($sp)
	move	$a2, $a0
	move	$a1, $v0
	move	$a0, $v1
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_rect_fast.2797
beq_else.8526:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8527
	lwc1	$f2, -6($sp)
	lwc1	$f3, -5($sp)
	lwc1	$f4, -4($sp)
	lw	$v0, 0($sp)
	lw	$v1, -7($sp)
	lw	$a0, -3($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_surface_fast2.2820
beq_else.8527:
	lwc1	$f2, -6($sp)
	lwc1	$f3, -5($sp)
	lwc1	$f4, -4($sp)
	lw	$v0, 0($sp)
	lw	$v1, -7($sp)
	lw	$a0, -3($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	solver_second_fast2.2827
setup_rect_table.2837:
	li	$v0, 6
	lwc1	$f2, 0(l.6297)
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_create_float_array
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	sw	$v0, -2($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fiszero
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8528
	li	$v0, 0
	lw	$v1, 0($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_isinvert.2665
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	sw	$v0, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fisneg
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, -4($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	xor.2602
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_a.2669
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -5($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	fneg_cond.2607
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	lwc1	$f2, 0(l.6298)
	li	$a0, 0
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f3, 0($at)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8529
beq_else.8528:
	li	$v0, 1
	lwc1	$f2, 0(l.6297)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8529:
	li	$v0, 1
	lw	$a0, -1($sp)
	add	$at, $a0, $v0
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fiszero
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8530
	li	$v0, 2
	lw	$v1, 0($sp)
	sw	$v0, -6($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_isinvert.2665
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v1, 1
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	sw	$v0, -7($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	min_caml_fisneg
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	lw	$v1, -7($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	xor.2602
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	sw	$v0, -8($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_b.2671
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	fneg_cond.2607
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	lwc1	$f2, 0(l.6298)
	li	$a0, 1
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f3, 0($at)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8531
beq_else.8530:
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8531:
	li	$v0, 2
	lw	$a0, -1($sp)
	add	$at, $a0, $v0
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fiszero
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8532
	li	$v0, 4
	lw	$v1, 0($sp)
	sw	$v0, -9($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_isinvert.2665
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 2
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	sw	$v0, -10($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fisneg
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	lw	$v1, -10($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	xor.2602
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	sw	$v0, -11($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_c.2673
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -11($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	fneg_cond.2607
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -9($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 5
	lwc1	$f2, 0(l.6298)
	li	$a0, 2
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f3, 0($at)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8533
beq_else.8532:
	li	$v0, 5
	lwc1	$f2, 0(l.6297)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8533:
	move	$v0, $v1
	jr	$ra
setup_surface_table.2840:
	li	$v0, 4
	lwc1	$f2, 0(l.6297)
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_create_float_array
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	lw	$v1, 0($sp)
	sw	$v0, -2($sp)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_a.2669
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -4($sp)
	swc1	$f3, -5($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_b.2671
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -4($sp)
	add.s	$f2, $f3, $f2
	li	$v0, 2
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -6($sp)
	swc1	$f3, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_c.2673
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -6($sp)
	add.s	$f2, $f3, $f2
	swc1	$f2, -8($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fispos
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8534
	li	$v0, 0
	lwc1	$f2, 0(l.6297)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8535
beq_else.8534:
	li	$v0, 0
	lwc1	$f2, 0(l.6299)
	lwc1	$f3, -8($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	lw	$a0, 0($sp)
	sw	$v0, -9($sp)
	move	$t8, $ra
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_param_a.2669
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fneg
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -9($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	lw	$a0, 0($sp)
	sw	$v0, -10($sp)
	move	$t8, $ra
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	o_param_b.2671
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fneg
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -10($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	lw	$a0, 0($sp)
	sw	$v0, -11($sp)
	move	$t8, $ra
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_c.2673
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_fneg
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -11($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8535:
	move	$v0, $v1
	jr	$ra
setup_second_table.2843:
	li	$v0, 5
	lwc1	$f2, 0(l.6297)
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_create_float_array
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f3, 0($at)
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f4, 0($at)
	lw	$v1, 0($sp)
	sw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	quadratic.2774
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 0
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -3($sp)
	swc1	$f3, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_param_a.2669
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fneg
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -5($sp)
	swc1	$f3, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_param_b.2671
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fneg
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 2
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -7($sp)
	swc1	$f3, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_c.2673
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	mul.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fneg
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 0
	lw	$v1, -2($sp)
	lwc1	$f3, -3($sp)
	add	$at, $v1, $v0
	swc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_isrot.2667
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8536
	li	$v0, 1
	lw	$v1, -2($sp)
	lwc1	$f2, -5($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	lwc1	$f2, -7($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	lwc1	$f2, -9($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8537
beq_else.8536:
	li	$v0, 1
	li	$v1, 2
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	lw	$v1, 0($sp)
	sw	$v0, -10($sp)
	swc1	$f2, -11($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_r2.2695
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -11($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -12($sp)
	swc1	$f3, -13($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	o_param_r3.2697
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -13($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -12($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fhalf
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -10($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$a0, 2
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	lw	$a0, 0($sp)
	sw	$v0, -14($sp)
	swc1	$f2, -15($sp)
	move	$t8, $ra
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	o_param_r1.2693
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -15($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 0
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -16($sp)
	swc1	$f3, -17($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	o_param_r3.2697
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -17($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -16($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	min_caml_fhalf
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -14($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 3
	li	$a0, 1
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	lw	$a0, 0($sp)
	sw	$v0, -18($sp)
	swc1	$f2, -19($sp)
	move	$t8, $ra
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	o_param_r1.2693
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -19($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 0
	lw	$v1, -1($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -20($sp)
	swc1	$f3, -21($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -22($sp)
	addi	$sp, $sp, -23
	jal	o_param_r2.2695
	addi	$sp, $sp, 23
	lw	$t8, -22($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -21($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -20($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -22($sp)
	addi	$sp, $sp, -23
	jal	min_caml_fhalf
	addi	$sp, $sp, 23
	lw	$t8, -22($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -18($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8537:
	lwc1	$f2, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -22($sp)
	addi	$sp, $sp, -23
	jal	min_caml_fiszero
	addi	$sp, $sp, 23
	lw	$t8, -22($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8538
	li	$v0, 4
	lwc1	$f2, 0(l.6298)
	lwc1	$f3, -3($sp)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8539
beq_else.8538:
beq_cont.8539:
	lw	$v0, -2($sp)
	jr	$ra
iter_setup_dirvec_constants.2846:
	li	$v0, 0
	sub	$at, $v0, $a1
	bgtz	$at, ble_else.8540
	li	$v0, min_caml_objects
	add	$at, $v0, $a1
	lw	$v0, 0($at)
	sw	$a1, 0($sp)
	sw	$v0, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	d_const.2722
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	d_vec.2720
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -1($sp)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_form.2661
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8541
	lw	$v0, -4($sp)
	lw	$v1, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	setup_rect_table.2837
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -3($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	j	beq_cont.8542
beq_else.8541:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8543
	lw	$v0, -4($sp)
	lw	$v1, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	setup_surface_table.2840
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -3($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	j	beq_cont.8544
beq_else.8543:
	lw	$v0, -4($sp)
	lw	$v1, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	setup_second_table.2843
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -3($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
beq_cont.8544:
beq_cont.8542:
	li	$v0, 1
	sub	$v0, $v1, $v0
	lw	$v1, -2($sp)
	move	$a1, $v0
	move	$a0, $v1
	j	iter_setup_dirvec_constants.2846
ble_else.8540:
	jr	$ra
setup_dirvec_constants.2849:
	li	$v0, min_caml_n_objects
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	sub	$v0, $v0, $v1
	move	$a1, $v0
	j	iter_setup_dirvec_constants.2846
setup_startp_constants.2851:
	li	$v0, 0
	sub	$at, $v0, $a1
	bgtz	$at, ble_else.8546
	li	$v0, min_caml_objects
	add	$at, $v0, $a1
	lw	$v0, 0($at)
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	sw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	o_param_ctbl.2699
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_form.2661
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	li	$a0, 0
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	lw	$a0, -2($sp)
	sw	$v0, -4($sp)
	sw	$v1, -5($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_param_x.2677
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -5($sp)
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	li	$a0, 1
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	lw	$a0, -2($sp)
	sw	$v0, -7($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_y.2679
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -7($sp)
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	li	$a0, 2
	lw	$a1, -1($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	lw	$a0, -2($sp)
	sw	$v0, -9($sp)
	swc1	$f2, -10($sp)
	move	$t8, $ra
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	o_param_z.2681
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -10($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -9($sp)
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 2
	lw	$a0, -4($sp)
	bne	$a0, $v0, beq_else.8547
	li	$v0, 3
	lw	$a0, -2($sp)
	sw	$v0, -11($sp)
	move	$t8, $ra
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_abc.2675
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -3($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	li	$v1, 1
	add	$at, $a0, $v1
	lwc1	$f3, 0($at)
	li	$v1, 2
	add	$at, $a0, $v1
	lwc1	$f4, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	veciprod2.2637
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -11($sp)
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	j	beq_cont.8548
beq_else.8547:
	li	$v0, 2
	sub	$at, $a0, $v0
	bgtz	$at, beq_else.8549
	j	beq_cont.8550
beq_else.8549:
	li	$v0, 0
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	li	$v0, 1
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	quadratic.2774
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 3
	li	$v1, 3
	lw	$a0, -4($sp)
	bne	$a0, $v1, beq_else.8551
	lwc1	$f3, 0(l.6298)
	sub.s	$f2, $f2, $f3
	j	beq_cont.8552
beq_else.8551:
beq_cont.8552:
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8550:
beq_cont.8548:
	li	$v0, 1
	lw	$v1, 0($sp)
	sub	$v0, $v1, $v0
	lw	$v1, -1($sp)
	move	$a1, $v0
	move	$a0, $v1
	j	setup_startp_constants.2851
ble_else.8546:
	jr	$ra
setup_startp.2854:
	li	$v0, min_caml_startp_fast
	sw	$a0, 0($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	veccpy.2623
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v0, min_caml_n_objects
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	sub	$v0, $v0, $v1
	lw	$v1, 0($sp)
	move	$a1, $v0
	move	$a0, $v1
	j	setup_startp_constants.2851
is_rect_outside.2856:
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fabs
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -2($sp)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_a.2669
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fless
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8554
	li	$v0, 0
	j	beq_cont.8555
beq_else.8554:
	lwc1	$f2, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fabs
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -2($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_param_b.2671
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fless
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8556
	li	$v0, 0
	j	beq_cont.8557
beq_else.8556:
	lwc1	$f2, 0($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fabs
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -2($sp)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_c.2673
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fless
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
beq_cont.8557:
beq_cont.8555:
	li	$v1, 0
	bne	$v0, $v1, beq_else.8558
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_isinvert.2665
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8559
	li	$v0, 1
	jr	$ra
beq_else.8559:
	li	$v0, 0
	jr	$ra
beq_else.8558:
	lw	$v0, -2($sp)
	move	$a0, $v0
	j	o_isinvert.2665
is_plane_outside.2861:
	sw	$a0, 0($sp)
	swc1	$f14, -1($sp)
	swc1	$f13, -2($sp)
	swc1	$f12, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_abc.2675
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lwc1	$f2, -3($sp)
	lwc1	$f3, -2($sp)
	lwc1	$f4, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	veciprod2.2637
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, 0($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_isinvert.2665
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lwc1	$f2, -4($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fisneg
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	xor.2602
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8560
	li	$v0, 1
	jr	$ra
beq_else.8560:
	li	$v0, 0
	jr	$ra
is_second_outside.2866:
	sw	$a0, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	quadratic.2774
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, 0($sp)
	swc1	$f2, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_form.2661
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 3
	bne	$v0, $v1, beq_else.8561
	lwc1	$f2, 0(l.6298)
	lwc1	$f3, -1($sp)
	sub.s	$f2, $f3, $f2
	j	beq_cont.8562
beq_else.8561:
	lwc1	$f2, -1($sp)
beq_cont.8562:
	lw	$v0, 0($sp)
	swc1	$f2, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	o_isinvert.2665
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lwc1	$f2, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fisneg
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	xor.2602
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8563
	li	$v0, 1
	jr	$ra
beq_else.8563:
	li	$v0, 0
	jr	$ra
is_outside.2871:
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	sw	$a0, -2($sp)
	swc1	$f12, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_x.2677
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -2($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_param_y.2679
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -1($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -2($sp)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_z.2681
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -2($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_form.2661
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8564
	lwc1	$f2, -4($sp)
	lwc1	$f3, -5($sp)
	lwc1	$f4, -6($sp)
	lw	$v0, -2($sp)
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	is_rect_outside.2856
beq_else.8564:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8565
	lwc1	$f2, -4($sp)
	lwc1	$f3, -5($sp)
	lwc1	$f4, -6($sp)
	lw	$v0, -2($sp)
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	is_plane_outside.2861
beq_else.8565:
	lwc1	$f2, -4($sp)
	lwc1	$f3, -5($sp)
	lwc1	$f4, -6($sp)
	lw	$v0, -2($sp)
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	is_second_outside.2866
check_all_inside.2876:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	li	$v1, -1
	bne	$v0, $v1, beq_else.8566
	li	$v0, 1
	jr	$ra
beq_else.8566:
	li	$v1, min_caml_objects
	add	$at, $v1, $v0
	lw	$v0, 0($at)
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	swc1	$f12, -2($sp)
	sw	$a1, -3($sp)
	sw	$a0, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	is_outside.2871
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8567
	li	$v0, 1
	lw	$v1, -4($sp)
	add	$v0, $v1, $v0
	lwc1	$f2, -2($sp)
	lwc1	$f3, -1($sp)
	lwc1	$f4, 0($sp)
	lw	$v1, -3($sp)
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	check_all_inside.2876
beq_else.8567:
	li	$v0, 0
	jr	$ra
shadow_check_and_group.2882:
	lw	$v0, 1($gp)
	add	$at, $a1, $a0
	lw	$v1, 0($at)
	li	$a2, -1
	bne	$v1, $a2, beq_else.8568
	li	$v0, 0
	jr	$ra
beq_else.8568:
	add	$at, $a1, $a0
	lw	$v1, 0($at)
	li	$a2, min_caml_intersection_point
	sw	$a1, 0($sp)
	sw	$gp, -1($sp)
	sw	$a0, -2($sp)
	sw	$v1, -3($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	solver_fast.2816
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, min_caml_solver_dist
	li	$a0, 0
	add	$at, $v1, $a0
	lwc1	$f2, 0($at)
	li	$v1, 0
	swc1	$f2, -4($sp)
	bne	$v0, $v1, beq_else.8569
	li	$v0, 0
	j	beq_cont.8570
beq_else.8569:
	lwc1	$f3, 0(l.6613)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fless
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
beq_cont.8570:
	li	$v1, 0
	bne	$v0, $v1, beq_else.8571
	li	$v0, min_caml_objects
	lw	$v1, -3($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_isinvert.2665
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8572
	li	$v0, 0
	jr	$ra
beq_else.8572:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8571:
	lwc1	$f2, 0(l.6614)
	lwc1	$f3, -4($sp)
	add.s	$f2, $f3, $f2
	li	$v0, min_caml_light
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f2
	li	$v0, min_caml_intersection_point
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	add.s	$f3, $f3, $f4
	li	$v0, min_caml_light
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	mul.s	$f4, $f4, $f2
	li	$v0, min_caml_intersection_point
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f5, 0($at)
	add.s	$f4, $f4, $f5
	li	$v0, min_caml_light
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f5, 0($at)
	mul.s	$f2, $f5, $f2
	li	$v0, min_caml_intersection_point
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f5, 0($at)
	add.s	$f2, $f2, $f5
	li	$v0, 0
	lw	$v1, 0($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	check_all_inside.2876
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8573
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8573:
	li	$v0, 1
	jr	$ra
shadow_check_one_or_group.2885:
	lw	$v0, 1($gp)
	add	$at, $a1, $a0
	lw	$v1, 0($at)
	li	$a2, -1
	bne	$v1, $a2, beq_else.8574
	li	$v0, 0
	jr	$ra
beq_else.8574:
	li	$a2, min_caml_and_net
	add	$at, $a2, $v1
	lw	$v1, 0($at)
	li	$a2, 0
	sw	$a1, 0($sp)
	sw	$gp, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $a2
	move	$gp, $v0
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8575
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8575:
	li	$v0, 1
	jr	$ra
shadow_check_one_or_matrix.2888:
	lw	$v0, 2($gp)
	lw	$v1, 1($gp)
	add	$at, $a1, $a0
	lw	$a2, 0($at)
	li	$a3, 0
	add	$at, $a2, $a3
	lw	$a3, 0($at)
	li	$t0, -1
	bne	$a3, $t0, beq_else.8576
	li	$v0, 0
	jr	$ra
beq_else.8576:
	li	$t0, 99
	sw	$a2, 0($sp)
	sw	$v0, -1($sp)
	sw	$a1, -2($sp)
	sw	$gp, -3($sp)
	sw	$a0, -4($sp)
	bne	$a3, $t0, beq_else.8577
	li	$v0, 1
	j	beq_cont.8578
beq_else.8577:
	li	$t0, min_caml_intersection_point
	move	$t8, $ra
	move	$a2, $t0
	move	$a1, $v1
	move	$a0, $a3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	solver_fast.2816
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8579
	li	$v0, 0
	j	beq_cont.8580
beq_else.8579:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	lwc1	$f3, 0(l.6627)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fless
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8581
	li	$v0, 0
	j	beq_cont.8582
beq_else.8581:
	li	$v0, 1
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8583
	li	$v0, 0
	j	beq_cont.8584
beq_else.8583:
	li	$v0, 1
beq_cont.8584:
beq_cont.8582:
beq_cont.8580:
beq_cont.8578:
	li	$v1, 0
	bne	$v0, $v1, beq_else.8585
	li	$v0, 1
	lw	$v1, -4($sp)
	add	$v0, $v1, $v0
	lw	$v1, -2($sp)
	lw	$a0, -3($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8585:
	li	$v0, 1
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8586
	li	$v0, 1
	lw	$v1, -4($sp)
	add	$v0, $v1, $v0
	lw	$v1, -2($sp)
	lw	$a0, -3($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8586:
	li	$v0, 1
	jr	$ra
solve_each_element.2891:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	li	$v1, -1
	bne	$v0, $v1, beq_else.8587
	jr	$ra
beq_else.8587:
	li	$v1, min_caml_startp
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a1, $a2
	move	$a0, $v0
	move	$a2, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	solver.2793
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8589
	li	$v0, min_caml_objects
	lw	$v1, -3($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_isinvert.2665
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8590
	jr	$ra
beq_else.8590:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	solve_each_element.2891
beq_else.8589:
	li	$v1, min_caml_solver_dist
	li	$a0, 0
	add	$at, $v1, $a0
	lwc1	$f2, 0($at)
	lwc1	$f3, 0(l.6297)
	sw	$v0, -4($sp)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fless
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8592
	j	beq_cont.8593
beq_else.8592:
	li	$v0, min_caml_tmin
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	lwc1	$f3, -5($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fless
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8594
	j	beq_cont.8595
beq_else.8594:
	lwc1	$f2, 0(l.6614)
	lwc1	$f3, -5($sp)
	add.s	$f2, $f3, $f2
	li	$v0, 0
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f2
	li	$v0, min_caml_startp
	li	$a0, 0
	add	$at, $v0, $a0
	lwc1	$f4, 0($at)
	add.s	$f3, $f3, $f4
	li	$v0, 1
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	mul.s	$f4, $f4, $f2
	li	$v0, min_caml_startp
	li	$a0, 1
	add	$at, $v0, $a0
	lwc1	$f5, 0($at)
	add.s	$f4, $f4, $f5
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f5, 0($at)
	mul.s	$f5, $f5, $f2
	li	$v0, min_caml_startp
	li	$a0, 2
	add	$at, $v0, $a0
	lwc1	$f6, 0($at)
	add.s	$f5, $f5, $f6
	li	$v0, 0
	lw	$a0, -1($sp)
	swc1	$f5, -6($sp)
	swc1	$f4, -7($sp)
	swc1	$f3, -8($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	mov.s	$f14, $f5
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	check_all_inside.2876
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8596
	j	beq_cont.8597
beq_else.8596:
	li	$v0, min_caml_tmin
	li	$v1, 0
	lwc1	$f2, -9($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_intersection_point
	lwc1	$f2, -8($sp)
	lwc1	$f3, -7($sp)
	lwc1	$f4, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	vecset.2613
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v0, min_caml_intersected_object_id
	li	$v1, 0
	lw	$a0, -3($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	li	$v0, min_caml_intsec_rectside
	li	$v1, 0
	lw	$a0, -4($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
beq_cont.8597:
beq_cont.8595:
beq_cont.8593:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	solve_each_element.2891
solve_one_or_network.2895:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	li	$v1, -1
	bne	$v0, $v1, beq_else.8598
	jr	$ra
beq_else.8598:
	li	$v1, min_caml_and_net
	add	$at, $v1, $v0
	lw	$v0, 0($at)
	li	$v1, 0
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	solve_each_element.2891
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	solve_one_or_network.2895
trace_or_matrix.2899:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v1, 0($at)
	li	$a3, -1
	bne	$v1, $a3, beq_else.8600
	jr	$ra
beq_else.8600:
	li	$a3, 99
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	bne	$v1, $a3, beq_else.8602
	li	$v1, 1
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	solve_one_or_network.2895
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	j	beq_cont.8603
beq_else.8602:
	li	$a3, min_caml_startp
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a1, $a2
	move	$a0, $v1
	move	$a2, $a3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	solver.2793
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8604
	j	beq_cont.8605
beq_else.8604:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	li	$v0, min_caml_tmin
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fless
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8606
	j	beq_cont.8607
beq_else.8606:
	li	$v0, 1
	lw	$v1, -3($sp)
	lw	$a0, 0($sp)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	solve_one_or_network.2895
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8607:
beq_cont.8605:
beq_cont.8603:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	trace_or_matrix.2899
judge_intersection.2903:
	li	$v0, min_caml_tmin
	li	$v1, 0
	lwc1	$f2, 0(l.6647)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 0
	li	$v1, min_caml_or_net
	li	$a1, 0
	add	$at, $v1, $a1
	lw	$v1, 0($at)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	trace_or_matrix.2899
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_tmin
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	lwc1	$f3, 0(l.6627)
	swc1	$f2, 0($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_fless
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8608
	li	$v0, 0
	jr	$ra
beq_else.8608:
	lwc1	$f2, 0(l.6651)
	lwc1	$f3, 0($sp)
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	j	min_caml_fless
solve_each_element_fast.2905:
	sw	$a2, 0($sp)
	sw	$a0, -1($sp)
	sw	$a1, -2($sp)
	move	$t8, $ra
	move	$a0, $a2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	d_vec.2720
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, -1($sp)
	lw	$a0, -2($sp)
	add	$at, $a0, $v1
	lw	$a1, 0($at)
	li	$a2, -1
	bne	$a1, $a2, beq_else.8609
	jr	$ra
beq_else.8609:
	lw	$a2, 0($sp)
	sw	$v0, -3($sp)
	sw	$a1, -4($sp)
	move	$t8, $ra
	move	$a0, $a1
	move	$a1, $a2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	solver_fast2.2834
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8611
	li	$v0, min_caml_objects
	lw	$v1, -4($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_isinvert.2665
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8612
	jr	$ra
beq_else.8612:
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$v0, $v1, $v0
	lw	$v1, -2($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	solve_each_element_fast.2905
beq_else.8611:
	li	$v1, min_caml_solver_dist
	li	$a0, 0
	add	$at, $v1, $a0
	lwc1	$f2, 0($at)
	lwc1	$f3, 0(l.6297)
	sw	$v0, -5($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fless
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8614
	j	beq_cont.8615
beq_else.8614:
	li	$v0, min_caml_tmin
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	lwc1	$f3, -6($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fless
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8616
	j	beq_cont.8617
beq_else.8616:
	lwc1	$f2, 0(l.6614)
	lwc1	$f3, -6($sp)
	add.s	$f2, $f3, $f2
	li	$v0, 0
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	mul.s	$f3, $f3, $f2
	li	$v0, min_caml_startp_fast
	li	$a0, 0
	add	$at, $v0, $a0
	lwc1	$f4, 0($at)
	add.s	$f3, $f3, $f4
	li	$v0, 1
	add	$at, $v1, $v0
	lwc1	$f4, 0($at)
	mul.s	$f4, $f4, $f2
	li	$v0, min_caml_startp_fast
	li	$a0, 1
	add	$at, $v0, $a0
	lwc1	$f5, 0($at)
	add.s	$f4, $f4, $f5
	li	$v0, 2
	add	$at, $v1, $v0
	lwc1	$f5, 0($at)
	mul.s	$f5, $f5, $f2
	li	$v0, min_caml_startp_fast
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f6, 0($at)
	add.s	$f5, $f5, $f6
	li	$v0, 0
	lw	$v1, -2($sp)
	swc1	$f5, -7($sp)
	swc1	$f4, -8($sp)
	swc1	$f3, -9($sp)
	swc1	$f2, -10($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f14, $f5
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	check_all_inside.2876
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8618
	j	beq_cont.8619
beq_else.8618:
	li	$v0, min_caml_tmin
	li	$v1, 0
	lwc1	$f2, -10($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_intersection_point
	lwc1	$f2, -9($sp)
	lwc1	$f3, -8($sp)
	lwc1	$f4, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	vecset.2613
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v0, min_caml_intersected_object_id
	li	$v1, 0
	lw	$a0, -4($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	li	$v0, min_caml_intsec_rectside
	li	$v1, 0
	lw	$a0, -5($sp)
	add	$at, $v0, $v1
	sw	$a0, 0($at)
beq_cont.8619:
beq_cont.8617:
beq_cont.8615:
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$v0, $v1, $v0
	lw	$v1, -2($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	solve_each_element_fast.2905
solve_one_or_network_fast.2909:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	li	$v1, -1
	bne	$v0, $v1, beq_else.8620
	jr	$ra
beq_else.8620:
	li	$v1, min_caml_and_net
	add	$at, $v1, $v0
	lw	$v0, 0($at)
	li	$v1, 0
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	solve_each_element_fast.2905
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	solve_one_or_network_fast.2909
trace_or_matrix_fast.2913:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v1, 0($at)
	li	$a3, -1
	bne	$v1, $a3, beq_else.8622
	jr	$ra
beq_else.8622:
	li	$a3, 99
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	bne	$v1, $a3, beq_else.8624
	li	$v1, 1
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	solve_one_or_network_fast.2909
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	j	beq_cont.8625
beq_else.8624:
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a1, $a2
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	solver_fast2.2834
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8626
	j	beq_cont.8627
beq_else.8626:
	li	$v0, min_caml_solver_dist
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	li	$v0, min_caml_tmin
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fless
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8628
	j	beq_cont.8629
beq_else.8628:
	li	$v0, 1
	lw	$v1, -3($sp)
	lw	$a0, 0($sp)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	solve_one_or_network_fast.2909
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8629:
beq_cont.8627:
beq_cont.8625:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	trace_or_matrix_fast.2913
judge_intersection_fast.2917:
	li	$v0, min_caml_tmin
	li	$v1, 0
	lwc1	$f2, 0(l.6647)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, 0
	li	$v1, min_caml_or_net
	li	$a1, 0
	add	$at, $v1, $a1
	lw	$v1, 0($at)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	trace_or_matrix_fast.2913
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_tmin
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	lwc1	$f3, 0(l.6627)
	swc1	$f2, 0($sp)
	move	$t8, $ra
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_fless
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8630
	li	$v0, 0
	jr	$ra
beq_else.8630:
	lwc1	$f2, 0(l.6651)
	lwc1	$f3, 0($sp)
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	j	min_caml_fless
get_nvector_rect.2919:
	li	$v0, min_caml_intsec_rectside
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, min_caml_nvector
	sw	$a0, 0($sp)
	sw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	vecbzero.2621
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v0, min_caml_nvector
	li	$v1, 1
	lw	$a0, -1($sp)
	sub	$v1, $a0, $v1
	li	$a1, 1
	sub	$a0, $a0, $a1
	lw	$a1, 0($sp)
	add	$at, $a1, $a0
	lwc1	$f2, 0($at)
	sw	$v1, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	sgn.2605
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fneg
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -2($sp)
	lw	$v1, -3($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	jr	$ra
get_nvector_plane.2921:
	li	$v0, min_caml_nvector
	li	$v1, 0
	sw	$a0, 0($sp)
	sw	$v1, -1($sp)
	sw	$v0, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	o_param_a.2669
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fneg
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -1($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_nvector
	li	$v1, 1
	lw	$a0, 0($sp)
	sw	$v1, -3($sp)
	sw	$v0, -4($sp)
	move	$t8, $ra
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_param_b.2671
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fneg
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	lw	$v1, -4($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_nvector
	li	$v1, 2
	lw	$a0, 0($sp)
	sw	$v1, -5($sp)
	sw	$v0, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_param_c.2673
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fneg
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -5($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	jr	$ra
get_nvector_second.2923:
	li	$v0, min_caml_intersection_point
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	sw	$a0, 0($sp)
	swc1	$f2, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_param_x.2677
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -1($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, min_caml_intersection_point
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -2($sp)
	swc1	$f3, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_param_y.2679
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, min_caml_intersection_point
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	lw	$v0, 0($sp)
	swc1	$f2, -4($sp)
	swc1	$f3, -5($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_z.2681
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_param_a.2669
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	mul.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_b.2671
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -8($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_param_c.2673
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_isrot.2667
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8633
	li	$v0, min_caml_nvector
	li	$v1, 0
	lwc1	$f2, -7($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_nvector
	li	$v1, 1
	lwc1	$f2, -8($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_nvector
	li	$v1, 2
	lwc1	$f2, -9($sp)
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	j	beq_cont.8634
beq_else.8633:
	li	$v0, min_caml_nvector
	li	$v1, 0
	lw	$a0, 0($sp)
	sw	$v1, -10($sp)
	sw	$v0, -11($sp)
	move	$t8, $ra
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_r3.2697
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -12($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	o_param_r2.2695
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f4, -12($sp)
	add.s	$f2, $f4, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_fhalf
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	add.s	$f2, $f3, $f2
	lw	$v0, -10($sp)
	lw	$v1, -11($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_nvector
	li	$v1, 1
	lw	$a0, 0($sp)
	sw	$v1, -13($sp)
	sw	$v0, -14($sp)
	move	$t8, $ra
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	o_param_r3.2697
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	mul.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -15($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	o_param_r1.2693
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -15($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	min_caml_fhalf
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	add.s	$f2, $f3, $f2
	lw	$v0, -13($sp)
	lw	$v1, -14($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_nvector
	li	$v1, 2
	lw	$a0, 0($sp)
	sw	$v1, -16($sp)
	sw	$v0, -17($sp)
	move	$t8, $ra
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	o_param_r2.2695
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	mul.s	$f2, $f3, $f2
	lw	$v0, 0($sp)
	swc1	$f2, -18($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	o_param_r1.2693
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -18($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	min_caml_fhalf
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	add.s	$f2, $f3, $f2
	lw	$v0, -16($sp)
	lw	$v1, -17($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
beq_cont.8634:
	li	$v0, min_caml_nvector
	lw	$v1, 0($sp)
	sw	$v0, -19($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	o_isinvert.2665
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	move	$ra, $t8
	lw	$v1, -19($sp)
	move	$a1, $v0
	move	$a0, $v1
	j	vecunit_sgn.2631
get_nvector.2925:
	sw	$a0, 0($sp)
	sw	$a1, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_form.2661
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8635
	lw	$v0, -1($sp)
	move	$a0, $v0
	j	get_nvector_rect.2919
beq_else.8635:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8636
	lw	$v0, 0($sp)
	move	$a0, $v0
	j	get_nvector_plane.2921
beq_else.8636:
	lw	$v0, 0($sp)
	move	$a0, $v0
	j	get_nvector_second.2923
utexture.2928:
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_texturetype.2659
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, min_caml_texture_color
	li	$a0, 0
	lw	$a1, -1($sp)
	sw	$v0, -2($sp)
	sw	$a0, -3($sp)
	sw	$v1, -4($sp)
	move	$t8, $ra
	move	$a0, $a1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	o_color_red.2687
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -3($sp)
	lw	$v1, -4($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_texture_color
	li	$v1, 1
	lw	$a0, -1($sp)
	sw	$v1, -5($sp)
	sw	$v0, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_color_green.2689
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -5($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, min_caml_texture_color
	li	$v1, 2
	lw	$a0, -1($sp)
	sw	$v1, -7($sp)
	sw	$v0, -8($sp)
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	o_color_blue.2691
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -7($sp)
	lw	$v1, -8($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	li	$v0, 1
	lw	$v1, -2($sp)
	bne	$v1, $v0, beq_else.8637
	li	$v0, 0
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_param_x.2677
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6714)
	mul.s	$f3, $f2, $f3
	swc1	$f2, -10($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_floor
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6715)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, -10($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6706)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fless
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	li	$v1, 2
	lw	$a0, 0($sp)
	add	$at, $a0, $v1
	lwc1	$f2, 0($at)
	lw	$v1, -1($sp)
	sw	$v0, -11($sp)
	swc1	$f2, -12($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	o_param_z.2681
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -12($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6714)
	mul.s	$f3, $f2, $f3
	swc1	$f2, -13($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_floor
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6715)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, -13($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6706)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fless
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	li	$v1, min_caml_texture_color
	li	$a0, 1
	li	$a1, 0
	lw	$a2, -11($sp)
	bne	$a2, $a1, beq_else.8638
	li	$a1, 0
	bne	$v0, $a1, beq_else.8640
	lwc1	$f2, 0(l.6701)
	j	beq_cont.8641
beq_else.8640:
	lwc1	$f2, 0(l.6297)
beq_cont.8641:
	j	beq_cont.8639
beq_else.8638:
	li	$a1, 0
	bne	$v0, $a1, beq_else.8642
	lwc1	$f2, 0(l.6297)
	j	beq_cont.8643
beq_else.8642:
	lwc1	$f2, 0(l.6701)
beq_cont.8643:
beq_cont.8639:
	add	$at, $v1, $a0
	swc1	$f2, 0($at)
	jr	$ra
beq_else.8637:
	li	$v0, 2
	bne	$v1, $v0, beq_else.8645
	li	$v0, 1
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lwc1	$f3, 0(l.6710)
	mul.s	$f2, $f2, $f3
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_sin
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fsqr
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_texture_color
	li	$v1, 0
	lwc1	$f3, 0(l.6701)
	mul.s	$f3, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_texture_color
	li	$v1, 1
	lwc1	$f3, 0(l.6701)
	lwc1	$f4, 0(l.6298)
	sub.s	$f2, $f4, $f2
	mul.s	$f2, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	jr	$ra
beq_else.8645:
	li	$v0, 3
	bne	$v1, $v0, beq_else.8647
	li	$v0, 0
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -14($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	o_param_x.2677
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -14($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 2
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -15($sp)
	swc1	$f3, -16($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	o_param_z.2681
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -16($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, -15($sp)
	swc1	$f2, -17($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	min_caml_fsqr
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -17($sp)
	swc1	$f2, -18($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	min_caml_fsqr
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -18($sp)
	add.s	$f2, $f3, $f2
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	min_caml_sqrt
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6706)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	swc1	$f2, -19($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	min_caml_floor
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -19($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6697)
	mul.s	$f2, $f2, $f3
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	min_caml_cos
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	min_caml_fsqr
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_texture_color
	li	$v1, 1
	lwc1	$f3, 0(l.6701)
	mul.s	$f3, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_texture_color
	li	$v1, 2
	lwc1	$f3, 0(l.6298)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6701)
	mul.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	jr	$ra
beq_else.8647:
	li	$v0, 4
	bne	$v1, $v0, beq_else.8649
	li	$v0, 0
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f2, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -20($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -21($sp)
	addi	$sp, $sp, -22
	jal	o_param_x.2677
	addi	$sp, $sp, 22
	lw	$t8, -21($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -20($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -1($sp)
	swc1	$f2, -21($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -22($sp)
	addi	$sp, $sp, -23
	jal	o_param_a.2669
	addi	$sp, $sp, 23
	lw	$t8, -22($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -22($sp)
	addi	$sp, $sp, -23
	jal	min_caml_sqrt
	addi	$sp, $sp, 23
	lw	$t8, -22($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -21($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 2
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -22($sp)
	swc1	$f3, -23($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -24($sp)
	addi	$sp, $sp, -25
	jal	o_param_z.2681
	addi	$sp, $sp, 25
	lw	$t8, -24($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -23($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -1($sp)
	swc1	$f2, -24($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -25($sp)
	addi	$sp, $sp, -26
	jal	o_param_c.2673
	addi	$sp, $sp, 26
	lw	$t8, -25($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -25($sp)
	addi	$sp, $sp, -26
	jal	min_caml_sqrt
	addi	$sp, $sp, 26
	lw	$t8, -25($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -24($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -22($sp)
	swc1	$f2, -25($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -26($sp)
	addi	$sp, $sp, -27
	jal	min_caml_fsqr
	addi	$sp, $sp, 27
	lw	$t8, -26($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -25($sp)
	swc1	$f2, -26($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -27($sp)
	addi	$sp, $sp, -28
	jal	min_caml_fsqr
	addi	$sp, $sp, 28
	lw	$t8, -27($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -26($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, -22($sp)
	swc1	$f2, -27($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	min_caml_fabs
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6694)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	min_caml_fless
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8650
	lwc1	$f2, -22($sp)
	lwc1	$f3, -25($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	min_caml_fabs
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -28($sp)
	addi	$sp, $sp, -29
	jal	min_caml_atan
	addi	$sp, $sp, 29
	lw	$t8, -28($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6696)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, 0(l.6697)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	j	beq_cont.8651
beq_else.8650:
	lwc1	$f2, 0(l.6695)
beq_cont.8651:
	swc1	$f2, -28($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -29($sp)
	addi	$sp, $sp, -30
	jal	min_caml_floor
	addi	$sp, $sp, 30
	lw	$t8, -29($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -28($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, 1
	lw	$v1, 0($sp)
	add	$at, $v1, $v0
	lwc1	$f3, 0($at)
	lw	$v0, -1($sp)
	swc1	$f2, -29($sp)
	swc1	$f3, -30($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -31($sp)
	addi	$sp, $sp, -32
	jal	o_param_y.2679
	addi	$sp, $sp, 32
	lw	$t8, -31($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -30($sp)
	sub.s	$f2, $f3, $f2
	lw	$v0, -1($sp)
	swc1	$f2, -31($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -32($sp)
	addi	$sp, $sp, -33
	jal	o_param_b.2671
	addi	$sp, $sp, 33
	lw	$t8, -32($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -32($sp)
	addi	$sp, $sp, -33
	jal	min_caml_sqrt
	addi	$sp, $sp, 33
	lw	$t8, -32($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -31($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -27($sp)
	swc1	$f2, -32($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -33($sp)
	addi	$sp, $sp, -34
	jal	min_caml_fabs
	addi	$sp, $sp, 34
	lw	$t8, -33($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6694)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -33($sp)
	addi	$sp, $sp, -34
	jal	min_caml_fless
	addi	$sp, $sp, 34
	lw	$t8, -33($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8652
	lwc1	$f2, -27($sp)
	lwc1	$f3, -32($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -33($sp)
	addi	$sp, $sp, -34
	jal	min_caml_fabs
	addi	$sp, $sp, 34
	lw	$t8, -33($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -33($sp)
	addi	$sp, $sp, -34
	jal	min_caml_atan
	addi	$sp, $sp, 34
	lw	$t8, -33($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6696)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, 0(l.6697)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	j	beq_cont.8653
beq_else.8652:
	lwc1	$f2, 0(l.6695)
beq_cont.8653:
	swc1	$f2, -33($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -34($sp)
	addi	$sp, $sp, -35
	jal	min_caml_floor
	addi	$sp, $sp, 35
	lw	$t8, -34($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -33($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6699)
	lwc1	$f4, 0(l.6700)
	lwc1	$f5, -29($sp)
	sub.s	$f4, $f4, $f5
	swc1	$f2, -34($sp)
	swc1	$f3, -35($sp)
	move	$t8, $ra
	mov.s	$f12, $f4
	sw	$t8, -36($sp)
	addi	$sp, $sp, -37
	jal	min_caml_fsqr
	addi	$sp, $sp, 37
	lw	$t8, -36($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -35($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6700)
	lwc1	$f4, -34($sp)
	sub.s	$f3, $f3, $f4
	swc1	$f2, -36($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -37($sp)
	addi	$sp, $sp, -38
	jal	min_caml_fsqr
	addi	$sp, $sp, 38
	lw	$t8, -37($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -36($sp)
	sub.s	$f2, $f3, $f2
	swc1	$f2, -37($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -38($sp)
	addi	$sp, $sp, -39
	jal	min_caml_fisneg
	addi	$sp, $sp, 39
	lw	$t8, -38($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8654
	lwc1	$f2, -37($sp)
	j	beq_cont.8655
beq_else.8654:
	lwc1	$f2, 0(l.6297)
beq_cont.8655:
	li	$v0, min_caml_texture_color
	li	$v1, 2
	lwc1	$f3, 0(l.6701)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6702)
	inv.s	$at, $f3
	mul.s	$f2, $f2, $at
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	jr	$ra
beq_else.8649:
	jr	$ra
add_light.2931:
	swc1	$f14, 0($sp)
	swc1	$f13, -1($sp)
	swc1	$f12, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fispos
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8658
	j	beq_cont.8659
beq_else.8658:
	li	$v0, min_caml_rgb
	li	$v1, min_caml_texture_color
	lwc1	$f2, -2($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	vecaccum.2642
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
beq_cont.8659:
	lwc1	$f2, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fispos
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8660
	jr	$ra
beq_else.8660:
	lwc1	$f2, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fsqr
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_fsqr
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_rgb
	li	$v1, 0
	li	$a0, min_caml_rgb
	li	$a1, 0
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	add.s	$f3, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_rgb
	li	$v1, 1
	li	$a0, min_caml_rgb
	li	$a1, 1
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	add.s	$f3, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_rgb
	li	$v1, 2
	li	$a0, min_caml_rgb
	li	$a1, 2
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	add.s	$f2, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	jr	$ra
trace_reflections.2935:
	lw	$v0, 1($gp)
	li	$v1, 0
	sub	$at, $v1, $a0
	bgtz	$at, ble_else.8663
	li	$v1, min_caml_reflections
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	sw	$gp, 0($sp)
	sw	$a0, -1($sp)
	swc1	$f13, -2($sp)
	sw	$a1, -3($sp)
	swc1	$f12, -4($sp)
	sw	$v0, -5($sp)
	sw	$v1, -6($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	r_dvec.2726
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	sw	$v0, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	judge_intersection_fast.2917
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8664
	j	beq_cont.8665
beq_else.8664:
	li	$v0, min_caml_intersected_object_id
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 4
	sll	$v0, $v0, 2
	li	$v1, min_caml_intsec_rectside
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	add	$v0, $v0, $v1
	lw	$v1, -6($sp)
	sw	$v0, -8($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	r_surface_id.2724
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v1, -8($sp)
	bne	$v1, $v0, beq_else.8666
	li	$v0, 0
	li	$v1, min_caml_or_net
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	lw	$a0, -5($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8668
	li	$v0, min_caml_nvector
	lw	$v1, -7($sp)
	sw	$v0, -9($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	d_vec.2720
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v1, -9($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	veciprod.2634
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lw	$v0, -6($sp)
	swc1	$f2, -10($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	r_bright.2728
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	mul.s	$f4, $f2, $f3
	lwc1	$f5, -10($sp)
	mul.s	$f4, $f4, $f5
	lw	$v0, -7($sp)
	swc1	$f4, -11($sp)
	swc1	$f2, -12($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	d_vec.2720
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	veciprod.2634
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -12($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -11($sp)
	lwc1	$f4, -2($sp)
	move	$t8, $ra
	mov.s	$f14, $f4
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	add_light.2931
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	move	$ra, $t8
	j	beq_cont.8669
beq_else.8668:
beq_cont.8669:
	j	beq_cont.8667
beq_else.8666:
beq_cont.8667:
beq_cont.8665:
	li	$v0, 1
	lw	$v1, -1($sp)
	sub	$v0, $v1, $v0
	lwc1	$f2, -4($sp)
	lwc1	$f3, -2($sp)
	lw	$v1, -3($sp)
	lw	$a0, 0($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	lw	$t8, 0($gp)
	jr	$t8
ble_else.8663:
	jr	$ra
trace_ray.2940:
	lw	$v0, 2($gp)
	lw	$v1, 1($gp)
	li	$a3, 4
	sub	$at, $a0, $a3
	bgtz	$at, ble_else.8671
	sw	$gp, 0($sp)
	swc1	$f13, -1($sp)
	sw	$v0, -2($sp)
	sw	$v1, -3($sp)
	sw	$a2, -4($sp)
	swc1	$f12, -5($sp)
	sw	$a0, -6($sp)
	sw	$a1, -7($sp)
	move	$t8, $ra
	move	$a0, $a2
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	p_surface_ids.2705
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	lw	$v1, -7($sp)
	sw	$v0, -8($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	judge_intersection.2903
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8672
	li	$v0, -1
	lw	$v1, -6($sp)
	lw	$a0, -8($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, 0
	bne	$v1, $v0, beq_else.8673
	jr	$ra
beq_else.8673:
	li	$v0, min_caml_light
	lw	$v1, -7($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	veciprod.2634
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	min_caml_fneg
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fispos
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8675
	jr	$ra
beq_else.8675:
	lwc1	$f2, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fsqr
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, -5($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_beam
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_rgb
	li	$v1, 0
	li	$a0, min_caml_rgb
	li	$a1, 0
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	add.s	$f3, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_rgb
	li	$v1, 1
	li	$a0, min_caml_rgb
	li	$a1, 1
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	add.s	$f3, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_rgb
	li	$v1, 2
	li	$a0, min_caml_rgb
	li	$a1, 2
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	add.s	$f2, $f3, $f2
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	jr	$ra
beq_else.8672:
	li	$v0, min_caml_intersected_object_id
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, min_caml_objects
	add	$at, $v1, $v0
	lw	$v1, 0($at)
	sw	$v0, -10($sp)
	sw	$v1, -11($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_reflectiontype.2663
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	lw	$v1, -11($sp)
	sw	$v0, -12($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	o_diffuse.2683
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	mul.s	$f2, $f2, $f3
	lw	$v0, -11($sp)
	lw	$v1, -7($sp)
	swc1	$f2, -13($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	get_nvector.2925
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	li	$v0, min_caml_startp
	li	$v1, min_caml_intersection_point
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	veccpy.2623
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	li	$v0, min_caml_intersection_point
	lw	$v1, -11($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	utexture.2928
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	li	$v0, 4
	lw	$v1, -10($sp)
	sll	$v0, $v1, 2
	li	$v1, min_caml_intsec_rectside
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	add	$v0, $v0, $v1
	lw	$v1, -6($sp)
	lw	$a0, -8($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	lw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	p_intersection_points.2703
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	lw	$v1, -6($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, min_caml_intersection_point
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	veccpy.2623
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	lw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	p_calc_diffuse.2707
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	move	$ra, $t8
	lw	$v1, -11($sp)
	sw	$v0, -14($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	o_diffuse.2683
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6700)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	min_caml_fless
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8678
	li	$v0, 1
	lw	$v1, -6($sp)
	lw	$a0, -14($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	lw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	p_energy.2709
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	move	$ra, $t8
	lw	$v1, -6($sp)
	add	$at, $v0, $v1
	lw	$a0, 0($at)
	li	$a1, min_caml_texture_color
	sw	$v0, -15($sp)
	move	$t8, $ra
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	veccpy.2623
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	move	$ra, $t8
	lw	$v0, -6($sp)
	lw	$v1, -15($sp)
	add	$at, $v1, $v0
	lw	$v1, 0($at)
	lwc1	$f2, 0(l.6737)
	lwc1	$f3, -13($sp)
	mul.s	$f2, $f2, $f3
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	vecscale.2652
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	move	$ra, $t8
	lw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	p_nvectors.2718
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	move	$ra, $t8
	lw	$v1, -6($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, min_caml_nvector
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	veccpy.2623
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	move	$ra, $t8
	j	beq_cont.8679
beq_else.8678:
	li	$v0, 0
	lw	$v1, -6($sp)
	lw	$a0, -14($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
beq_cont.8679:
	lwc1	$f2, 0(l.6739)
	li	$v0, min_caml_nvector
	lw	$v1, -7($sp)
	swc1	$f2, -16($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	veciprod.2634
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -16($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, min_caml_nvector
	lw	$v1, -7($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	vecaccum.2642
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	move	$ra, $t8
	lw	$v0, -11($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	o_hilight.2685
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 0
	li	$v1, min_caml_or_net
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	lw	$a0, -3($sp)
	swc1	$f2, -17($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8680
	li	$v0, min_caml_nvector
	li	$v1, min_caml_light
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	veciprod.2634
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	min_caml_fneg
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -13($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_light
	lw	$v1, -7($sp)
	swc1	$f2, -18($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	veciprod.2634
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	min_caml_fneg
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -18($sp)
	lwc1	$f4, -17($sp)
	move	$t8, $ra
	mov.s	$f14, $f4
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	add_light.2931
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	move	$ra, $t8
	j	beq_cont.8681
beq_else.8680:
beq_cont.8681:
	li	$v0, min_caml_intersection_point
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	setup_startp.2854
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	move	$ra, $t8
	li	$v0, min_caml_n_reflections
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	sub	$v0, $v0, $v1
	lwc1	$f2, -13($sp)
	lwc1	$f3, -17($sp)
	lw	$v1, -7($sp)
	lw	$a0, -2($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	move	$ra, $t8
	lwc1	$f2, 0(l.6742)
	lwc1	$f3, -5($sp)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -19($sp)
	addi	$sp, $sp, -20
	jal	min_caml_fless
	addi	$sp, $sp, 20
	lw	$t8, -19($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8682
	jr	$ra
beq_else.8682:
	li	$v0, 4
	lw	$v1, -6($sp)
	sub	$at, $v0, $v1
	bgtz	$at, beq_else.8684
	j	beq_cont.8685
beq_else.8684:
	li	$v0, 1
	add	$v0, $v1, $v0
	li	$a0, -1
	lw	$a1, -8($sp)
	add	$at, $a1, $v0
	sw	$a0, 0($at)
beq_cont.8685:
	li	$v0, 2
	lw	$a0, -12($sp)
	bne	$a0, $v0, beq_else.8686
	lwc1	$f2, 0(l.6298)
	lw	$v0, -11($sp)
	swc1	$f2, -19($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -20($sp)
	addi	$sp, $sp, -21
	jal	o_diffuse.2683
	addi	$sp, $sp, 21
	lw	$t8, -20($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -19($sp)
	sub.s	$f2, $f3, $f2
	lwc1	$f3, -5($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, 1
	lw	$v1, -6($sp)
	add	$v0, $v1, $v0
	li	$v1, min_caml_tmin
	li	$a0, 0
	add	$at, $v1, $a0
	lwc1	$f3, 0($at)
	lwc1	$f4, -1($sp)
	add.s	$f3, $f4, $f3
	lw	$v1, -7($sp)
	lw	$a0, -4($sp)
	lw	$a1, 0($sp)
	move	$a2, $a0
	move	$gp, $a1
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8686:
	jr	$ra
ble_else.8671:
	jr	$ra
trace_diffuse_ray.2946:
	lw	$v0, 1($gp)
	swc1	$f12, 0($sp)
	sw	$v0, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	judge_intersection_fast.2917
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8689
	jr	$ra
beq_else.8689:
	li	$v0, min_caml_objects
	li	$v1, min_caml_intersected_object_id
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	lw	$v1, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	d_vec.2720
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	get_nvector.2925
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v0, min_caml_intersection_point
	lw	$v1, -3($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	utexture.2928
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v0, 0
	li	$v1, min_caml_or_net
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	lw	$a0, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8691
	li	$v0, min_caml_nvector
	li	$v1, min_caml_light
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	veciprod.2634
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fneg
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fispos
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8692
	lwc1	$f2, 0(l.6297)
	j	beq_cont.8693
beq_else.8692:
	lwc1	$f2, -4($sp)
beq_cont.8693:
	li	$v0, min_caml_diffuse_ray
	lwc1	$f3, 0($sp)
	mul.s	$f2, $f3, $f2
	lw	$v1, -3($sp)
	sw	$v0, -5($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	o_diffuse.2683
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, min_caml_texture_color
	lw	$v1, -5($sp)
	move	$a1, $v0
	move	$a0, $v1
	mov.s	$f12, $f2
	j	vecaccum.2642
beq_else.8691:
	jr	$ra
iter_trace_diffuse_rays.2949:
	lw	$v0, 1($gp)
	li	$v1, 0
	sub	$at, $v1, $a3
	bgtz	$at, ble_else.8695
	add	$at, $a0, $a3
	lw	$v1, 0($at)
	sw	$a2, 0($sp)
	sw	$gp, -1($sp)
	sw	$v0, -2($sp)
	sw	$a3, -3($sp)
	sw	$a0, -4($sp)
	sw	$a1, -5($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	d_vec.2720
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	veciprod.2634
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	swc1	$f2, -6($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	min_caml_fisneg
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8696
	lw	$v0, -3($sp)
	lw	$v1, -4($sp)
	add	$at, $v1, $v0
	lw	$a0, 0($at)
	lwc1	$f2, 0(l.6760)
	lwc1	$f3, -6($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	lw	$a1, -2($sp)
	move	$t8, $ra
	move	$gp, $a1
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	j	beq_cont.8697
beq_else.8696:
	li	$v0, 1
	lw	$v1, -3($sp)
	add	$v0, $v1, $v0
	lw	$a0, -4($sp)
	add	$at, $a0, $v0
	lw	$v0, 0($at)
	lwc1	$f2, 0(l.6758)
	lwc1	$f3, -6($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	lw	$a1, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	move	$gp, $a1
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
beq_cont.8697:
	li	$v0, 2
	lw	$v1, -3($sp)
	sub	$v0, $v1, $v0
	lw	$v1, -4($sp)
	lw	$a0, -5($sp)
	lw	$a1, 0($sp)
	lw	$a2, -1($sp)
	move	$a3, $v0
	move	$gp, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v1
	lw	$t8, 0($gp)
	jr	$t8
ble_else.8695:
	jr	$ra
trace_diffuse_rays.2954:
	lw	$v0, 1($gp)
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $a2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	setup_startp.2854
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v0, 118
	lw	$v1, -2($sp)
	lw	$a0, -1($sp)
	lw	$a1, 0($sp)
	lw	$a2, -3($sp)
	move	$a3, $v0
	move	$gp, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v1
	lw	$t8, 0($gp)
	jr	$t8
trace_diffuse_ray_80percent.2958:
	lw	$v0, 1($gp)
	li	$v1, 0
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	sw	$v0, -2($sp)
	sw	$a0, -3($sp)
	bne	$a0, $v1, beq_else.8699
	j	beq_cont.8700
beq_else.8699:
	li	$v1, min_caml_dirvecs
	li	$a3, 0
	add	$at, $v1, $a3
	lw	$v1, 0($at)
	move	$t8, $ra
	move	$a0, $v1
	move	$gp, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8700:
	li	$v0, 1
	lw	$v1, -3($sp)
	bne	$v1, $v0, beq_else.8701
	j	beq_cont.8702
beq_else.8701:
	li	$v0, min_caml_dirvecs
	li	$a0, 1
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	lw	$a0, -1($sp)
	lw	$a1, 0($sp)
	lw	$a2, -2($sp)
	move	$t8, $ra
	move	$gp, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8702:
	li	$v0, 2
	lw	$v1, -3($sp)
	bne	$v1, $v0, beq_else.8703
	j	beq_cont.8704
beq_else.8703:
	li	$v0, min_caml_dirvecs
	li	$a0, 2
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	lw	$a0, -1($sp)
	lw	$a1, 0($sp)
	lw	$a2, -2($sp)
	move	$t8, $ra
	move	$gp, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8704:
	li	$v0, 3
	lw	$v1, -3($sp)
	bne	$v1, $v0, beq_else.8705
	j	beq_cont.8706
beq_else.8705:
	li	$v0, min_caml_dirvecs
	li	$a0, 3
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	lw	$a0, -1($sp)
	lw	$a1, 0($sp)
	lw	$a2, -2($sp)
	move	$t8, $ra
	move	$gp, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8706:
	li	$v0, 4
	lw	$v1, -3($sp)
	bne	$v1, $v0, beq_else.8707
	jr	$ra
beq_else.8707:
	li	$v0, min_caml_dirvecs
	li	$v1, 4
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	lw	$a1, -2($sp)
	move	$a2, $a0
	move	$gp, $a1
	move	$a1, $v1
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
calc_diffuse_using_1point.2962:
	lw	$v0, 1($gp)
	sw	$v0, 0($sp)
	sw	$a1, -1($sp)
	sw	$a0, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	p_nvectors.2718
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	p_intersection_points.2703
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	p_energy.2709
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, min_caml_diffuse_ray
	lw	$a0, -1($sp)
	lw	$a1, -3($sp)
	add	$at, $a1, $a0
	lw	$a1, 0($at)
	sw	$v0, -6($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	veccpy.2623
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	p_group_id.2713
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	lw	$v1, -1($sp)
	lw	$a0, -4($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	lw	$a1, -5($sp)
	add	$at, $a1, $v1
	lw	$a1, 0($at)
	lw	$a2, 0($sp)
	move	$t8, $ra
	move	$gp, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v0, min_caml_rgb
	lw	$v1, -1($sp)
	lw	$a0, -6($sp)
	add	$at, $a0, $v1
	lw	$v1, 0($at)
	li	$a0, min_caml_diffuse_ray
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	vecaccumv.2655
calc_diffuse_using_5points.2965:
	add	$at, $a1, $a0
	lw	$v0, 0($at)
	sw	$t0, 0($sp)
	sw	$a3, -1($sp)
	sw	$a2, -2($sp)
	sw	$a0, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 1
	lw	$a0, -3($sp)
	sub	$v1, $a0, $v1
	lw	$a1, -2($sp)
	add	$at, $a1, $v1
	lw	$v1, 0($at)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	lw	$a0, -2($sp)
	add	$at, $a0, $v1
	lw	$a1, 0($at)
	sw	$v0, -5($sp)
	move	$t8, $ra
	move	$a0, $a1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, 1
	lw	$a0, -3($sp)
	add	$v1, $a0, $v1
	lw	$a1, -2($sp)
	add	$at, $a1, $v1
	lw	$v1, 0($at)
	sw	$v0, -6($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	sw	$v0, -7($sp)
	move	$t8, $ra
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	li	$v1, min_caml_diffuse_ray
	lw	$a0, 0($sp)
	lw	$a1, -4($sp)
	add	$at, $a1, $a0
	lw	$a1, 0($at)
	sw	$v0, -8($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	veccpy.2623
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, min_caml_diffuse_ray
	lw	$v1, 0($sp)
	lw	$a0, -5($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	vecadd.2646
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, min_caml_diffuse_ray
	lw	$v1, 0($sp)
	lw	$a0, -6($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	vecadd.2646
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, min_caml_diffuse_ray
	lw	$v1, 0($sp)
	lw	$a0, -7($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	vecadd.2646
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, min_caml_diffuse_ray
	lw	$v1, 0($sp)
	lw	$a0, -8($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	vecadd.2646
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v0, -3($sp)
	lw	$v1, -2($sp)
	add	$at, $v1, $v0
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	p_energy.2709
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, min_caml_rgb
	lw	$a0, 0($sp)
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	li	$a0, min_caml_diffuse_ray
	move	$a2, $a0
	move	$a1, $v0
	move	$a0, $v1
	j	vecaccumv.2655
do_without_neighbors.2971:
	lw	$v0, 1($gp)
	li	$v1, 4
	sub	$at, $a1, $v1
	bgtz	$at, ble_else.8709
	sw	$gp, 0($sp)
	sw	$v0, -1($sp)
	sw	$a0, -2($sp)
	sw	$a1, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	p_surface_ids.2705
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	lw	$a0, -3($sp)
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	sub	$at, $v1, $v0
	bgtz	$at, ble_else.8710
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	p_calc_diffuse.2707
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, 0
	bne	$v0, $a0, beq_else.8711
	j	beq_cont.8712
beq_else.8711:
	lw	$v0, -2($sp)
	lw	$a0, -1($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
beq_cont.8712:
	li	$v0, 1
	lw	$v1, -3($sp)
	add	$v0, $v1, $v0
	lw	$v1, -2($sp)
	lw	$a0, 0($sp)
	move	$a1, $v0
	move	$gp, $a0
	move	$a0, $v1
	lw	$t8, 0($gp)
	jr	$t8
ble_else.8710:
	jr	$ra
ble_else.8709:
	jr	$ra
neighbors_exist.2974:
	li	$v0, min_caml_image_size
	li	$v1, 1
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	add	$v1, $a1, $v1
	sub	$at, $v0, $v1
	bgtz	$at, ble_else.8715
	li	$v0, 0
	jr	$ra
ble_else.8715:
	li	$v0, 0
	sub	$at, $a1, $v0
	bgtz	$at, ble_else.8716
	li	$v0, 0
	jr	$ra
ble_else.8716:
	li	$v0, min_caml_image_size
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	add	$v1, $a0, $v1
	sub	$at, $v0, $v1
	bgtz	$at, ble_else.8717
	li	$v0, 0
	jr	$ra
ble_else.8717:
	li	$v0, 0
	sub	$at, $a0, $v0
	bgtz	$at, ble_else.8718
	li	$v0, 0
	jr	$ra
ble_else.8718:
	li	$v0, 1
	jr	$ra
get_surface_id.2978:
	sw	$a1, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	p_surface_ids.2705
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	jr	$ra
neighbors_are_available.2981:
	add	$at, $a2, $a0
	lw	$v0, 0($at)
	sw	$a2, 0($sp)
	sw	$a3, -1($sp)
	sw	$t0, -2($sp)
	sw	$a0, -3($sp)
	sw	$a1, -4($sp)
	move	$t8, $ra
	move	$a1, $t0
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	get_surface_id.2978
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	lw	$a0, -4($sp)
	add	$at, $a0, $v1
	lw	$a0, 0($at)
	lw	$a1, -2($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	get_surface_id.2978
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	bne	$v0, $v1, beq_else.8719
	lw	$v0, -3($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v0
	lw	$a0, 0($at)
	lw	$a1, -2($sp)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	get_surface_id.2978
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	bne	$v0, $v1, beq_else.8720
	li	$v0, 1
	lw	$a0, -3($sp)
	sub	$v0, $a0, $v0
	lw	$a1, 0($sp)
	add	$at, $a1, $v0
	lw	$v0, 0($at)
	lw	$a2, -2($sp)
	move	$t8, $ra
	move	$a1, $a2
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	get_surface_id.2978
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	bne	$v0, $v1, beq_else.8721
	li	$v0, 1
	lw	$a0, -3($sp)
	add	$v0, $a0, $v0
	lw	$a0, 0($sp)
	add	$at, $a0, $v0
	lw	$v0, 0($at)
	lw	$a0, -2($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	get_surface_id.2978
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	bne	$v0, $v1, beq_else.8722
	li	$v0, 1
	jr	$ra
beq_else.8722:
	li	$v0, 0
	jr	$ra
beq_else.8721:
	li	$v0, 0
	jr	$ra
beq_else.8720:
	li	$v0, 0
	jr	$ra
beq_else.8719:
	li	$v0, 0
	jr	$ra
try_exploit_neighbors.2987:
	lw	$v0, 1($gp)
	add	$at, $a3, $a0
	lw	$v1, 0($at)
	li	$t2, 4
	sub	$at, $t1, $t2
	bgtz	$at, ble_else.8723
	li	$t2, 0
	sw	$a1, 0($sp)
	sw	$gp, -1($sp)
	sw	$v1, -2($sp)
	sw	$v0, -3($sp)
	sw	$t1, -4($sp)
	sw	$t0, -5($sp)
	sw	$a3, -6($sp)
	sw	$a2, -7($sp)
	sw	$a0, -8($sp)
	sw	$t2, -9($sp)
	move	$t8, $ra
	move	$a1, $t1
	move	$a0, $v1
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	get_surface_id.2978
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v1, -9($sp)
	sub	$at, $v1, $v0
	bgtz	$at, ble_else.8724
	lw	$v0, -8($sp)
	lw	$v1, -7($sp)
	lw	$a0, -6($sp)
	lw	$a1, -5($sp)
	lw	$a2, -4($sp)
	move	$t8, $ra
	move	$t0, $a2
	move	$a3, $a1
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	neighbors_are_available.2981
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8725
	lw	$v0, -8($sp)
	lw	$v1, -6($sp)
	add	$at, $v1, $v0
	lw	$v0, 0($at)
	lw	$v1, -4($sp)
	lw	$a0, -3($sp)
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
beq_else.8725:
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	p_calc_diffuse.2707
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v1, -4($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, 0
	bne	$v0, $a0, beq_else.8726
	j	beq_cont.8727
beq_else.8726:
	lw	$v0, -8($sp)
	lw	$a0, -7($sp)
	lw	$a1, -6($sp)
	lw	$a2, -5($sp)
	move	$t8, $ra
	move	$t0, $v1
	move	$a3, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	calc_diffuse_using_5points.2965
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
beq_cont.8727:
	li	$v0, 1
	lw	$v1, -4($sp)
	add	$v0, $v1, $v0
	lw	$v1, -8($sp)
	lw	$a0, 0($sp)
	lw	$a1, -7($sp)
	lw	$a2, -6($sp)
	lw	$a3, -5($sp)
	lw	$t0, -1($sp)
	move	$t1, $v0
	move	$gp, $t0
	move	$t0, $a3
	move	$a3, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v1
	lw	$t8, 0($gp)
	jr	$t8
ble_else.8724:
	jr	$ra
ble_else.8723:
	jr	$ra
write_ppm_header.2994:
	li	$v0, 80
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 51
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 10
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_image_size
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_int
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 32
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_image_size
	li	$v1, 1
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_int
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 32
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 255
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_int
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 10
	move	$a0, $v0
	j	min_caml_print_char
write_rgb_element.2996:
	move	$t8, $ra
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_int_of_float
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v1, 255
	sub	$at, $v0, $v1
	bgtz	$at, beq_else.8730
	li	$v1, 0
	sub	$at, $v1, $v0
	bgtz	$at, beq_else.8732
	j	beq_cont.8733
beq_else.8732:
	li	$v0, 0
beq_cont.8733:
	j	beq_cont.8731
beq_else.8730:
	li	$v0, 255
beq_cont.8731:
	move	$a0, $v0
	j	min_caml_print_int
write_rgb.2998:
	li	$v0, min_caml_rgb
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	write_rgb_element.2996
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 32
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_rgb
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	write_rgb_element.2996
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 32
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_print_char
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, min_caml_rgb
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f2, 0($at)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	write_rgb_element.2996
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 10
	move	$a0, $v0
	j	min_caml_print_char
pretrace_diffuse_rays.3000:
	lw	$v0, 1($gp)
	li	$v1, 4
	sub	$at, $a1, $v1
	bgtz	$at, ble_else.8734
	sw	$gp, 0($sp)
	sw	$v0, -1($sp)
	sw	$a1, -2($sp)
	sw	$a0, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	get_surface_id.2978
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 0
	sub	$at, $v1, $v0
	bgtz	$at, ble_else.8735
	lw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	p_calc_diffuse.2707
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, 0
	bne	$v0, $a0, beq_else.8736
	j	beq_cont.8737
beq_else.8736:
	lw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	p_group_id.2713
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, min_caml_diffuse_ray
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	vecbzero.2621
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	p_nvectors.2718
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	p_intersection_points.2703
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	li	$v1, min_caml_dirvecs
	lw	$a0, -4($sp)
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	lw	$a0, -2($sp)
	lw	$a1, -5($sp)
	add	$at, $a1, $a0
	lw	$a1, 0($at)
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	lw	$a2, -1($sp)
	move	$t8, $ra
	move	$a0, $v1
	move	$gp, $a2
	move	$a2, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	p_received_ray_20percent.2711
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, min_caml_diffuse_ray
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	veccpy.2623
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
beq_cont.8737:
	li	$v0, 1
	lw	$v1, -2($sp)
	add	$v0, $v1, $v0
	lw	$v1, -3($sp)
	lw	$a0, 0($sp)
	move	$a1, $v0
	move	$gp, $a0
	move	$a0, $v1
	lw	$t8, 0($gp)
	jr	$t8
ble_else.8735:
	jr	$ra
ble_else.8734:
	jr	$ra
pretrace_pixels.3003:
	lw	$v0, 2($gp)
	lw	$v1, 1($gp)
	li	$a3, 0
	sub	$at, $a3, $a1
	bgtz	$at, ble_else.8740
	li	$a3, min_caml_scan_pitch
	li	$t0, 0
	add	$at, $a3, $t0
	lwc1	$f2, 0($at)
	li	$a3, min_caml_image_center
	li	$t0, 0
	add	$at, $a3, $t0
	lw	$a3, 0($at)
	sub	$a3, $a1, $a3
	sw	$gp, 0($sp)
	sw	$v1, -1($sp)
	sw	$a2, -2($sp)
	sw	$v0, -3($sp)
	sw	$a1, -4($sp)
	sw	$a0, -5($sp)
	swc1	$f14, -6($sp)
	swc1	$f13, -7($sp)
	swc1	$f12, -8($sp)
	swc1	$f2, -9($sp)
	move	$t8, $ra
	move	$a0, $a3
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_float_of_int
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, min_caml_ptrace_dirvec
	li	$v1, 0
	li	$a0, min_caml_screenx_dir
	li	$a1, 0
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f2, $f3
	lwc1	$f4, -8($sp)
	add.s	$f3, $f3, $f4
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_ptrace_dirvec
	li	$v1, 1
	li	$a0, min_caml_screenx_dir
	li	$a1, 1
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f2, $f3
	lwc1	$f5, -7($sp)
	add.s	$f3, $f3, $f5
	add	$at, $v0, $v1
	swc1	$f3, 0($at)
	li	$v0, min_caml_ptrace_dirvec
	li	$v1, 2
	li	$a0, min_caml_screenx_dir
	li	$a1, 2
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, -6($sp)
	add.s	$f2, $f2, $f3
	add	$at, $v0, $v1
	swc1	$f2, 0($at)
	li	$v0, min_caml_ptrace_dirvec
	li	$v1, 0
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	vecunit_sgn.2631
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v0, min_caml_rgb
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	vecbzero.2621
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v0, min_caml_startp
	li	$v1, min_caml_viewpoint
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	veccpy.2623
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v0, 0
	lwc1	$f2, 0(l.6298)
	li	$v1, min_caml_ptrace_dirvec
	lw	$a0, -4($sp)
	lw	$a1, -5($sp)
	add	$at, $a1, $a0
	lw	$a2, 0($at)
	lwc1	$f3, 0(l.6297)
	lw	$a3, -3($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	move	$gp, $a3
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v0, -4($sp)
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lw	$a0, 0($at)
	move	$t8, $ra
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	p_rgb.2701
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v1, min_caml_rgb
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	veccpy.2623
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v0, -4($sp)
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lw	$a0, 0($at)
	lw	$a1, -2($sp)
	move	$t8, $ra
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	p_set_group_id.2715
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lw	$v0, -4($sp)
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lw	$a0, 0($at)
	li	$a1, 0
	lw	$a2, -1($sp)
	move	$t8, $ra
	move	$gp, $a2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -4($sp)
	sub	$v0, $v1, $v0
	li	$v1, 1
	lw	$a0, -2($sp)
	sw	$v0, -10($sp)
	move	$t8, $ra
	move	$a1, $v1
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	add_mod5.2610
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	move	$ra, $t8
	lwc1	$f2, -8($sp)
	lwc1	$f3, -7($sp)
	lwc1	$f4, -6($sp)
	lw	$v1, -5($sp)
	lw	$a0, -10($sp)
	lw	$a1, 0($sp)
	move	$a2, $v0
	move	$gp, $a1
	move	$a1, $a0
	move	$a0, $v1
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	lw	$t8, 0($gp)
	jr	$t8
ble_else.8740:
	jr	$ra
pretrace_line.3010:
	lw	$v0, 1($gp)
	li	$v1, min_caml_scan_pitch
	li	$a3, 0
	add	$at, $v1, $a3
	lwc1	$f2, 0($at)
	li	$v1, min_caml_image_center
	li	$a3, 1
	add	$at, $v1, $a3
	lw	$v1, 0($at)
	sub	$v1, $a1, $v1
	sw	$a2, 0($sp)
	sw	$a0, -1($sp)
	sw	$v0, -2($sp)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_float_of_int
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	mul.s	$f2, $f3, $f2
	li	$v0, min_caml_screeny_dir
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	mul.s	$f3, $f2, $f3
	li	$v0, min_caml_screenz_dir
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	add.s	$f3, $f3, $f4
	li	$v0, min_caml_screeny_dir
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	mul.s	$f4, $f2, $f4
	li	$v0, min_caml_screenz_dir
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f5, 0($at)
	add.s	$f4, $f4, $f5
	li	$v0, min_caml_screeny_dir
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f5, 0($at)
	mul.s	$f2, $f2, $f5
	li	$v0, min_caml_screenz_dir
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f5, 0($at)
	add.s	$f2, $f2, $f5
	li	$v0, min_caml_image_size
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	sub	$v0, $v0, $v1
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	lw	$a1, -2($sp)
	move	$a2, $a0
	move	$gp, $a1
	move	$a1, $v0
	move	$a0, $v1
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	lw	$t8, 0($gp)
	jr	$t8
scan_pixel.3014:
	lw	$v0, 2($gp)
	lw	$v1, 1($gp)
	li	$t1, min_caml_image_size
	li	$t2, 0
	add	$at, $t1, $t2
	lw	$t1, 0($at)
	sub	$at, $t1, $a0
	bgtz	$at, ble_else.8742
	jr	$ra
ble_else.8742:
	li	$t1, min_caml_rgb
	add	$at, $a3, $a0
	lw	$t2, 0($at)
	sw	$gp, 0($sp)
	sw	$a2, -1($sp)
	sw	$v0, -2($sp)
	sw	$v1, -3($sp)
	sw	$a3, -4($sp)
	sw	$t0, -5($sp)
	sw	$a1, -6($sp)
	sw	$a0, -7($sp)
	sw	$t1, -8($sp)
	move	$t8, $ra
	move	$a0, $t2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	p_rgb.2701
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v1, -8($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	veccpy.2623
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v0, -7($sp)
	lw	$v1, -6($sp)
	lw	$a0, -5($sp)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	neighbors_exist.2974
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8744
	lw	$v0, -7($sp)
	lw	$v1, -4($sp)
	add	$at, $v1, $v0
	lw	$a0, 0($at)
	li	$a1, 0
	lw	$a2, -3($sp)
	move	$t8, $ra
	move	$gp, $a2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	j	beq_cont.8745
beq_else.8744:
	li	$v0, 0
	lw	$v1, -7($sp)
	lw	$a0, -6($sp)
	lw	$a1, -1($sp)
	lw	$a2, -4($sp)
	lw	$a3, -5($sp)
	lw	$t0, -2($sp)
	move	$t8, $ra
	move	$t1, $v0
	move	$gp, $t0
	move	$t0, $a3
	move	$a3, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v1
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
beq_cont.8745:
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	write_rgb.2998
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -7($sp)
	add	$v0, $v1, $v0
	lw	$v1, -6($sp)
	lw	$a0, -1($sp)
	lw	$a1, -4($sp)
	lw	$a2, -5($sp)
	lw	$a3, 0($sp)
	move	$t0, $a2
	move	$gp, $a3
	move	$a3, $a1
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
scan_line.3020:
	lw	$v0, 2($gp)
	lw	$v1, 1($gp)
	li	$t1, min_caml_image_size
	li	$t2, 1
	add	$at, $t1, $t2
	lw	$t1, 0($at)
	sub	$at, $t1, $a0
	bgtz	$at, ble_else.8746
	jr	$ra
ble_else.8746:
	li	$t1, min_caml_image_size
	li	$t2, 1
	add	$at, $t1, $t2
	lw	$t1, 0($at)
	li	$t2, 1
	sub	$t1, $t1, $t2
	sw	$gp, 0($sp)
	sw	$t0, -1($sp)
	sw	$a3, -2($sp)
	sw	$a2, -3($sp)
	sw	$a1, -4($sp)
	sw	$a0, -5($sp)
	sw	$v0, -6($sp)
	sub	$at, $t1, $a0
	bgtz	$at, beq_else.8748
	j	beq_cont.8749
beq_else.8748:
	li	$t1, 1
	add	$t1, $a0, $t1
	move	$t8, $ra
	move	$a2, $t0
	move	$a1, $t1
	move	$a0, $a3
	move	$gp, $v1
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
beq_cont.8749:
	li	$v0, 0
	lw	$v1, -5($sp)
	lw	$a0, -4($sp)
	lw	$a1, -3($sp)
	lw	$a2, -2($sp)
	lw	$a3, -6($sp)
	move	$t8, $ra
	move	$t0, $a2
	move	$gp, $a3
	move	$a3, $a1
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -5($sp)
	add	$v0, $v1, $v0
	li	$v1, 2
	lw	$a0, -1($sp)
	sw	$v0, -7($sp)
	move	$t8, $ra
	move	$a1, $v1
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	add_mod5.2610
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	lw	$v1, -7($sp)
	lw	$a0, -3($sp)
	lw	$a1, -2($sp)
	lw	$a2, -4($sp)
	lw	$a3, 0($sp)
	move	$t0, $v0
	move	$gp, $a3
	move	$a3, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v1
	lw	$t8, 0($gp)
	jr	$t8
create_float5x3array.3026:
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_create_float_array
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v1, 5
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_create_array
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v1, 1
	li	$a0, 3
	lwc1	$f2, 0(l.6297)
	sw	$v1, 0($sp)
	sw	$v0, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_create_float_array
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, 2
	li	$v1, 3
	lwc1	$f2, 0(l.6297)
	sw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_create_float_array
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, 3
	li	$v1, 3
	lwc1	$f2, 0(l.6297)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_create_float_array
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v1, -3($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, 4
	li	$v1, 3
	lwc1	$f2, 0(l.6297)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_create_float_array
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lw	$v1, -4($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	move	$v0, $a0
	jr	$ra
create_pixel.3028:
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_create_float_array
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	sw	$v0, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	create_float5x3array.3026
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 5
	li	$a0, 0
	sw	$v0, -1($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v1
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_create_array
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 5
	li	$a0, 0
	sw	$v0, -2($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_create_array
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	sw	$v0, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	create_float5x3array.3026
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	sw	$v0, -4($sp)
	move	$t8, $ra
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	create_float5x3array.3026
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	li	$v1, 1
	li	$a0, 0
	sw	$v0, -5($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_create_array
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	sw	$v0, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	create_float5x3array.3026
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	move	$v1, $hp
	addi	$hp, $hp, 8
	sw	$v0, 7($v1)
	lw	$v0, -6($sp)
	sw	$v0, 6($v1)
	lw	$v0, -5($sp)
	sw	$v0, 5($v1)
	lw	$v0, -4($sp)
	sw	$v0, 4($v1)
	lw	$v0, -3($sp)
	sw	$v0, 3($v1)
	lw	$v0, -2($sp)
	sw	$v0, 2($v1)
	lw	$v0, -1($sp)
	sw	$v0, 1($v1)
	lw	$v0, 0($sp)
	sw	$v0, 0($v1)
	move	$v0, $v1
	jr	$ra
init_line_elements.3030:
	li	$v0, 0
	sub	$at, $v0, $a1
	bgtz	$at, ble_else.8750
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	create_pixel.3028
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, 1
	sub	$v0, $v1, $v0
	move	$a1, $v0
	j	init_line_elements.3030
ble_else.8750:
	move	$v0, $a0
	jr	$ra
create_pixelline.3033:
	li	$v0, min_caml_image_size
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	sw	$v0, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	create_pixel.3028
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_create_array
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, min_caml_image_size
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	li	$a0, 2
	sub	$v1, $v1, $a0
	move	$a1, $v1
	move	$a0, $v0
	j	init_line_elements.3030
tan.3035:
	swc1	$f12, 0($sp)
	move	$t8, $ra
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_sin
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0($sp)
	swc1	$f2, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_cos
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -1($sp)
	inv.s	$at, $f2
	mul.s	$f0, $f3, $at
	jr	$ra
adjust_position.3037:
	mul.s	$f2, $f12, $f12
	lwc1	$f3, 0(l.6742)
	add.s	$f2, $f2, $f3
	swc1	$f13, 0($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_sqrt
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6298)
	inv.s	$at, $f2
	mul.s	$f3, $f3, $at
	swc1	$f2, -1($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_atan
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0($sp)
	mul.s	$f2, $f2, $f3
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	tan.3035
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -1($sp)
	mul.s	$f0, $f2, $f3
	jr	$ra
calc_dirvec.3040:
	li	$v0, 5
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8751
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	swc1	$f12, -2($sp)
	swc1	$f13, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fsqr
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fsqr
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -4($sp)
	add.s	$f2, $f3, $f2
	lwc1	$f3, 0(l.6298)
	add.s	$f2, $f2, $f3
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_sqrt
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	inv.s	$at, $f2
	mul.s	$f3, $f3, $at
	lwc1	$f4, -3($sp)
	inv.s	$at, $f2
	mul.s	$f4, $f4, $at
	lwc1	$f5, 0(l.6298)
	inv.s	$at, $f2
	mul.s	$f2, $f5, $at
	li	$v0, min_caml_dirvecs
	lw	$v1, -1($sp)
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	lw	$v1, 0($sp)
	add	$at, $v0, $v1
	lw	$a0, 0($at)
	sw	$v0, -5($sp)
	swc1	$f2, -6($sp)
	swc1	$f4, -7($sp)
	swc1	$f3, -8($sp)
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	d_vec.2720
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lwc1	$f2, -8($sp)
	lwc1	$f3, -7($sp)
	lwc1	$f4, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	vecset.2613
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, 40
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	lw	$a0, -5($sp)
	add	$at, $a0, $v0
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	d_vec.2720
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lwc1	$f2, -7($sp)
	sw	$v0, -9($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	min_caml_fneg
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	lwc1	$f4, -6($sp)
	lw	$v0, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	vecset.2613
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	li	$v0, 80
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	lw	$a0, -5($sp)
	add	$at, $a0, $v0
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	d_vec.2720
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	move	$ra, $t8
	lwc1	$f2, -8($sp)
	sw	$v0, -10($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -11($sp)
	addi	$sp, $sp, -12
	jal	min_caml_fneg
	addi	$sp, $sp, 12
	lw	$t8, -11($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	swc1	$f2, -11($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	min_caml_fneg
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	lwc1	$f4, -11($sp)
	lw	$v0, -10($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	vecset.2613
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	lw	$a0, -5($sp)
	add	$at, $a0, $v0
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	d_vec.2720
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	lwc1	$f2, -8($sp)
	sw	$v0, -12($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -13($sp)
	addi	$sp, $sp, -14
	jal	min_caml_fneg
	addi	$sp, $sp, 14
	lw	$t8, -13($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	swc1	$f2, -13($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -14($sp)
	addi	$sp, $sp, -15
	jal	min_caml_fneg
	addi	$sp, $sp, 15
	lw	$t8, -14($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	swc1	$f2, -14($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	min_caml_fneg
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -13($sp)
	lwc1	$f4, -14($sp)
	lw	$v0, -12($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	vecset.2613
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	move	$ra, $t8
	li	$v0, 41
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	lw	$a0, -5($sp)
	add	$at, $a0, $v0
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -15($sp)
	addi	$sp, $sp, -16
	jal	d_vec.2720
	addi	$sp, $sp, 16
	lw	$t8, -15($sp)
	move	$ra, $t8
	lwc1	$f2, -8($sp)
	sw	$v0, -15($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -16($sp)
	addi	$sp, $sp, -17
	jal	min_caml_fneg
	addi	$sp, $sp, 17
	lw	$t8, -16($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -6($sp)
	swc1	$f2, -16($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	min_caml_fneg
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -16($sp)
	lwc1	$f4, -7($sp)
	lw	$v0, -15($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	vecset.2613
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	move	$ra, $t8
	li	$v0, 81
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	lw	$v1, -5($sp)
	add	$at, $v1, $v0
	lw	$v0, 0($at)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -17($sp)
	addi	$sp, $sp, -18
	jal	d_vec.2720
	addi	$sp, $sp, 18
	lw	$t8, -17($sp)
	move	$ra, $t8
	lwc1	$f2, -6($sp)
	sw	$v0, -17($sp)
	move	$t8, $ra
	mov.s	$f12, $f2
	sw	$t8, -18($sp)
	addi	$sp, $sp, -19
	jal	min_caml_fneg
	addi	$sp, $sp, 19
	lw	$t8, -18($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -8($sp)
	lwc1	$f4, -7($sp)
	lw	$v0, -17($sp)
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	j	vecset.2613
ble_else.8751:
	swc1	$f14, -18($sp)
	sw	$a2, 0($sp)
	sw	$a1, -1($sp)
	swc1	$f15, -19($sp)
	sw	$a0, -20($sp)
	move	$t8, $ra
	mov.s	$f12, $f13
	mov.s	$f13, $f14
	sw	$t8, -21($sp)
	addi	$sp, $sp, -22
	jal	adjust_position.3037
	addi	$sp, $sp, 22
	lw	$t8, -21($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -20($sp)
	add	$v0, $v1, $v0
	lwc1	$f3, -19($sp)
	swc1	$f2, -21($sp)
	sw	$v0, -22($sp)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -23($sp)
	addi	$sp, $sp, -24
	jal	adjust_position.3037
	addi	$sp, $sp, 24
	lw	$t8, -23($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -21($sp)
	lwc1	$f4, -18($sp)
	lwc1	$f5, -19($sp)
	lw	$v0, -22($sp)
	lw	$v1, -1($sp)
	lw	$a0, 0($sp)
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f15, $f5
	mov.s	$f14, $f4
	mov.s	$f13, $f2
	mov.s	$f12, $f3
	j	calc_dirvec.3040
calc_dirvecs.3048:
	li	$v0, 0
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8752
	sw	$a0, 0($sp)
	swc1	$f12, -1($sp)
	sw	$a2, -2($sp)
	sw	$a1, -3($sp)
	move	$t8, $ra
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_float_of_int
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6854)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, 0(l.6855)
	sub.s	$f2, $f2, $f3
	li	$v0, 0
	lwc1	$f3, 0(l.6297)
	lwc1	$f4, 0(l.6297)
	lwc1	$f5, -1($sp)
	lw	$v1, -3($sp)
	lw	$a0, -2($sp)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f15, $f5
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	calc_dirvec.3040
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	lw	$v0, 0($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_float_of_int
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6854)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, 0(l.6742)
	add.s	$f2, $f2, $f3
	li	$v0, 0
	lwc1	$f3, 0(l.6297)
	lwc1	$f4, 0(l.6297)
	li	$v1, 2
	lw	$a0, -2($sp)
	add	$v1, $a0, $v1
	lwc1	$f5, -1($sp)
	lw	$a1, -3($sp)
	move	$t8, $ra
	move	$a2, $v1
	move	$a0, $v0
	mov.s	$f15, $f5
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	calc_dirvec.3040
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, 0($sp)
	sub	$v0, $v1, $v0
	li	$v1, 1
	lw	$a0, -3($sp)
	sw	$v0, -4($sp)
	move	$t8, $ra
	move	$a1, $v1
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	add_mod5.2610
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	move	$ra, $t8
	lwc1	$f2, -1($sp)
	lw	$v1, -4($sp)
	lw	$a0, -2($sp)
	move	$a2, $a0
	move	$a1, $v0
	move	$a0, $v1
	mov.s	$f12, $f2
	j	calc_dirvecs.3048
ble_else.8752:
	jr	$ra
calc_dirvec_rows.3053:
	li	$v0, 0
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8754
	sw	$a0, 0($sp)
	sw	$a2, -1($sp)
	sw	$a1, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_float_of_int
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6854)
	mul.s	$f2, $f2, $f3
	lwc1	$f3, 0(l.6855)
	sub.s	$f2, $f2, $f3
	li	$v0, 4
	lw	$v1, -2($sp)
	lw	$a0, -1($sp)
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	calc_dirvecs.3048
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, 0($sp)
	sub	$v0, $v1, $v0
	li	$v1, 2
	lw	$a0, -2($sp)
	sw	$v0, -3($sp)
	move	$t8, $ra
	move	$a1, $v1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	add_mod5.2610
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	move	$ra, $t8
	li	$v1, 4
	lw	$a0, -1($sp)
	add	$v1, $a0, $v1
	lw	$a0, -3($sp)
	move	$a2, $v1
	move	$a1, $v0
	j	calc_dirvec_rows.3053
ble_else.8754:
	jr	$ra
create_dirvec.3057:
	li	$v0, 3
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_create_float_array
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v1, min_caml_n_objects
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	sw	$v0, 0($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_create_array
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	move	$v1, $hp
	addi	$hp, $hp, 2
	sw	$v0, 1($v1)
	lw	$v0, 0($sp)
	sw	$v0, 0($v1)
	move	$v0, $v1
	jr	$ra
create_dirvec_elements.3059:
	li	$v0, 0
	sub	$at, $v0, $a1
	bgtz	$at, ble_else.8756
	sw	$a1, 0($sp)
	sw	$a0, -1($sp)
	move	$t8, $ra
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	create_dirvec.3057
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, 1
	sub	$v0, $v1, $v0
	move	$a1, $v0
	j	create_dirvec_elements.3059
ble_else.8756:
	jr	$ra
create_dirvecs.3062:
	li	$v0, 0
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8758
	li	$v0, min_caml_dirvecs
	li	$v1, 120
	sw	$a0, 0($sp)
	sw	$v0, -1($sp)
	sw	$v1, -2($sp)
	move	$t8, $ra
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	create_dirvec.3057
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, -2($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	min_caml_create_array
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	lw	$v1, 0($sp)
	lw	$a0, -1($sp)
	add	$at, $a0, $v1
	sw	$v0, 0($at)
	li	$v0, min_caml_dirvecs
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$a0, 118
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	create_dirvec_elements.3059
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, 0($sp)
	sub	$v0, $v1, $v0
	move	$a0, $v0
	j	create_dirvecs.3062
ble_else.8758:
	jr	$ra
init_dirvec_constants.3064:
	li	$v0, 0
	sub	$at, $v0, $a1
	bgtz	$at, ble_else.8760
	add	$at, $a0, $a1
	lw	$v0, 0($at)
	sw	$a0, 0($sp)
	sw	$a1, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	setup_dirvec_constants.2849
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -1($sp)
	sub	$v0, $v1, $v0
	lw	$v1, 0($sp)
	move	$a1, $v0
	move	$a0, $v1
	j	init_dirvec_constants.3064
ble_else.8760:
	jr	$ra
init_vecset_constants.3067:
	li	$v0, 0
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8762
	li	$v0, min_caml_dirvecs
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	li	$v1, 119
	sw	$a0, 0($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	init_dirvec_constants.3064
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, 0($sp)
	sub	$v0, $v1, $v0
	move	$a0, $v0
	j	init_vecset_constants.3067
ble_else.8762:
	jr	$ra
init_dirvecs.3069:
	li	$v0, 4
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	create_dirvecs.3062
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 9
	li	$v1, 0
	li	$a0, 0
	move	$t8, $ra
	move	$a2, $a0
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	calc_dirvec_rows.3053
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v0, 4
	move	$a0, $v0
	j	init_vecset_constants.3067
add_reflection.3071:
	sw	$a0, 0($sp)
	sw	$a1, -1($sp)
	swc1	$f12, -2($sp)
	swc1	$f15, -3($sp)
	swc1	$f14, -4($sp)
	swc1	$f13, -5($sp)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	create_dirvec.3057
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	sw	$v0, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	d_vec.2720
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	lwc1	$f2, -5($sp)
	lwc1	$f3, -4($sp)
	lwc1	$f4, -3($sp)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f14, $f4
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	vecset.2613
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	lw	$v0, -6($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	setup_dirvec_constants.2849
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v0, min_caml_reflections
	move	$v1, $hp
	addi	$hp, $hp, 3
	lwc1	$f2, -2($sp)
	swc1	$f2, 2($v1)
	lw	$a0, -6($sp)
	sw	$a0, 1($v1)
	lw	$a0, -1($sp)
	sw	$a0, 0($v1)
	lw	$a0, 0($sp)
	add	$at, $v0, $a0
	sw	$v1, 0($at)
	jr	$ra
setup_rect_reflection.3078:
	li	$v0, 4
	sll	$v0, $a0, 2
	li	$v1, min_caml_n_reflections
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	lwc1	$f2, 0(l.6298)
	sw	$v1, 0($sp)
	sw	$v0, -1($sp)
	swc1	$f2, -2($sp)
	move	$t8, $ra
	move	$a0, $a1
	sw	$t8, -3($sp)
	addi	$sp, $sp, -4
	jal	o_diffuse.2683
	addi	$sp, $sp, 4
	lw	$t8, -3($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -2($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, min_caml_light
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	min_caml_fneg
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_light
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	swc1	$f2, -4($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -5($sp)
	addi	$sp, $sp, -6
	jal	min_caml_fneg
	addi	$sp, $sp, 6
	lw	$t8, -5($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, min_caml_light
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	mov.s	$f12, $f3
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_fneg
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, -1($sp)
	add	$v0, $v1, $v0
	li	$a0, min_caml_light
	li	$a1, 0
	add	$at, $a0, $a1
	lwc1	$f3, 0($at)
	lwc1	$f4, -3($sp)
	lwc1	$f5, -5($sp)
	lw	$a0, 0($sp)
	swc1	$f2, -6($sp)
	move	$t8, $ra
	move	$a1, $v0
	mov.s	$f15, $f2
	mov.s	$f14, $f5
	mov.s	$f13, $f3
	mov.s	$f12, $f4
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	add_reflection.3071
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v0, 1
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	li	$a0, 2
	lw	$a1, -1($sp)
	add	$a0, $a1, $a0
	li	$a2, min_caml_light
	li	$a3, 1
	add	$at, $a2, $a3
	lwc1	$f2, 0($at)
	lwc1	$f3, -3($sp)
	lwc1	$f4, -4($sp)
	lwc1	$f5, -6($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	mov.s	$f15, $f5
	mov.s	$f14, $f2
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	add_reflection.3071
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v0, 2
	lw	$v1, 0($sp)
	add	$v0, $v1, $v0
	li	$a0, 3
	lw	$a1, -1($sp)
	add	$a0, $a1, $a0
	li	$a1, min_caml_light
	li	$a2, 2
	add	$at, $a1, $a2
	lwc1	$f2, 0($at)
	lwc1	$f3, -3($sp)
	lwc1	$f4, -4($sp)
	lwc1	$f5, -5($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v0
	mov.s	$f15, $f2
	mov.s	$f14, $f5
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	add_reflection.3071
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	li	$v0, min_caml_n_reflections
	li	$v1, 0
	li	$a0, 3
	lw	$a1, 0($sp)
	add	$a0, $a1, $a0
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	jr	$ra
setup_surface_reflection.3081:
	li	$v0, 4
	sll	$v0, $a0, 2
	li	$v1, 1
	add	$v0, $v0, $v1
	li	$v1, min_caml_n_reflections
	li	$a0, 0
	add	$at, $v1, $a0
	lw	$v1, 0($at)
	lwc1	$f2, 0(l.6298)
	sw	$v0, 0($sp)
	sw	$v1, -1($sp)
	sw	$a1, -2($sp)
	swc1	$f2, -3($sp)
	move	$t8, $ra
	move	$a0, $a1
	sw	$t8, -4($sp)
	addi	$sp, $sp, -5
	jal	o_diffuse.2683
	addi	$sp, $sp, 5
	lw	$t8, -4($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -3($sp)
	sub.s	$f2, $f3, $f2
	li	$v0, min_caml_light
	lw	$v1, -2($sp)
	swc1	$f2, -4($sp)
	sw	$v0, -5($sp)
	move	$t8, $ra
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	o_param_abc.2675
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	lw	$v1, -5($sp)
	move	$t8, $ra
	move	$a1, $v0
	move	$a0, $v1
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	veciprod.2634
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6422)
	lw	$v0, -2($sp)
	swc1	$f2, -6($sp)
	swc1	$f3, -7($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	o_param_a.2669
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -7($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_light
	li	$v1, 0
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	sub.s	$f2, $f2, $f4
	lwc1	$f4, 0(l.6422)
	lw	$v0, -2($sp)
	swc1	$f2, -8($sp)
	swc1	$f4, -9($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -10($sp)
	addi	$sp, $sp, -11
	jal	o_param_b.2671
	addi	$sp, $sp, 11
	lw	$t8, -10($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -9($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_light
	li	$v1, 1
	add	$at, $v0, $v1
	lwc1	$f4, 0($at)
	sub.s	$f2, $f2, $f4
	lwc1	$f4, 0(l.6422)
	lw	$v0, -2($sp)
	swc1	$f2, -10($sp)
	swc1	$f4, -11($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	o_param_c.2673
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -11($sp)
	mul.s	$f2, $f3, $f2
	lwc1	$f3, -6($sp)
	mul.s	$f2, $f2, $f3
	li	$v0, min_caml_light
	li	$v1, 2
	add	$at, $v0, $v1
	lwc1	$f3, 0($at)
	sub.s	$f2, $f2, $f3
	lwc1	$f3, -4($sp)
	lwc1	$f4, -8($sp)
	lwc1	$f5, -10($sp)
	lw	$v0, -1($sp)
	lw	$v1, 0($sp)
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	mov.s	$f15, $f2
	mov.s	$f14, $f5
	mov.s	$f13, $f4
	mov.s	$f12, $f3
	sw	$t8, -12($sp)
	addi	$sp, $sp, -13
	jal	add_reflection.3071
	addi	$sp, $sp, 13
	lw	$t8, -12($sp)
	move	$ra, $t8
	li	$v0, min_caml_n_reflections
	li	$v1, 0
	li	$a0, 1
	lw	$a1, -1($sp)
	add	$a0, $a1, $a0
	add	$at, $v0, $v1
	sw	$a0, 0($at)
	jr	$ra
setup_reflections.3084:
	li	$v0, 0
	sub	$at, $v0, $a0
	bgtz	$at, ble_else.8767
	li	$v0, min_caml_objects
	add	$at, $v0, $a0
	lw	$v0, 0($at)
	sw	$a0, 0($sp)
	sw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_reflectiontype.2663
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 2
	bne	$v0, $v1, beq_else.8768
	lw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_diffuse.2683
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, 0(l.6298)
	move	$t8, $ra
	mov.s	$f13, $f3
	mov.s	$f12, $f2
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_fless
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 0
	bne	$v0, $v1, beq_else.8769
	jr	$ra
beq_else.8769:
	lw	$v0, -1($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	o_form.2661
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v1, 1
	bne	$v0, $v1, beq_else.8771
	lw	$v0, 0($sp)
	lw	$v1, -1($sp)
	move	$a1, $v1
	move	$a0, $v0
	j	setup_rect_reflection.3078
beq_else.8771:
	li	$v1, 2
	bne	$v0, $v1, beq_else.8772
	lw	$v0, 0($sp)
	lw	$v1, -1($sp)
	move	$a1, $v1
	move	$a0, $v0
	j	setup_surface_reflection.3081
beq_else.8772:
	jr	$ra
beq_else.8768:
	jr	$ra
ble_else.8767:
	jr	$ra
rt.3086:
	lw	$v0, 3($gp)
	lw	$v1, 2($gp)
	lw	$a2, 1($gp)
	li	$a3, min_caml_image_size
	li	$t0, 0
	add	$at, $a3, $t0
	sw	$a0, 0($at)
	li	$a3, min_caml_image_size
	li	$t0, 1
	add	$at, $a3, $t0
	sw	$a1, 0($at)
	li	$a3, min_caml_image_center
	li	$t0, 0
	li	$t1, 2
	srl	$t1, $a0, 1
	add	$at, $a3, $t0
	sw	$t1, 0($at)
	li	$a3, min_caml_image_center
	li	$t0, 1
	li	$t1, 2
	srl	$a1, $a1, 1
	add	$at, $a3, $t0
	sw	$a1, 0($at)
	li	$a1, min_caml_scan_pitch
	li	$a3, 0
	lwc1	$f2, 0(l.6888)
	sw	$v0, 0($sp)
	sw	$v1, -1($sp)
	sw	$a2, -2($sp)
	sw	$a3, -3($sp)
	sw	$a1, -4($sp)
	swc1	$f2, -5($sp)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	min_caml_float_of_int
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	mov.s	$f2, $f0
	move	$ra, $t8
	lwc1	$f3, -5($sp)
	inv.s	$at, $f2
	mul.s	$f2, $f3, $at
	lw	$v0, -3($sp)
	lw	$v1, -4($sp)
	add	$at, $v1, $v0
	swc1	$f2, 0($at)
	move	$t8, $ra
	sw	$t8, -6($sp)
	addi	$sp, $sp, -7
	jal	create_pixelline.3033
	addi	$sp, $sp, 7
	lw	$t8, -6($sp)
	move	$ra, $t8
	sw	$v0, -6($sp)
	move	$t8, $ra
	sw	$t8, -7($sp)
	addi	$sp, $sp, -8
	jal	create_pixelline.3033
	addi	$sp, $sp, 8
	lw	$t8, -7($sp)
	move	$ra, $t8
	sw	$v0, -7($sp)
	move	$t8, $ra
	sw	$t8, -8($sp)
	addi	$sp, $sp, -9
	jal	create_pixelline.3033
	addi	$sp, $sp, 9
	lw	$t8, -8($sp)
	move	$ra, $t8
	sw	$v0, -8($sp)
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	read_parameter.2751
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	write_ppm_header.2994
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	move	$t8, $ra
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	init_dirvecs.3069
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	d_vec.2720
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v1, min_caml_light
	move	$t8, $ra
	move	$a1, $v1
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	veccpy.2623
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	lw	$v0, -2($sp)
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	setup_dirvec_constants.2849
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, min_caml_n_objects
	li	$v1, 0
	add	$at, $v0, $v1
	lw	$v0, 0($at)
	li	$v1, 1
	sub	$v0, $v0, $v1
	move	$t8, $ra
	move	$a0, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	jal	setup_reflections.3084
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, 0
	li	$v1, 0
	lw	$a0, -7($sp)
	lw	$a1, -1($sp)
	move	$t8, $ra
	move	$a2, $v1
	move	$gp, $a1
	move	$a1, $v0
	sw	$t8, -9($sp)
	addi	$sp, $sp, -10
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 10
	lw	$t8, -9($sp)
	move	$ra, $t8
	li	$v0, 0
	li	$v1, 2
	lw	$a0, -6($sp)
	lw	$a1, -7($sp)
	lw	$a2, -8($sp)
	lw	$a3, 0($sp)
	move	$t0, $v1
	move	$gp, $a3
	move	$a3, $a2
	move	$a2, $a1
	move	$a1, $a0
	move	$a0, $v0
	lw	$t8, 0($gp)
	jr	$t8
_min_caml_start: # main entry point
   # main program start
	li	$v0, 0
	lwc1	$f2, 0(l.6297)
	move	$t8, $ra
	move	$a0, $v0
	mov.s	$f12, $f2
	sw	$t8, 0($sp)
	addi	$sp, $sp, -1
	jal	min_caml_create_float_array
	addi	$sp, $sp, 1
	lw	$t8, 0($sp)
	move	$ra, $t8
	li	$v1, 3
	lwc1	$f2, 0(l.6297)
	sw	$v0, 0($sp)
	move	$t8, $ra
	move	$a0, $v1
	mov.s	$f12, $f2
	sw	$t8, -1($sp)
	addi	$sp, $sp, -2
	jal	min_caml_create_float_array
	addi	$sp, $sp, 2
	lw	$t8, -1($sp)
	move	$ra, $t8
	li	$v1, 60
	lw	$a0, 0($sp)
	sw	$v0, -1($sp)
	move	$t8, $ra
	move	$a1, $a0
	move	$a0, $v1
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	jal	min_caml_create_array
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	move	$v1, $hp
	addi	$hp, $hp, 2
	sw	$v0, 1($v1)
	lw	$v0, -1($sp)
	sw	$v0, 0($v1)
	move	$v0, $v1
	move	$v1, $hp
	addi	$hp, $hp, 2
	li	$a0, shadow_check_and_group.2882
	sw	$a0, 0($v1)
	sw	$v0, 1($v1)
	move	$a0, $hp
	addi	$hp, $hp, 2
	li	$a1, shadow_check_one_or_group.2885
	sw	$a1, 0($a0)
	sw	$v1, 1($a0)
	move	$v1, $hp
	addi	$hp, $hp, 3
	li	$a1, shadow_check_one_or_matrix.2888
	sw	$a1, 0($v1)
	sw	$a0, 2($v1)
	sw	$v0, 1($v1)
	move	$a0, $hp
	addi	$hp, $hp, 2
	li	$a1, trace_reflections.2935
	sw	$a1, 0($a0)
	sw	$v1, 1($a0)
	move	$a1, $hp
	addi	$hp, $hp, 3
	li	$a2, trace_ray.2940
	sw	$a2, 0($a1)
	sw	$a0, 2($a1)
	sw	$v1, 1($a1)
	move	$a0, $hp
	addi	$hp, $hp, 2
	li	$a2, trace_diffuse_ray.2946
	sw	$a2, 0($a0)
	sw	$v1, 1($a0)
	move	$v1, $hp
	addi	$hp, $hp, 2
	li	$a2, iter_trace_diffuse_rays.2949
	sw	$a2, 0($v1)
	sw	$a0, 1($v1)
	move	$a0, $hp
	addi	$hp, $hp, 2
	li	$a2, trace_diffuse_rays.2954
	sw	$a2, 0($a0)
	sw	$v1, 1($a0)
	move	$v1, $hp
	addi	$hp, $hp, 2
	li	$a2, trace_diffuse_ray_80percent.2958
	sw	$a2, 0($v1)
	sw	$a0, 1($v1)
	move	$a2, $hp
	addi	$hp, $hp, 2
	li	$a3, calc_diffuse_using_1point.2962
	sw	$a3, 0($a2)
	sw	$v1, 1($a2)
	move	$v1, $hp
	addi	$hp, $hp, 2
	li	$a3, do_without_neighbors.2971
	sw	$a3, 0($v1)
	sw	$a2, 1($v1)
	move	$a2, $hp
	addi	$hp, $hp, 2
	li	$a3, try_exploit_neighbors.2987
	sw	$a3, 0($a2)
	sw	$v1, 1($a2)
	move	$a3, $hp
	addi	$hp, $hp, 2
	li	$t0, pretrace_diffuse_rays.3000
	sw	$t0, 0($a3)
	sw	$a0, 1($a3)
	move	$a0, $hp
	addi	$hp, $hp, 3
	li	$t0, pretrace_pixels.3003
	sw	$t0, 0($a0)
	sw	$a1, 2($a0)
	sw	$a3, 1($a0)
	move	$a1, $hp
	addi	$hp, $hp, 2
	li	$a3, pretrace_line.3010
	sw	$a3, 0($a1)
	sw	$a0, 1($a1)
	move	$a0, $hp
	addi	$hp, $hp, 3
	li	$a3, scan_pixel.3014
	sw	$a3, 0($a0)
	sw	$a2, 2($a0)
	sw	$v1, 1($a0)
	move	$v1, $hp
	addi	$hp, $hp, 3
	li	$a2, scan_line.3020
	sw	$a2, 0($v1)
	sw	$a0, 2($v1)
	sw	$a1, 1($v1)
	move	$a0, $hp
	addi	$hp, $hp, 4
	li	$a2, rt.3086
	sw	$a2, 0($a0)
	sw	$v1, 3($a0)
	sw	$a1, 2($a0)
	sw	$v0, 1($a0)
	li	$v0, 128
	li	$v1, 128
	move	$t8, $ra
	move	$a1, $v1
	move	$gp, $a0
	move	$a0, $v0
	sw	$t8, -2($sp)
	addi	$sp, $sp, -3
	lw	$t8, 0($gp)
	jalr	$ra, $t8
	addi	$sp, $sp, 3
	lw	$t8, -2($sp)
	move	$ra, $t8
	li	$v0, 0
   # main program end
	jr	$ra
