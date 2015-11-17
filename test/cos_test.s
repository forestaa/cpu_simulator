	.data
x3:
	.word	1083619410
x2:
	.word	1078523331
x1:
	.word	1070134723
a4:
	.word	1019893672
a3:
	.word	3192858555
a2:
	.word	1023136372
a1:
	.word	1065213965
	.text
_min_caml_start:
min_caml_cos:
	lwc1	$f4, 0(x1)
	c.olt.s	0, $f12, $f4
	bc1t	0, cos_branch1
	lwc1	$f4, 0(x2)
	c.olt.s	0, $f12, $f4
	bc1t	0, cos_branch2
	lwc1	$f4, 0(x3)
	c.olt.s	0, $f12, $f4
	bc1t	0, cos_branch3
        li	$f0, 1
	sub.s	$f12, $f12, $f4
	j	calc
cos_branch3:
        li	$f0, -1
	sub.s	$f12, $f4, $f12
	j	calc
cos_branch2:
	lwc1	$f4, 0(x1)
        li	$f0, -1
	sub.s	$f12, $f12, $f4
	j	calc
cos_branch1:
        li	$f0, 1
	sub.s	$f12, $f4, $f12
	j	calc
calc:
	lwc1	$f16, 0(a1)
	lwc1	$f17, 0(a2)
	lwc1	$f18, 0(a3)
	lwc1	$f19, 0(a4)
	mul.s	$f19, $f19, $f12
	add.s	$f19, $f19, $f18
	mul.s   $f19, $f19, $f12
	add.s	$f19, $f19, $f17
	mul.s	$f19, $f19, $f12
	add.s	$f19, $f19, $f16
	mul.s	$f19, $f19, $f12
	mul.s	$f0, $f19, $f0
	jr	$r31
