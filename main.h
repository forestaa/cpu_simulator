#ifndef __MAIN_H_
#define __MAIN_H_

long long unsigned int instr_c = 0;
unsigned int add_c = 0, sub_c = 0, slt_c = 0, and_c = 0, or_c = 0, xor_c = 0, sll_c = 0, srl_c = 0, sllv_c = 0;
unsigned int addi_c = 0, addiu_c = 0, jr_c = 0, j_c = 0, jal_c = 0, jalr_c = 0, beq_c = 0, bne_c = 0, blez_c = 0, bgez_c = 0, bgtz_c = 0, bltz_c = 0;
unsigned int lui_c = 0, ori_c = 0, sw_c = 0, lw_c = 0, add_s_c = 0, sub_s_c = 0, mul_s_c = 0, inv_s_c = 0, sqrt_s_c = 0, mov_s_c = 0, neg_s_c = 0;
unsigned int c_eq_s_c = 0, c_olt_s_c = 0, c_ole_s_c = 0, bc1t_c = 0, bc1f_c = 0, swc1_c = 0, lwc1_c = 0, mfc1_c = 0, mtc1_c = 0, cvt_s_w_c = 0, trunc_w_s_c = 0, syscall_c = 0;
int stepflag = 0, stepcount = 0, breakflag = 0, breakpoint, printflag = 0, instrprint = 0;
int32_t pc = 0, cc = 0;
Value reg[32], freg[32], memory[1048576];
FILE *fpin, *fpout;

void getoption(int, char **);
void bpoint(uint32_t);
void exec(uint32_t);
void print_status();

#endif
