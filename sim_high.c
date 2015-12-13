#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
#include <unistd.h>
#include <math.h>
#include "def.h"
#include "main.h"

static inline void exec(uint32_t);
void read_data(void *ptr, size_t size, size_t nmemb, FILE *fp)
{
  if(fread(ptr, size, nmemb, fp) == 0) {
    perror("cannot read\n");
    exit(1);
  }
}

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  uint32_t pm[50000];
  struct timeval tv0,tv1;
  double time;

  fpin = stdin;
  fpout = stdout;

  for(i = 0; i < 32; i++) {
    reg[i].i = 0;
    freg[i].i = 0;
  }

  reg[29].i = 1048575;
  reg[30].i = 0;
  
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
	fprintf(stderr, "[%d]: %08x\n", i, pm[i]);
    }
  }

  gettimeofday(&tv0, NULL);

  while(pc < 50000) {
    if(pm[pc] == 0xffffffff)
      break;
    else
      exec(pm[pc]);
  }

  gettimeofday(&tv1, NULL);
  time = (double)(tv1.tv_sec - tv0.tv_sec + (tv1.tv_usec - tv0.tv_usec)*0.001*0.001);
  fprintf(stderr, "complete instructions\n");
  
  print_status();
  
  fclose(fpin);
  fclose(fpout);

  fprintf(stderr, "time = %lf\n", time);
  return 0;
}

