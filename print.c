#include <stdio.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>
#include "def.h"

void print_status()
{
  int i;

  fprintf(stderr, "instructions: %u\n", instr_c);
  fprintf(stderr, "add         : %10u  %lf%%\n", add_c, (double)add_c/instr_c*100);
  fprintf(stderr, "sub         : %10u  %lf%%\n", sub_c, (double)sub_c/instr_c*100);
  fprintf(stderr, "slt         : %10u  %lf%%\n", slt_c, (double)slt_c/instr_c*100);
  fprintf(stderr, "and         : %10u  %lf%%\n", and_c, (double)and_c/instr_c*100);
  fprintf(stderr, "or          : %10u  %lf%%\n", or_c, (double)or_c/instr_c*100);
  fprintf(stderr, "xor         : %10u  %lf%%\n", xor_c, (double)xor_c/instr_c*100); 
  fprintf(stderr, "sll         : %10u  %lf%%\n", sll_c, (double)sll_c/instr_c*100); 
  fprintf(stderr, "srl         : %10u  %lf%%\n", srl_c, (double)srl_c/instr_c*100);
  fprintf(stderr, "sllv        : %10u  %lf%%\n", sllv_c, (double)sllv_c/instr_c*100);
  fprintf(stderr, "addi        : %10u  %lf%%\n", addi_c, (double)addi_c/instr_c*100); 
  fprintf(stderr, "addiu       : %10u  %lf%%\n", addiu_c, (double)addiu_c/instr_c*100); 
  fprintf(stderr, "j           : %10u  %lf%%\n", j_c, (double)j_c/instr_c*100);  
  fprintf(stderr, "jr          : %10u  %lf%%\n", jr_c, (double)jr_c/instr_c*100); 
  fprintf(stderr, "jal         : %10u  %lf%%\n", jal_c, (double)jal_c/instr_c*100); 
  fprintf(stderr, "jalr        : %10u  %lf%%\n", jalr_c, (double)jalr_c/instr_c*100);
  fprintf(stderr, "beq         : %10u  %lf%%\n", beq_c, (double)beq_c/instr_c*100); 
  fprintf(stderr, "bne         : %10u  %lf%%\n", bne_c, (double)bne_c/instr_c*100); 
  fprintf(stderr, "blez        : %10u  %lf%%\n", blez_c, (double)blez_c/instr_c*100); 
  fprintf(stderr, "bgez        : %10u  %lf%%\n", bgez_c, (double)bgez_c/instr_c*100); 
  fprintf(stderr, "bgtz        : %10u  %lf%%\n", bgtz_c, (double)bgtz_c/instr_c*100); 
  fprintf(stderr, "bltz        : %10u  %lf%%\n", bltz_c, (double)bltz_c/instr_c*100);
  fprintf(stderr, "lui         : %10u  %lf%%\n", lui_c, (double)lui_c/instr_c*100);
  fprintf(stderr, "ori         : %10u  %lf%%\n", ori_c, (double)ori_c/instr_c*100);
  fprintf(stderr, "sw          : %10u  %lf%%\n", sw_c, (double)sw_c/instr_c*100);
  fprintf(stderr, "lw          : %10u  %lf%%\n", lw_c, (double)lw_c/instr_c*100);
  fprintf(stderr, "add_s       : %10u  %lf%%\n", add_s_c, (double)add_s_c/instr_c*100);
  fprintf(stderr, "sub_s       : %10u  %lf%%\n", sub_s_c, (double)sub_s_c/instr_c*100);
  fprintf(stderr, "mul_s       : %10u  %lf%%\n", mul_s_c, (double)mul_s_c/instr_c*100);
  fprintf(stderr, "div_s       : %10u  %lf%%\n", div_s_c, (double)div_s_c/instr_c*100);
  fprintf(stderr, "sqrt_s      : %10u  %lf%%\n", sqrt_s_c, (double)sqrt_s_c/instr_c*100);
  fprintf(stderr, "mov_s       : %10u  %lf%%\n", mov_s_c, (double)mov_s_c/instr_c*100);
  fprintf(stderr, "neg_s       : %10u  %lf%%\n", neg_s_c, (double)neg_s_c/instr_c*100);
  fprintf(stderr, "c_eq_s      : %10u  %lf%%\n", c_eq_s_c, (double)c_eq_s_c/instr_c*100);
  fprintf(stderr, "c_olt_s     : %10u  %lf%%\n", c_olt_s_c, (double)c_olt_s_c/instr_c*100);
  fprintf(stderr, "c_ole_s     : %10u  %lf%%\n", c_ole_s_c, (double)c_ole_s_c/instr_c*100);
  fprintf(stderr, "bc1t        : %10u  %lf%%\n", bc1t_c, (double)bc1t_c/instr_c*100);
  fprintf(stderr, "bc1f        : %10u  %lf%%\n", bc1f_c, (double)bc1f_c/instr_c*100);
  fprintf(stderr, "swc1        : %10u  %lf%%\n", swc1_c, (double)swc1_c/instr_c*100);
  fprintf(stderr, "lwc1        : %10u  %lf%%\n", lwc1_c, (double)lwc1_c/instr_c*100);
  fprintf(stderr, "mfc1        : %10u  %lf%%\n", mfc1_c, (double)mfc1_c/instr_c*100);
  fprintf(stderr, "mtc1        : %10u  %lf%%\n", mtc1_c, (double)mtc1_c/instr_c*100);
  fprintf(stderr, "cvt.s.w     : %10u  %lf%%\n", cvt_s_w_c, (double)cvt_s_w_c/instr_c*100);
  fprintf(stderr, "trunc.w.s   : %10u  %lf%%\n", trunc_w_s_c, (double)trunc_w_s_c/instr_c*100);
  fprintf(stderr, "syscall     : %10u  %lf%%\n", syscall_c, (double)syscall_c/instr_c*100);
    
  for(i = 0; i < 32; i++)
    fprintf(stderr, "r%-2d  %8d  0x%08x\n", i, reg[i].i, reg[i].ui);
 
  for(i = 0; i < 32; i++)
    fprintf(stderr, "f%-2d  %8f  0x%08x\n", i, freg[i].f, freg[i].ui);

}

