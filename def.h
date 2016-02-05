#ifndef __DEF_H__
#define __DEF_H__

typedef union Value_ {
  int i;
  uint32_t ui;
  float f;
  char c;
} Value;

typedef struct Program_ {
  int inum;
  int op1;
  int op2;
  int op3;
} Program;
  
extern int pc, cc;
extern Value reg[32], freg[32], memory[1048576];
extern int stepflag, stepcount, breakflag, breakpoint, printflag, instrprint, inflag, outflag;
extern long long unsigned int instructions;
extern unsigned int icount[45];
extern FILE *fpin, *fpout;

extern char inum2instr[44][20];

#endif
