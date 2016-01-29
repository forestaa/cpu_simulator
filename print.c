#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "def.h"

void print_status()
{
  int i;
  FILE *fp = stderr;

  fprintf(fp, "instructions: %llu\n", instructions);

  for(i = 0; i < 44; i++)
    fprintf(fp, "%-11s : %10u  %lf%%\n", inum2instr[i], icount[i], (double)icount[i]/instructions*100);
    
  for(i = 0; i < 32; i++)
    fprintf(stderr, "r%-2d  %8d  0x%08x\n", i, reg[i].i, reg[i].ui);
 
  for(i = 0; i < 32; i++)
    fprintf(stderr, "f%-2d  %8f  0x%08x\n", i, freg[i].f, freg[i].ui);

}

char *regname(int);
void print_instr(Program p, int pc_)
{
  char instr[20];

  strcpy(instr, inum2instr[p.inum]);

  if(strcmp(instr, "syscall") == 0)
    fprintf(stderr, "[%4d]:syscall     $v0 = %d    %lldinstructions\n", pc_, reg[2].i, instructions);
  else if(strcmp(instr, "j") == 0 || strcmp(instr, "jal") == 0 || strcmp(instr, "bc1t") == 0 || strcmp(instr, "bc1f") == 0)
    fprintf(stderr, "[%4d]:%-10s %d                %lldinstrutions\n", pc_, instr, p.op1, instructions);
  else if(strcmp(instr, "jr") == 0)
    fprintf(stderr, "[%4d]:%-10s %s                %lldinstructions\n", pc_, instr, regname(p.op1), instructions);
  else if(strcmp(instr, "blez") == 0 || strcmp(instr, "bgez") == 0 || strcmp(instr, "bltz") == 0 || strcmp(instr, "bgtz") == 0 || strcmp(instr, "lui") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %d             %lldinstructions\n", pc_, instr, regname(p.op1), p.op2, instructions);
  else if(strcmp(instr, "mfc1") == 0 || strcmp(instr, "mtc1") == 0)
    fprintf(stderr, "[%4d]:%-10s %s $f%d           %lldinstructions\n", pc_, instr, regname(p.op1), p.op2, instructions);
  else if(strcmp(instr, "jalr") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %s             %lldinstructions\n", pc_, instr, regname(p.op2), regname(p.op1), instructions);
  else if(strcmp(instr, "sll") == 0 || strcmp(instr, "srl") == 0 || strcmp(instr, "addi") == 0 || strcmp(instr, "addiu") == 0 || strcmp(instr, "ori") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %s %d          %lldinstructions\n", pc_, instr, regname(p.op2), regname(p.op1), p.op3, instructions);
  else if(strcmp(instr, "beq") == 0 || strcmp(instr, "bne") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %s %d          %lldinstructions\n", pc_, instr, regname(p.op1), regname(p.op2), p.op3, instructions);
  else if(strcmp(instr, "lw") == 0 || strcmp(instr, "sw") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %d(%s)         %lldinstrutions\n", pc_, instr, regname(p.op2), p.op3, regname(p.op1), instructions);
  else if(strcmp(instr, "lwc1") == 0 || strcmp(instr, "swc1") == 0)
    fprintf(stderr, "[%4d]:%-10s $f%-2d %d(%s)    %lldinstructions\n", pc_, instr, p.op2, p.op3, regname(p.op1), instructions);
  else if(strcmp(instr, "add") == 0 || strcmp(instr, "sub") == 0 || strcmp(instr, "slt") == 0 || strcmp(instr, "and") == 0 || strcmp(instr, "or") == 0 || strcmp(instr, "xor") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %s %s         %lldinstrutions\n", pc_, instr, regname(p.op3), regname(p.op1), regname(p.op2), instructions);
  else if(strcmp(instr, "sllv") == 0)
    fprintf(stderr, "[%4d]:%-10s %s %s %s         %lldinstructions\n", pc_, instr, regname(p.op3), regname(p.op2), regname(p.op1), instructions);
  else if(strcmp(instr, "inv.s") == 0 || strcmp(instr, "sqrt.s") == 0 || strcmp(instr, "mov.s") == 0 || strcmp(instr, "neg.s") == 0 || strcmp(instr, "trunc.w.s") == 0 || strcmp(instr, "cvt.s.w") == 0 || strcmp(instr, "c.eq.s") == 0 || strcmp(instr, "c.olt.s") == 0 || strcmp(instr, "c.ole.s") == 0)
    fprintf(stderr, "[%4d]:%-10s $f%-2d $f%d      %lldinstructions\n", pc_, instr, p.op2, p.op1, instructions);
  else if(strcmp(instr, "add.s") == 0 || strcmp(instr, "sub.s") == 0 || strcmp(instr, "mul.s") == 0)    fprintf(stderr, "[%4d]:%-10s $f%-2d $f%-2d $f%d    %lldinstrutions\n", pc_, instr, p.op3, p.op2, p.op1, instructions);
  else if(p.inum != 44)
    fprintf(stderr, "[%4d]: printbug %s           %lldinstrutions\n", pc_, instr, instructions);
}