void exec(uint32_t instr)
{
  int i, rs, rt, rd, base, fs, ft, fd;
  int32_t instr_index, j;
  int16_t i16, offset;
  uint16_t sa;
  uint32_t opcode;

  opcode = instr & 0xfc000000;
  if(opcode == 0x00000000) {
    opcode = instr & 0x0000003f;
    if(opcode == 0x00000020) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = reg[rs].i + reg[rt].i;
      pc++;
      add_c++;
    } else if(opcode == 0x00000022) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = reg[rs].i - reg[rt].i;
      pc++;
      sub_c++;
    } else if(opcode == 0x0000002a) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(reg[rs].i < reg[rt].i)
	reg[rd].i = 1;
      else
	reg[rd].i = 0;
      pc++;
      slt_c++;
    } else if(opcode == 0x00000024) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = reg[rs].i & reg[rt].i;
      pc++;
      and_c++;
    } else if(opcode == 0x00000025) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = reg[rs].i | reg[rt].i;
      pc++;
      or_c++;
    } else if(opcode == 0x00000026) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = reg[rs].i ^ reg[rt].i;
      pc++;
      xor_c++;
    } else if(opcode == 0x00000008) {
      rs = (instr >> 21) & 0x0000001f;
      pc = reg[rs].i;
      jr_c++;
    } else if(opcode == 0x00000009) {
      rs = (instr >> 21) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = pc + 1;
      pc = reg[rs].i;
      jalr_c++;
    } else if(opcode == 0x00000000) {
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      sa = (instr >> 6) & 0x0000001f;
      reg[rd].i = reg[rt].i << sa;
      pc++;
      sll_c++;
    } else if(opcode == 0x00000002) {
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      sa = (instr >> 6) & 0x0000001f;
      reg[rd].ui = reg[rt].ui >> sa;
      pc++;
      srl_c++;
    } else if(opcode == 0x00000004) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      reg[rd].i = reg[rt].i << reg[rs].i;
      pc++;
      sllv_c++;
    } else if(opcode == 0x0000000c) {  
      if(reg[2].i == 1)
	fprintf(fpout, "%d", reg[4].i);
      else if(reg[2].i == 2)
	fprintf(fpout, "%f", freg[12].f);
      else if(reg[2].i == 5)
	read_data(&reg[2], 4, 1, fpin);
      else if(reg[2].i == 6)
	read_data(&freg[0], 4, 1, fpin);
      else if(reg[2].i == 11)
	fprintf(fpout, "%c", reg[4].c);
      else if(reg[2].i == 12)
	read_data(&reg[2], 1, 1, fpin);
      else if(reg[2].i == -1)
	freg[0].f = sin(freg[12].f);
      else if(reg[2].i == -2)
	freg[0].f = cos(freg[12].f);
      else if(reg[2].i == -3)
	freg[0].f = atan(freg[12].f);
      else
	fprintf(stderr, "this syscall is not defined, r2 = %08x\n", reg[2].ui);
      pc++;
      syscall_c++;
    } else {
      fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
      pc++;
    }
  } else if(opcode == 0x20000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    i16 = instr;
    reg[rt].i = reg[rs].i + i16;
    pc++;
    addi_c++;
  } else if(opcode == 0x24000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    i16 = instr;
    reg[rt].i = reg[rs].i + i16;
    pc++;
    addiu_c++;
  } else if(opcode == 0x08000000) {
    if((instr & 0x02000000) == 0x02000000)
      instr_index = instr | 0xfc000000;
    else
      instr_index = instr & 0x03ffffff;
    pc = instr_index;
    j_c++;
  } else if(opcode == 0x0c000000) {
    if((instr & 0x02000000) == 0x02000000)
      instr_index = instr | 0xfc000000;
    else
      instr_index = instr & 0x03ffffff;
    reg[31].i = pc + 1; 
    pc = instr_index;
    jal_c++;
  } else if(opcode == 0x10000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    if(reg[rs].i == reg[rt].i)
      pc += offset;
    else
      pc++;
    beq_c++;
  } else if(opcode == 0x14000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    if(reg[rs].i != reg[rt].i)
      pc += offset;
    else
      pc++;
    bne_c++;
  } else if(opcode == 0x18000000) {
    rs = (instr >> 21) & 0x0000001f; 
    offset = instr;
    if(reg[rs].i <= 0)
      pc += offset;
    else
      pc++;
    blez_c++;
  } else if(opcode == 0x04000000) {
    rs = (instr >> 21) & 0x0000001f; 
    offset = instr;
    if((instr & 0x000f0000) == 0x00010000) {
      if(reg[rs].i >= 0)
	pc += offset;
      else
	pc++;
      bgez_c++;
    } else if((instr & 0x000f0000) == 0x00000000) {
      if(reg[rs].i < 0)
	pc += offset;
      else
	pc++;
      bltz_c++;
    } else {
      fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
      pc++;
    }
  } else if(opcode == 0x1c000000) {
    rs = (instr >> 21) & 0x0000001f; 
    offset = instr;
    if(reg[rs].i > 0)
      pc += offset;
    else
      pc++;
    bgtz_c++;
  } else if(opcode == 0x3c000000) {
    rt = (instr >> 16) & 0x0000001f;
    j = instr & 0x0000ffff;
    reg[rt].i = j << 16;
    pc++;
    lui_c++;
  } else if(opcode == 0x34000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    j = instr & 0x0000ffff;
    reg[rt].i = reg[rs].i | j;
    pc++;
    ori_c++;
  } else if(opcode == 0x8c000000) {
    base = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    i = reg[base].i + offset;
    reg[rt].i = memory[i].i;
    pc++;
    lw_c++;
  } else if(opcode == 0xac000000) {
    base = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    i = reg[base].i + offset;
    memory[i].i = reg[rt].i;
    pc++;
    sw_c++;
  } else if(opcode == 0x44000000) {
    opcode = instr & 0x03e00000;
    if(opcode == 0x01000000) {
      offset = instr;
      if((instr & 0x00010000) == 0x00010000) {
	if(cc == 1)
	  pc += offset;
	else
	  pc++;
	bc1t_c++;
      } else {
	if(cc == 0)
	  pc += offset;
	else
	  pc++;
	bc1f_c++;
      }
    } else if(opcode == 0x00000000) {
      fs = (instr >> 11) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      reg[rt].i = freg[fs].i;
      pc++;
      mfc1_c++;
    } else if(opcode == 0x00800000) {
      fs = (instr >> 11) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      freg[fs].f = reg[rt].f;
      pc++;
      mtc1_c++;
    } else { 
      opcode = instr & 0x0000003f;
      if(opcode == 0x00000000) {
	ft = (instr >> 16) & 0x0000001f;
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = freg[fs].f + freg[ft].f;
	pc++;
	add_s_c++;
      } else if(opcode == 0x00000001) {
	ft = (instr >> 16) & 0x0000001f;
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = freg[fs].f - freg[ft].f;
	pc++;
	sub_s_c++;
      } else if(opcode == 0x00000002) {
	ft = (instr >> 16) & 0x0000001f;
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = freg[fs].f * freg[ft].f;
	pc++;
	mul_s_c++;
      } else if(opcode == 0x00000003) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = 1 / freg[fs].f;
	pc++;
	inv_s_c++;
      } else if(opcode == 0x00000004) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = sqrt(freg[fs].f);
	pc++;
	sqrt_s_c++;
      } else if(opcode == 0x00000006) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = freg[fs].f;
	pc++;
	mov_s_c++;
      } else if(opcode == 0x00000007) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = -freg[fs].f;
	pc++;
	neg_s_c++;
      } else if(opcode == 0x0000000d) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].i = freg[fs].f;
	pc++;
	trunc_w_s_c++;
      } else if(opcode == 0x00000020) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	freg[fd].f = freg[fs].i;
	pc++;
	cvt_s_w_c++;
      } else if(opcode == 0x00000032) {
	fs = (instr >> 11) & 0x0000001f;
	ft = (instr >> 16) & 0x0000001f;
	if(freg[fs].f == freg[ft].f)
	  cc = 1;
	else
	  cc = 0;
	pc++;
	c_eq_s_c++;
      } else if(opcode == 0x00000034) {
	fs = (instr >> 11) & 0x0000001f;
	ft = (instr >> 16) & 0x0000001f;
	if(freg[fs].f < freg[ft].f)
	  cc = 1;
	else
	  cc = 0;
	pc++;
	c_olt_s_c++;
      } else if(opcode == 0x0000036) {
	fs = (instr >> 11) & 0x0000001f;
	ft = (instr >> 16) & 0x0000001f;
	if(freg[fs].f <= freg[ft].f)
	  cc = 1;
	else
	  cc = 0;
	pc++;
	c_ole_s_c++;
      } else {
	fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
	pc++;
      }
    }   
  } else if(opcode == 0xe4000000) {
    ft = (instr >> 16) & 0x0000001f;
    base = (instr >> 21) & 0x0000001f;
    offset = instr;
    i = reg[base].i + offset;
    memory[i].f = freg[ft].f;
    pc++;
    swc1_c++;
  } else if(opcode == 0xc4000000) {
    ft = (instr >> 16) & 0x0000001f;
    base = (instr >> 21) & 0x0000001f;
    offset = instr;
    i = reg[base].i + offset;
    freg[ft].f = memory[i].f;
    pc++;
    lwc1_c++;
  } else {
    fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
    pc++;
  }

  instr_c++;
}