char *regname(int);
void print_instr(const char *instr, ...)
{
  int arg1, arg2, arg3;
  va_list args;

  va_start(args, instr);

  if(strcmp(instr, "syscall") == 0)
    fprintf(stderr, "[%4d]:%s   $v0 = %d\n", pc, instr, reg[2].i);
  else if(strcmp(instr, "j") == 0 || strcmp(instr, "jal") == 0 || strcmp(instr, "bc1t") == 0 || strcmp(instr, "bc1f") == 0) {
    arg1 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %d\n", pc, instr, arg1);
  } else if(strcmp(instr, "jr") == 0) {
    arg1 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s\n", pc, instr, regname(arg1));
  } else if(strcmp(instr, "blez") == 0 || strcmp(instr, "bgez") == 0 || strcmp(instr, "bltz") == 0 || strcmp(instr, "bgtz") == 0 || strcmp(instr, "lui") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s %d\n", pc, instr, regname(arg1), arg2);
  } else if(strcmp(instr, "mfc1") == 0 || strcmp(instr, "mtc1") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s $f%d\n", pc, instr, regname(arg1), arg2);
  } else if(strcmp(instr, "jalr") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s %s\n", pc, instr, regname(arg1), regname(arg2));
  } else if(strcmp(instr, "sll") == 0 || strcmp(instr, "srl") == 0 || strcmp(instr, "addi") == 0 || strcmp(instr, "addiu") == 0 || strcmp(instr, "beq") == 0 || strcmp(instr, "bne") == 0 || strcmp(instr, "ori") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    arg3 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s %s %d\n", pc, instr, regname(arg1), regname(arg2), arg3);
  } else if(strcmp(instr, "lw") == 0 || strcmp(instr, "sw") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    arg3 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s %d(%s)\n", pc, instr, regname(arg1), arg2, regname(arg3));
  } else if(strcmp(instr, "lwc1") == 0 || strcmp(instr, "swc1") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    arg3 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s $f%-2d %d(%s)\n", pc, instr, arg1, arg2, regname(arg3));
  } else if(strcmp(instr, "add") == 0 || strcmp(instr, "sub") == 0 || strcmp(instr, "slt") == 0 || strcmp(instr, "and") == 0 || strcmp(instr, "or") == 0 || strcmp(instr, "xor") == 0 || strcmp(instr, "sllv") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    arg3 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s %s %s %s\n", pc, instr, regname(arg1), regname(arg2), regname(arg3));
  } else if(strcmp(instr, "sqrt.s") == 0 || strcmp(instr, "mov.s") == 0 || strcmp(instr, "neg.s") == 0 || strcmp(instr, "trunc.w.s") == 0 || strcmp(instr, "cvt.s.w") == 0 || strcmp(instr, "c.eq.s") == 0 || strcmp(instr, "c.olt.s") == 0 || strcmp(instr, "c.ole.s") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s $f%-2d $f%d\n", pc, instr, arg1, arg2);
  } else if(strcmp(instr, "add.s") == 0 || strcmp(instr, "sub.s") == 0 || strcmp(instr, "mul.s") == 0 || strcmp(instr, "div.s") == 0) {
    arg1 = va_arg(args, int);
    arg2 = va_arg(args, int);
    arg3 = va_arg(args, int);
    fprintf(stderr, "[%4d]:%-10s $f%-2d $f%-2d $f%d\n", pc, instr, arg1, arg2, arg3);
  } else {
    fprintf(stderr, "[%4d]: printbug %s\n", pc, instr);
  }
  
  va_end(args);
  
  return;
}
