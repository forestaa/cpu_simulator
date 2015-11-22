#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
#include "def.h"
#include "func.h"

unsigned int instr_c = 0, add_c = 0, sub_c = 0, slt_c = 0, and_c = 0, or_c = 0, xor_c = 0, sll_c = 0, srl_c = 0, sllv_c = 0;
unsigned int addi_c = 0, addiu_c = 0, jr_c = 0, j_c = 0, jal_c = 0, jalr_c = 0, beq_c = 0, bne_c = 0, blez_c = 0, bgez_c = 0, bgtz_c = 0, bltz_c = 0;
unsigned int lui_c = 0, ori_c = 0, sw_c = 0, lw_c = 0, add_s_c = 0, sub_s_c = 0, mul_s_c = 0, div_s_c = 0, sqrt_s_c = 0, mov_s_c = 0, neg_s_c = 0;
unsigned int c_eq_s_c = 0, c_olt_s_c = 0, c_ole_s_c = 0, bc1t_c = 0, bc1f_c = 0, swc1_c = 0, lwc1_c = 0, mfc1_c = 0, mtc1_c = 0, cvt_s_w_c = 0, trunc_w_s_c = 0, syscall_c = 0;
int stepflag = 0, stepcount = 0, breakflag = 0, breakpoint, printflag = 0, instrprint = 0;
int32_t pc = 0, cc = 0;
Value reg[32], freg[32], memory[1048576];
FILE *fpin, *fpout;

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
  int i, rs, rt, rd, base, fs, ft, fd;
  uint32_t pm[50000];
  int32_t  opcode, instr_index;
  int16_t i16, offset;
  uint16_t ui16, sa;
  struct timeval tv0,tv1;
  double time;

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
	fprintf(stderr, "[%d]: %08x\n", i, pm[i]);
    }
  }

  gettimeofday(&tv0, NULL);

  while(pc < 50000) {
    bpoint(pm[pc]);

    opcode = pm[pc] & 0xfc000000;
    if(pm[pc] == 0xffffffff) {
      fprintf(stderr, "complete instructions\n");
      break;
    } else if(opcode == 0x00000000) {
      opcode = pm[pc] & 0x0000003f;
      if(opcode == 0x00000020) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	if(printflag == 1)
	  print_instr("add", rd, rs, rt);
	add(rd,rs,rt);
	pc++;
	add_c++;
      } else if(opcode == 0x00000022) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	if(printflag == 1)
	  print_instr("sub", rd, rs, rt);
	sub(rd,rs,rt);
	pc++;
	sub_c++;
      } else if(opcode == 0x0000002a) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	slt(rd,rs,rt);
	if(printflag == 1)
	  print_instr("slt", rd, rs, rt);
	pc++;
	slt_c++;
      } else if(opcode == 0x00000024) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	if(printflag == 1)
	  print_instr("and", rd, rs, rt);
	and(rd,rs,rt);
	pc++;
	and_c++;
      } else if(opcode == 0x00000025) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	or(rd,rs,rt);
	if(printflag == 1)
	  print_instr("or", rd, rs, rt);
	pc++;
	or_c++;
      } else if(opcode == 0x00000026) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	if(printflag == 1)
	  print_instr("xor", rd, rs, rt);
	xor(rd,rs,rt);
	pc++;
	xor_c++;
      } else if(opcode == 0x00000008) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	if(printflag == 1)
	  print_instr("jr", rs);
	if(stepflag == 1 && pc == breakpoint - 1) {
	  jr(rs);
	  breakpoint = pc;
	} else
	  jr(rs);
	jr_c++;
      } else if(opcode == 0x00000009) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	if(printflag == 1)
	  print_instr("jalr", rd, rs);
	if(stepflag == 1 && pc == breakpoint - 1) {
	  jalr(rd,rs);
	  breakpoint = pc;
	} else
	  jalr(rd,rs);
	jalr_c++;
      } else if(opcode == 0x00000000) {
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	sa = (pm[pc] >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("sll", rd, rt, sa);
	sll(rd,rt,sa);
	pc++;
	sll_c++;
      } else if(opcode == 0x00000002) {
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	sa = (pm[pc] >> 6) & 0x0000001f;
	srl(rd,rt,sa);
	if(printflag == 1)
	  print_instr("srl", rd, rt, sa);
	pc++;
	srl_c++;
      } else if(opcode == 0x00000004) {
	rs = (pm[pc] >> 21) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	rd = (pm[pc] >> 11) & 0x0000001f;
	if(printflag == 1)
	  print_instr("sllv", rd, rt, rs);
	sllv(rd,rt,rs);
	pc++;
	sllv_c++;
      } else if(opcode == 0x0000000c) {
	syscall();
	if(printflag == 1)
	  print_instr("syscall");
	pc++;
	syscall_c++;
      } else {
	fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, pm[pc]);
	pc++;
      }
    } else if(opcode == 0x20000000) {
      rs = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      i16 = pm[pc];
      if(printflag == 1)
	print_instr("addi", rt, rs, i16);
      addi(rt,rs,i16);
      pc++;
      addi_c++;
    } else if(opcode == 0x24000000) {
      rs = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      i16 = pm[pc];
      addiu(rt,rs,i16);
      if(printflag == 1)
	print_instr("addiu", rt, rs, i16);
      pc++;
      addiu_c++;
    } else if(opcode == 0x08000000) {
      if((pm[pc] & 0x02000000) == 0x02000000)
	instr_index = pm[pc] | 0xfc000000;
      else
	instr_index = pm[pc] & 0x03ffffff;
      if(printflag == 1)
	print_instr("j", instr_index);
      if(stepflag == 1 && pc == breakpoint - 1) {
	j(instr_index);
	breakpoint = pc;
      } else
	j(instr_index);
      j_c++;
    } else if(opcode == 0x0c000000) {
      if((pm[pc] & 0x02000000) == 0x02000000)
	instr_index = pm[pc] | 0xfc000000;
      else
	instr_index = pm[pc] & 0x03ffffff;
      if(printflag == 1)
	print_instr("jal", instr_index);
      if(stepflag == 1 && pc == breakpoint - 1) {
	jal(instr_index);
	breakpoint = pc;
      } else
	jal(instr_index);
      jal_c++;
    } else if(opcode == 0x10000000) {
      rs = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      offset = pm[pc];
      if(printflag == 1)
	print_instr("beq", rs, rt, offset);
      if(stepflag == 1 && pc == breakpoint - 1) {
	beq(rs,rt,offset);
	breakpoint = pc;
      } else
	beq(rs,rt,offset);
      beq_c++;
    } else if(opcode == 0x14000000) {
      rs = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      offset = pm[pc];
      if(printflag == 1)
	print_instr("bne", rs, rt, offset);
      if(stepflag == 1 && pc == breakpoint - 1) {
	bne(rs,rt,offset);
	breakpoint = pc;
      } else
	bne(rs,rt,offset);
      bne_c++;
    } else if(opcode == 0x18000000) {
      rs = (pm[pc] >> 21) & 0x0000001f; 
      offset = pm[pc];
      if(printflag == 1)
	print_instr("blez", rs, offset);
      if(stepflag == 1 && pc == breakpoint - 1) {
	blez(rs,offset);
	breakpoint = pc;
      } else
	blez(rs,offset);
      blez_c++;
    } else if(opcode == 0x04000000) {
      rs = (pm[pc] >> 21) & 0x0000001f; 
      offset = pm[pc];
      if((pm[pc] & 0x000f0000) == 0x00010000) {
	if(printflag == 1)
	  print_instr("bgez", rs, offset);
	if(stepflag == 1 && pc == breakpoint - 1) {
	  bgez(rs,offset);
	  breakpoint = pc;
	} else
	  bgez(rs,offset);
	bgez_c++;
      } else if((pm[pc] & 0x000f0000) == 0x00000000) {
	if(printflag == 1)
	  print_instr("bltz", rs, offset);
	if(stepflag == 1 && pc == breakpoint - 1) {
	  bltz(rs,offset);
	  breakpoint = pc;
	} else
	  bltz(rs,offset);
	bltz_c++;
      } else {
	fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, pm[pc]);
	pc++;
      }
    } else if(opcode == 0x1c000000) {
      rs = (pm[pc] >> 21) & 0x0000001f; 
      offset = pm[pc];
      if(printflag == 1)
	print_instr("bgtz", rs, offset);
      if(stepflag == 1 && pc == breakpoint - 1) {
	bgtz(rs,offset);
	breakpoint = pc;
      } else
	bgtz(rs,offset);
      bgtz_c++;
    } else if(opcode == 0x3c000000) {
      rt = (pm[pc] >> 16) & 0x0000001f;
      i16 = pm[pc];
      if(printflag == 1)
	print_instr("lui", rt, i16);
      lui(rt,i16);
      pc++;
      lui_c++;
    } else if(opcode == 0x34000000) {
      rs = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      ui16 = pm[pc];
      if(printflag == 1)
	print_instr("ori", rt, rs, ui16);
      ori(rt,rs,ui16);
      pc++;
      ori_c++;
    } else if(opcode == 0x8c000000) {
      base = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      offset = pm[pc];
      if(printflag == 1)
	print_instr("lw", rt, offset, base);
      lw(rt,offset,base);
      pc++;
      lw_c++;
    } else if(opcode == 0xac000000) {
      base = (pm[pc] >> 21) & 0x0000001f;
      rt = (pm[pc] >> 16) & 0x0000001f;
      offset = pm[pc];
      if(printflag == 1)
	print_instr("sw", rt, offset, base);
      sw(rt,offset,base);
      pc++;
      sw_c++;
    } else if(opcode == 0x44000000) {
      opcode = pm[pc] & 0x03e00000;
      if(opcode == 0x01000000) {
	offset = pm[pc];
	if((pm[pc] & 0x00010000) == 0x00010000) {
	  if(printflag == 1)
	    print_instr("bc1t", offset);
	  bc1t(offset);
	  bc1t_c++;
	} else {
	  if(printflag == 1)
	    print_instr("bc1f", offset);
	  bc1f(offset);
	  bc1f_c++;
	}
	if(stepflag == 1 && pc == breakpoint - 1)
	  breakpoint = pc;
      } else if(opcode == 0x00000000) {
	fs = (pm[pc] >> 11) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	if(printflag == 1)
	  print_instr("mfc1", rt, fs);
	mfc1(rt, fs);
	pc++;
	mfc1_c++;
      } else if(opcode == 0x00800000) {
	fs = (pm[pc] >> 11) & 0x0000001f;
	rt = (pm[pc] >> 16) & 0x0000001f;
	if(printflag == 1)
	  print_instr("mtc1", rt, fs);
	mtc1(rt, fs);
	pc++;
	  mtc1_c++;
      } else { 
	opcode = pm[pc] & 0x0000003f;
	if(opcode == 0x00000000) {
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("add.s", fd, fs, ft);
	  add_s(fd,fs,ft);
	  pc++;
	  add_s_c++;
	} else if(opcode == 0x00000001) {
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("sub.s", fd, fs, ft);
	  sub_s(fd,fs,ft);
	  pc++;
	  sub_s_c++;
	} else if(opcode == 0x00000002) {
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("mul.s", fd, fs, ft);
	  mul_s(fd,fs,ft);
	  pc++;
	  mul_s_c++;
	} else if(opcode == 0x00000003) {
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("div.s", fd, fs, ft);
	  div_s(fd,fs,ft);
	  pc++;
	  div_s_c++;
	} else if(opcode == 0x00000004) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("sqrt.s", fd, fs);
	  sqrt_s(fd,fs);
	  pc++;
	  sqrt_s_c++;
	} else if(opcode == 0x00000006) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("mov.s", fd, fs);
	  mov_s(fd,fs);
	  pc++;
	  mov_s_c++;
	} else if(opcode == 0x00000007) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("neg.s", fd, fs);
	  neg_s(fd,fs);
	  pc++;
	  neg_s_c++;
	} else if(opcode == 0x0000000d) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("trunc.w.s", fd, fs);
	  trunc_w_s(fd, fs);
	  pc++;
	  trunc_w_s_c++;
	} else if(opcode == 0x00000020) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  fd = (pm[pc] >> 6) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("cvt.s.w", fd, fs);
	  cvt_s_w(fd, fs);
	  pc++;
	  cvt_s_w_c++;
	} else if(opcode == 0x00000032) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("c.eq.s", fs, ft);
	  c_eq_s(fs, ft);
	  pc++;
	  c_eq_s_c++;
	} else if(opcode == 0x00000034) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("c.olt.s", fs, ft);
	  c_olt_s(fs, ft);
	  pc++;
	  c_olt_s_c++;
	} else if(opcode == 0x0000036) {
	  fs = (pm[pc] >> 11) & 0x0000001f;
	  ft = (pm[pc] >> 16) & 0x0000001f;
	  if(printflag == 1)
	    print_instr("c.ole.s", fs, ft);
	  c_ole_s(fs, ft);
	  pc++;
	  c_ole_s_c++;
	} else {
	  fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, pm[pc]);
	  pc++;
	}
      }   
    } else if(opcode == 0xe4000000) {
      ft = (pm[pc] >> 16) & 0x0000001f;
      base = (pm[pc] >> 21) & 0x0000001f;
      offset = pm[pc];
      if(printflag == 1)
	print_instr("swc1", ft, offset, base);
      swc1(ft, offset, base);
      pc++;
      swc1_c++;
    } else if(opcode == 0xc4000000) {
      ft = (pm[pc] >> 16) & 0x0000001f;
      base = (pm[pc] >> 21) & 0x0000001f;
      offset = pm[pc];
      if(printflag == 1)
	print_instr("lwc1", ft, offset, base);
      lwc1(ft, offset, base);
      pc++;
      lwc1_c++;
    } else {
      fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, pm[pc]);
      pc++;
    }
    if(stepcount > 0)
      stepcount--;

    instr_c++;
  }

  gettimeofday(&tv1, NULL);
  time = (double)(tv1.tv_sec - tv0.tv_sec + (tv1.tv_usec - tv0.tv_usec)*0.001*0.001);
  
  print_status();
  
  fclose(fpin);
  fclose(fpout);

  fprintf(stderr, "time = %lf\n", time);
  return 0;
}
