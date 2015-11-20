#ifndef __DEF_H__
#define __DEF_H__

typedef union Value_ {
  int i;
  uint32_t ui;
  float f;
  char c;
} Value;

extern int32_t pc, cc;
extern Value reg[32], freg[32], memory[1048576];
extern int stepflag, stepcount, breakflag, breakpoint, printflag, instrprint, instr_c, add_c, sub_c, slt_c, and_c, or_c, xor_c, sll_c, srl_c, sllv_c, addi_c, addiu_c, j_c, jr_c, jal_c, jalr_c, beq_c, bne_c, blez_c, bgez_c, bgtz_c, bltz_c, lui_c, ori_c, li_c, move_c, sw_c, lw_c, add_s_c, sub_s_c, mul_s_c, div_s_c, sqrt_s_c, mov_s_c, neg_s_c, c_eq_s_c, c_olt_s_c, c_ole_s_c, bc1t_c, swc1_c, lwc1_c, mfc1_c, mtc1_c, cvt_s_w_c, trunc_w_s_c, syscall_c;
extern FILE *fpin, *fpout;

#endif
