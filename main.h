#ifndef __MAIN_H_
#define __MAIN_H_

long long unsigned int instructions = -1;
unsigned int icount[45] = {0};
int stepflag = 0, stepcount = 0, breakflag = 0, breakpoint, printflag = 0, instrprint = 0;
int pc = 0, cc = 0;
Value reg[32], freg[32], memory[1048576];
FILE *fpin, *fpout;

void getoption(int, char **);
void print_status();
void load(FILE *, Program *);

#endif
