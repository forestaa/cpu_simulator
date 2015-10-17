     li     $r1, 4
     addi   $r3, $r1, 5
     jalr   $r31, $r1
     add    $r2, $r1, $r0
     sw     $r1, 1($r1)
     lw	    $r4, 1($r1)
.fib1:
     xor    $r5, $r1, $r3
     sll    $r6, $r5, 2
     srl    $r7, $r5, 2