void print_status()
{
  int i;
  FILE *fp = stderr;

  fprintf(fp, "instructions: %llu\n", instr_c);
  fprintf(fp, "add         : %10u  %lf%%\n", add_c, (double)add_c/instr_c*100);
  fprintf(fp, "sub         : %10u  %lf%%\n", sub_c, (double)sub_c/instr_c*100);
  fprintf(fp, "slt         : %10u  %lf%%\n", slt_c, (double)slt_c/instr_c*100);
  fprintf(fp, "and         : %10u  %lf%%\n", and_c, (double)and_c/instr_c*100);
  fprintf(fp, "or          : %10u  %lf%%\n", or_c, (double)or_c/instr_c*100);
  fprintf(fp, "xor         : %10u  %lf%%\n", xor_c, (double)xor_c/instr_c*100); 
  fprintf(fp, "sll         : %10u  %lf%%\n", sll_c, (double)sll_c/instr_c*100); 
  fprintf(fp, "srl         : %10u  %lf%%\n", srl_c, (double)srl_c/instr_c*100);
  fprintf(fp, "sllv        : %10u  %lf%%\n", sllv_c, (double)sllv_c/instr_c*100);
  fprintf(fp, "addi        : %10u  %lf%%\n", addi_c, (double)addi_c/instr_c*100); 
  fprintf(fp, "addiu       : %10u  %lf%%\n", addiu_c, (double)addiu_c/instr_c*100); 
  fprintf(fp, "j           : %10u  %lf%%\n", j_c, (double)j_c/instr_c*100);  
  fprintf(fp, "jr          : %10u  %lf%%\n", jr_c, (double)jr_c/instr_c*100); 
  fprintf(fp, "jal         : %10u  %lf%%\n", jal_c, (double)jal_c/instr_c*100); 
  fprintf(fp, "jalr        : %10u  %lf%%\n", jalr_c, (double)jalr_c/instr_c*100);
  fprintf(fp, "beq         : %10u  %lf%%\n", beq_c, (double)beq_c/instr_c*100); 
  fprintf(fp, "bne         : %10u  %lf%%\n", bne_c, (double)bne_c/instr_c*100); 
  fprintf(fp, "blez        : %10u  %lf%%\n", blez_c, (double)blez_c/instr_c*100); 
  fprintf(fp, "bgez        : %10u  %lf%%\n", bgez_c, (double)bgez_c/instr_c*100); 
  fprintf(fp, "bgtz        : %10u  %lf%%\n", bgtz_c, (double)bgtz_c/instr_c*100); 
  fprintf(fp, "bltz        : %10u  %lf%%\n", bltz_c, (double)bltz_c/instr_c*100);
  fprintf(fp, "lui         : %10u  %lf%%\n", lui_c, (double)lui_c/instr_c*100);
  fprintf(fp, "ori         : %10u  %lf%%\n", ori_c, (double)ori_c/instr_c*100);
  fprintf(fp, "sw          : %10u  %lf%%\n", sw_c, (double)sw_c/instr_c*100);
  fprintf(fp, "lw          : %10u  %lf%%\n", lw_c, (double)lw_c/instr_c*100);
  fprintf(fp, "add_s       : %10u  %lf%%\n", add_s_c, (double)add_s_c/instr_c*100);
  fprintf(fp, "sub_s       : %10u  %lf%%\n", sub_s_c, (double)sub_s_c/instr_c*100);
  fprintf(fp, "mul_s       : %10u  %lf%%\n", mul_s_c, (double)mul_s_c/instr_c*100);
  fprintf(fp, "inv_s       : %10u  %lf%%\n", inv_s_c, (double)inv_s_c/instr_c*100);
  fprintf(fp, "sqrt_s      : %10u  %lf%%\n", sqrt_s_c, (double)sqrt_s_c/instr_c*100);
  fprintf(fp, "mov_s       : %10u  %lf%%\n", mov_s_c, (double)mov_s_c/instr_c*100);
  fprintf(fp, "neg_s       : %10u  %lf%%\n", neg_s_c, (double)neg_s_c/instr_c*100);
  fprintf(fp, "c_eq_s      : %10u  %lf%%\n", c_eq_s_c, (double)c_eq_s_c/instr_c*100);
  fprintf(fp, "c_olt_s     : %10u  %lf%%\n", c_olt_s_c, (double)c_olt_s_c/instr_c*100);
  fprintf(fp, "c_ole_s     : %10u  %lf%%\n", c_ole_s_c, (double)c_ole_s_c/instr_c*100);
  fprintf(fp, "bc1t        : %10u  %lf%%\n", bc1t_c, (double)bc1t_c/instr_c*100);
  fprintf(fp, "bc1f        : %10u  %lf%%\n", bc1f_c, (double)bc1f_c/instr_c*100);
  fprintf(fp, "swc1        : %10u  %lf%%\n", swc1_c, (double)swc1_c/instr_c*100);
  fprintf(fp, "lwc1        : %10u  %lf%%\n", lwc1_c, (double)lwc1_c/instr_c*100);
  fprintf(fp, "mfc1        : %10u  %lf%%\n", mfc1_c, (double)mfc1_c/instr_c*100);
  fprintf(fp, "mtc1        : %10u  %lf%%\n", mtc1_c, (double)mtc1_c/instr_c*100);
  fprintf(fp, "cvt.s.w     : %10u  %lf%%\n", cvt_s_w_c, (double)cvt_s_w_c/instr_c*100);
  fprintf(fp, "trunc.w.s   : %10u  %lf%%\n", trunc_w_s_c, (double)trunc_w_s_c/instr_c*100);
  fprintf(fp, "syscall     : %10u  %lf%%\n", syscall_c, (double)syscall_c/instr_c*100);
    
  for(i = 0; i < 32; i++)
    fprintf(stderr, "r%-2d  %8d  0x%08x\n", i, reg[i].i, reg[i].ui);
 
  for(i = 0; i < 32; i++)
    fprintf(stderr, "f%-2d  %8f  0x%08x\n", i, freg[i].f, freg[i].ui);

}


void getoption(int argc, char *argv[])
{
  int i;
  
  while((i = getopt(argc, argv, "hspvb:i:o:")) != -1) {
    switch(i) {
    case 'h':
      fprintf(stderr, "options\n-h: help\n-s: step exec\n-p: print execut instructions\n-b n: breakpoint n\n");
      exit(0);
    case 's':
      stepflag = 1;
      break;
    case 'p':
      printflag = 1;
      break;
    case 'v':
      instrprint = 1;
      break;
    case 'b':
      breakflag = 1;
      breakpoint = atoi(optarg);
      break;
    case 'i':
      fpin = fopen(optarg, "r");
      fprintf(stderr, "%s\n", optarg);
      break;
    case 'o':
      fpout = fopen(optarg, "w");
      fprintf(stderr, "%s\n", optarg);
      break;
    case ':':
      exit(0);
    case '?':
      exit(0);
    }
  }
  
  return;
}
