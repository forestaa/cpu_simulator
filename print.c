#include <stdio.h>
#include <stdint.h>

extern int32_t pc, cc, reg[32], memory[1048576];
extern float freg[32];
extern int instr_c, add_c, sub_c, slt_c, and_c, or_c, xor_c, sll_c, srl_c, addi_c, addiu_c, j_c, jr_c, jal_c, jalr_c, beq_c, bne_c, blez_c, bgez_c, bgtz_c, bltz_c, lui_c, ori_c, li_c, move_c, sw_c, lw_c, add_s_c, sub_s_c, mul_s_c, div_s_c, mov_s_c, c_eq_s_c, c_olt_s_c, c_ole_s_c, bc1t_c, swc1_c, lwc1_c, mfc1_c, mtc1_c, cvt_s_w_c, trunc_w_s_c, syscall_c;

void print_status()
{
  int i;

  fprintf(stderr, "instructions: %d\n", instr_c);
  fprintf(stderr, "add         : %d\n", add_c);
  fprintf(stderr, "sub         : %d\n", sub_c);
  fprintf(stderr, "slt         : %d\n", slt_c);
  fprintf(stderr, "and         : %d\n", and_c);
  fprintf(stderr, "or          : %d\n", or_c);
  fprintf(stderr, "xor         : %d\n", xor_c); 
  fprintf(stderr, "sll         : %d\n", sll_c); 
  fprintf(stderr, "srl         : %d\n", srl_c); 
  fprintf(stderr, "addi        : %d\n", addi_c); 
  fprintf(stderr, "addiu       : %d\n", addiu_c); 
  fprintf(stderr, "j           : %d\n", j_c);  
  fprintf(stderr, "jr          : %d\n", jr_c); 
  fprintf(stderr, "jal         : %d\n", jal_c); 
  fprintf(stderr, "jalr        : %d\n", jalr_c);
  fprintf(stderr, "beq         : %d\n", beq_c); 
  fprintf(stderr, "bne         : %d\n", bne_c); 
  fprintf(stderr, "blez        : %d\n", blez_c); 
  fprintf(stderr, "bgez        : %d\n", bgez_c); 
  fprintf(stderr, "bgtz        : %d\n", bgtz_c); 
  fprintf(stderr, "bltz        : %d\n", bltz_c);
  fprintf(stderr, "lui         : %d\n", lui_c);
  fprintf(stderr, "ori         : %d\n", ori_c);
  fprintf(stderr, "move        : %d\n", move_c);
  fprintf(stderr, "sw          : %d\n", sw_c);
  fprintf(stderr, "lw          : %d\n", lw_c);
  fprintf(stderr, "add_s       : %d\n", add_s_c);
  fprintf(stderr, "sub_s       : %d\n", sub_s_c);
  fprintf(stderr, "mul_s       : %d\n", mul_s_c);
  fprintf(stderr, "div_s       : %d\n", div_s_c);
  fprintf(stderr, "mov_s       : %d\n", mov_s_c);
  fprintf(stderr, "c_eq_s      : %d\n", c_eq_s_c);
  fprintf(stderr, "c_olt_s     : %d\n", c_olt_s_c);
  fprintf(stderr, "c_ole_s     : %d\n", c_ole_s_c);
  fprintf(stderr, "bc1t        : %d\n", bc1t_c);
  fprintf(stderr, "swc1        : %d\n", swc1_c);
  fprintf(stderr, "lwc1        : %d\n", lwc1_c);
  fprintf(stderr, "mfc1        : %d\n", mfc1_c);
  fprintf(stderr, "mtc1        : %d\n", mtc1_c);
  fprintf(stderr, "cvt.s.w     : %d\n", cvt_s_w_c);
  fprintf(stderr, "trunc.w.s   : %d\n", trunc_w_s_c);
  fprintf(stderr, "syscall     : %d\n", syscall_c);
    
  for(i = 0; i < 32; i++)
    fprintf(stderr, "r%-2d  %d\n", i, reg[i]);
 
  for(i = 0; i < 32; i++)
    fprintf(stderr, "f%-2d  %f\n", i, freg[i]);

}