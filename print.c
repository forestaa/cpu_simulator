#include <stdio.h>
#include <stdint.h>
#include <stdarg.h>
#include <string.h>
#include "def.h"

void print_status()
{
  int i;

  fprintf(stderr, "instructions: %u\n", instr_c);
  fprintf(stderr, "add         : %u\n", add_c);
  fprintf(stderr, "sub         : %u\n", sub_c);
  fprintf(stderr, "slt         : %u\n", slt_c);
  fprintf(stderr, "and         : %u\n", and_c);
  fprintf(stderr, "or          : %u\n", or_c);
  fprintf(stderr, "xor         : %u\n", xor_c); 
  fprintf(stderr, "sll         : %u\n", sll_c); 
  fprintf(stderr, "srl         : %u\n", srl_c);
  fprintf(stderr, "sllv        : %u\n", sllv_c);
  fprintf(stderr, "addi        : %u\n", addi_c); 
  fprintf(stderr, "addiu       : %u\n", addiu_c); 
  fprintf(stderr, "j           : %u\n", j_c);  
  fprintf(stderr, "jr          : %u\n", jr_c); 
  fprintf(stderr, "jal         : %u\n", jal_c); 
  fprintf(stderr, "jalr        : %u\n", jalr_c);
  fprintf(stderr, "beq         : %u\n", beq_c); 
  fprintf(stderr, "bne         : %u\n", bne_c); 
  fprintf(stderr, "blez        : %u\n", blez_c); 
  fprintf(stderr, "bgez        : %u\n", bgez_c); 
  fprintf(stderr, "bgtz        : %u\n", bgtz_c); 
  fprintf(stderr, "bltz        : %u\n", bltz_c);
  fprintf(stderr, "lui         : %u\n", lui_c);
  fprintf(stderr, "ori         : %u\n", ori_c);
  fprintf(stderr, "move        : %u\n", move_c);
  fprintf(stderr, "sw          : %u\n", sw_c);
  fprintf(stderr, "lw          : %u\n", lw_c);
  fprintf(stderr, "add_s       : %u\n", add_s_c);
  fprintf(stderr, "sub_s       : %u\n", sub_s_c);
  fprintf(stderr, "mul_s       : %u\n", mul_s_c);
  fprintf(stderr, "div_s       : %u\n", div_s_c);
  fprintf(stderr, "sqrt_s      : %u\n", sqrt_s_c);
  fprintf(stderr, "mov_s       : %u\n", mov_s_c);
  fprintf(stderr, "neg_s       : %u\n", neg_s_c);
  fprintf(stderr, "c_eq_s      : %u\n", c_eq_s_c);
  fprintf(stderr, "c_olt_s     : %u\n", c_olt_s_c);
  fprintf(stderr, "c_ole_s     : %u\n", c_ole_s_c);
  fprintf(stderr, "bc1t        : %u\n", bc1t_c);
  fprintf(stderr, "swc1        : %u\n", swc1_c);
  fprintf(stderr, "lwc1        : %u\n", lwc1_c);
  fprintf(stderr, "mfc1        : %u\n", mfc1_c);
  fprintf(stderr, "mtc1        : %u\n", mtc1_c);
  fprintf(stderr, "cvt.s.w     : %u\n", cvt_s_w_c);
  fprintf(stderr, "trunc.w.s   : %u\n", trunc_w_s_c);
  fprintf(stderr, "syscall     : %u\n", syscall_c);
    
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
  else if(strcmp(instr, "j") == 0 || strcmp(instr, "jal") == 0 || strcmp(instr, "bc1t") == 0) {
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
