	      .data
l.6888:	 # 128.000000
	      .word	1124073472
l.6855:	 # 0.900000
	      .word	1063675494
        .text
_min_caml_start:
        lwc1      $f0, 0(l.6888)
        add.s     $f1, $f0, $f0
        sub.s     $f2, $f1, $f0
        mul.s     $f3, $f0, $f0
        inv.s     $f4, $f0
        sqrt.s    $f5, $f0
        trunc.w.s $f6, $f1
        cvt.s.w   $f7, $f6
        mfc1      $r1, $f7
        mtc1      $r1, $f8
        mov.s     $f9, $f8
        swc1      $f9, 0($hp)
        lwc1      $f10, 0($hp)
        sw        $ra, 0($sp)
        jal       abc
        lw        $ra, 0($sp)
        jr        $ra
abc:
        c.eq.s    0, $f8, $f9
        bc1t      0, def
        jr        $ra
def:    
        c.olt.s   0, $f5, $f4
        bc1t      0, ghi
        neg.s     $f11, $f10
        jr        $ra
ghi:
        jr        $ra
