#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include "def.h"

unsigned int instr_c = 0, add_c = 0, sub_c = 0, slt_c = 0, and_c = 0, or_c = 0, xor_c = 0, sll_c = 0, srl_c = 0, sllv_c = 0;
unsigned int addi_c = 0, addiu_c = 0, jr_c = 0, j_c = 0, jal_c = 0, jalr_c = 0, beq_c = 0, bne_c = 0, blez_c = 0, bgez_c = 0, bgtz_c = 0, bltz_c = 0;
unsigned int lui_c = 0, ori_c = 0, li_c = 0, move_c = 0, sw_c = 0, lw_c = 0, add_s_c = 0, sub_s_c = 0, mul_s_c = 0, inv_s_c = 0, sqrt_s_c = 0, mov_s_c = 0, neg_s_c = 0;
unsigned int c_eq_s_c = 0, c_olt_s_c = 0, c_ole_s_c = 0, bc1t_c = 0, bc1f_c = 0, swc1_c = 0, lwc1_c = 0, mfc1_c = 0, mtc1_c = 0, cvt_s_w_c = 0, trunc_w_s_c = 0, syscall_c = 0;
int stepflag = 0, stepcount = 0, breakflag = 0, breakpoint, printflag = 0, instrprint = 0;
int32_t pc = 0, cc = 0;
Value reg[32], freg[32], memory[1048576];
FILE *fpin, *fpout;

void getoption(int, char **);
void bpoint(uint32_t);
void exec(uint32_t);
void print_status();

static inline void read_data(void *ptr, size_t size, size_t nmemb, FILE *fp)
{
  if(fread(ptr, size, nmemb, fp) == 0) {
    perror("cannot read\n");
    exit(1);
  }

  return;
}

int main(int argc, char *argv[])
{
  FILE *fp;
  int i, n, pc_init;
  uint32_t pm[50000];
  float x = 0.0;

  fpin = stdin;
  fpout = stdout;

  for(i = 0; i < 32; i++) {
    reg[i].i = 0;
    freg[i].i = 0;
  }

  reg[29].i = 1048575;
  reg[30].i = 65536;
  
  for(i = 0; i < 1048576; i++)
    memory[i].i = 0;

  if((fp = fopen(argv[argc-1],"r")) == NULL) {
    perror("open error");
    return 0;
  }

  i = reg[30].i;
  read_data(&memory[i],4,1,fp);
  while(memory[i].ui != 0x7000003f) {
    reg[30].i++;
    i = reg[30].i;
    read_data(&memory[i],4,1,fp);
  }
  i = reg[30].i;
  memory[i].ui = 0;

  read_data(&pc,4,1,fp);
  read_data(pm,4,50000,fp);
  fclose(fp);

  getoption(argc, argv); 
  
  for(i = 0; i < 50000; i++) {
    if(pm[i] == 0xffffffff) {
      reg[31].i = i;
      break;
    } else {
      if(instrprint == 1)
	fprintf(stderr, "%08x\n",pm[i]);
    }
  }

  pc_init = pc;
  while(x < 2*M_PI) {
    freg[12].f = x;

    while(pc < 50000) {

      bpoint(pm[pc]);
      
      if(pm[pc] == 0xffffffff)
	break;
      else
	exec(pm[pc]);
    
      if(stepcount > 0)
	stepcount--;
      
      instr_c++;
    }
    fprintf(fpout, "%f %f\n", x, freg[0].f);
    x += 0.01;
    pc = pc_init;
    for(n = 0; n < 32; n++)
      freg[n].i = 0;
  }

  fprintf(stderr, "complete instructions\n");
  print_status();

  return 0;
}
