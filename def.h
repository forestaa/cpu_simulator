#ifndef __DEF_H__
#define __DEF_H__

typedef union Memory_ {
  int i;
  float f;
} Memory;

typedef struct Assembli_ {
  int line, arg1, arg2, arg3, addr;
  char label[30], instr[20], arglabel[30], comment[30];
  Memory value;
} Assembli;

extern int32_t pc, cc, reg[32];
extern float freg[32];
extern Memory memory[1048576];
extern int stepflag, breakflag, breakpoint, printflag, instr_c, add_c, sub_c, slt_c, and_c, or_c, xor_c, sll_c, srl_c, addi_c, addiu_c, j_c, jr_c, jal_c, jalr_c, beq_c, bne_c, blez_c, bgez_c, bgtz_c, bltz_c, lui_c, ori_c, li_c, move_c, sw_c, lw_c, add_s_c, sub_s_c, mul_s_c, div_s_c, mov_s_c, c_eq_s_c, c_olt_s_c, c_ole_s_c, bc1t_c, swc1_c, lwc1_c, mfc1_c, mtc1_c, cvt_s_w_c, trunc_w_s_c, syscall_c;

#endif
