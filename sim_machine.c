#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "sim.h"

int instr_c = 0, add_c = 0, sub_c = 0, slt_c = 0, and_c = 0, or_c = 0, xor_c = 0, sll_c = 0, srl_c = 0;
int addi_c = 0, addiu_c = 0, jr_c = 0, j_c = 0, jal_c = 0, jalr_c = 0, beq_c = 0, bne_c = 0, blez_c = 0, bgez_c = 0, bgtz_c = 0, bltz_c = 0;
int lui_c = 0, ori_c = 0, li_c = 0, move_c = 0, sw_c = 0, lw_c = 0, add_s_c = 0, sub_s_c = 0, mul_s_c = 0, div_s_c = 0, mov_s_c = 0;
int c_eq_s_c = 0, c_olt_s_c = 0, c_ole_s_c = 0, bc1t_c = 0, swc1_c = 0, lwc1_c = 0, mfc1_c = 0, mtc1_c = 0, syscall_c = 0;
int breakflag = 0, breakpoint, printflag = 0;
int32_t pc = 0, cc = 0, reg[32] = {0}, memory[1048576] = {0};
float freg[32] = {0};

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  uint32_t pm[50000];
  int32_t *rs, *rt, *rd, *base, opcode, instr_index;
  float *fs, *ft, *fd;
  int16_t i16, offset;
  uint16_t ui16, sa;

  if((fp = fopen(argv[argc-1],"r")) == NULL) {
    perror("open error");
    return 0;
  }

  fread(&pc,4,1,fp);
  fread(pm,4,50000,fp);
  fclose(fp);

  getoption(argc, argv); 
  
  for(i = 0; i < 50000; i++) {
    if(pm[i] == 0xffffffff) {
      reg[31] = i;
      break;
    } else {
      fprintf(stderr, "%08x\n",pm[i]);
    }
  }

  while(pc < 50000) {
    bpoint();

    opcode = pm[pc] & 0xfc000000;
    if(pm[pc] == 0xffffffff) {
      fprintf(stderr, "complete instructions\n");
      break;
    } else if(opcode == 0x00000000) {
      opcode = pm[pc] & 0x0000003f;
      if(opcode == 0x00000020) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	add(rd,rs,rt);
	if(printflag == 1)
	  fprintf(stderr, "add   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
	add_c++;
      } else if(opcode == 0x00000022) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sub(rd,rs,rt);
	if(printflag == 1)
	  fprintf(stderr, "sub   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
	sub_c++;
      } else if(opcode == 0x0000002a) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	slt(rd,rs,rt);
	if(printflag == 1)
	  fprintf(stderr, "slt   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
	slt_c++;
      } else if(opcode == 0x00000024) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	and(rd,rs,rt);
	if(printflag == 1)
	  fprintf(stderr, "and   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
	and_c++;
      } else if(opcode == 0x00000025) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	or(rd,rs,rt);
	if(printflag == 1)
	  fprintf(stderr, "or    r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
	or_c++;
      } else if(opcode == 0x00000026) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	xor(rd,rs,rt);
	if(printflag == 1)
	  fprintf(stderr, "xor   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
	xor_c++;
      } else if(opcode == 0x00000008) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	if(printflag == 1)
	  fprintf(stderr, "jr    r%-2ld\n", rs-reg);
	if(breakflag == 1 && pc == breakpoint - 1) {
	  pc = jr(rs);
	  breakpoint = pc;
	} else
	  pc = jr(rs);
	jr_c++;
      } else if(opcode == 0x00000009) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	if(printflag == 1)
	  fprintf(stderr, "jalr  r%-2ld r%-2ld\n", rd-reg, rs-reg);
	if(breakflag == 1 && pc == breakpoint - 1) {
	  pc = jalr(rd,rs);
	  breakpoint = pc;
	} else
	  pc = jalr(rd,rs);
	jalr_c++;
      } else if(opcode == 0x00000000) {
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sa = (pm[pc] >> 6) & 0x0000001f;
	sll(rd,rt,sa);
	if(printflag == 1)
	  fprintf(stderr, "sll   r%-2ld r%-2ld %d\n", rd-reg, rt-reg, sa);
	pc++;
	sll_c++;
      } else if(opcode == 0x00000002) {
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sa = (pm[pc] >> 6) & 0x0000001f;
	srl(rd,rt,sa);
	if(printflag == 1)
	  fprintf(stderr, "srl   r%-2ld r%-2ld %d\n", rd-reg, rt-reg, sa);
	pc++;
	srl_c++;
      } else if(opcode == 0x0000000c) {
	syscall();
	if(printflag == 1)
	  fprintf(stderr, "syscall $v0 = %d\n", reg[2]);
	pc++;
	syscall_c++;
      } else {
	fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
	pc++;
      }
    } else if(opcode == 0x20000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      addi(rt,rs,i16);
      if(printflag == 1)
	fprintf(stderr, "addi  r%-2ld r%-2ld %d\n", rt-reg, rs-reg, i16);
      pc++;
      addi_c++;
    } else if(opcode == 0x24000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      addiu(rt,rs,i16);
      if(printflag == 1)
	fprintf(stderr, "addiu r%-2ld r%-2ld %d\n", rs-reg, rt-reg, i16);
      pc++;
      addiu_c++;
    } else if(opcode == 0x08000000) {
      if((pm[pc] & 0x02000000) == 0x02000000)
	instr_index = pm[pc] | 0xfc000000;
      else
	instr_index = pm[pc] & 0x03ffffff;
      if(printflag == 1)
	fprintf(stderr, "j     %08x\n", instr_index);
      pc += j(instr_index);
      j_c++;
    } else if(opcode == 0x0c000000) {
      if((pm[pc] & 0x02000000) == 0x02000000)
	instr_index = pm[pc] | 0xfc000000;
      else
	instr_index = pm[pc] & 0x03ffffff;
      if(printflag == 1)
	fprintf(stderr, "jal   %08x\n", instr_index);
      pc += jal(instr_index);
      jal_c++;
    } else if(opcode == 0x10000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      pc += beq(rs,rt,offset);
      if(printflag == 1)
	fprintf(stderr, "beq   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, offset);
      beq_c++;
    } else if(opcode == 0x14000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      pc += bne(rs,rt,offset);
      if(printflag == 1)
	fprintf(stderr, "bne   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, offset);
      bne_c++;
    } else if(opcode == 0x18000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      pc += blez(rs,offset);
      if(printflag == 1)
	fprintf(stderr, "blez  r%-2ld %d\n", rs-reg, offset);
      blez_c++;
    } else if(opcode == 0x04000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      if((pm[pc] & 0x000f0000) == 0x00010000) {
	pc += bgez(rs,offset);
	if(printflag == 1)
	  fprintf(stderr, "bgez  r%-2ld %d\n", rs-reg, offset);
	bgez_c++;
      } else if((pm[pc] & 0x000f0000) == 0x00000000) {
	pc += bltz(rs,offset);
	if(printflag == 1)
	  fprintf(stderr, "bltz  r%-2ld %d\n", rs-reg, offset);
	bltz_c++;
      } else {
	fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
	pc++;
      }
    } else if(opcode == 0x1c000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      pc += bgtz(rs,offset);
      if(printflag == 1)
	fprintf(stderr, "bgtz  r%-2ld %d\n", rs-reg, offset);
      bgtz_c++;
    } else if(opcode == 0x3c000000) {
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      lui(rt,i16);
      if(printflag == 1)
	fprintf(stderr, "lui   r%-2ld %d\n", rt-reg, i16);
      pc++;
      lui_c++;
    } else if(opcode == 0x34000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      ui16 = pm[pc];
      ori(rt,rs,ui16);
      if(printflag == 1)
	fprintf(stderr, "ori   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, ui16);
      pc++;
      ori_c++;
    } else if(opcode == 0x8c000000) {
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      lw(rt,offset,base);
      if(printflag == 1)
	fprintf(stderr, "lw    r%-2ld %d(r%ld)\n", rt-reg, offset, base-reg);
      pc++;
      lw_c++;
    } else if(opcode == 0xac000000) {
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      sw(rt,offset,base);
      if(printflag == 1)
	fprintf(stderr, "sw    r%-2ld %d(r%ld)\n", rt-reg, offset, base-reg);
      pc++;
      sw_c++;
    } else if(opcode == 0x44000000) {
      opcode = pm[pc] & 0x0000003f;
      if(opcode == 0x00000000) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	add_s(fd,fs,ft);
	if(printflag == 1)
	  fprintf(stderr, "add.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
	add_s_c++;
      } else if(opcode == 0x00000001) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	sub_s(fd,fs,ft);
	if(printflag == 1)
	  fprintf(stderr, "sub.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
	sub_s_c++;
      } else if(opcode == 0x00000002) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	mul_s(fd,fs,ft);
	if(printflag == 1)
	  fprintf(stderr, "mul.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
	mul_s_c++;
      } else if(opcode == 0x00000003) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	div_s(fd,fs,ft);
	if(printflag == 1)
	  fprintf(stderr, "div.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
	div_s_c++;
      } else if(opcode == 0x00000006) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	mov_s(fd,fs);
	if(printflag == 1)
	  fprintf(stderr, "mov.s   f%-2ld f%-2ld\n", fd-freg, fs-freg);
	pc++;
	mov_s_c++;
      } else if(opcode == 0x00000032) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_eq_s(fs, ft);
	if(printflag == 1)
	  fprintf(stderr, "c.eq.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
	c_eq_s_c++;
      } else if(opcode == 0x00000034) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_olt_s(fs, ft);
	if(printflag == 1)
	  fprintf(stderr, "c.olt.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
	c_olt_s_c++;
      } else if(opcode == 0x0000036) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_ole_s(fs, ft);
	if(printflag == 1)
	  fprintf(stderr, "c.ole.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
	c_ole_s_c++;
      } else {
	opcode = pm[pc] & 0x03e00000;
	if(opcode == 0x01000000) {
	  offset = pm[pc];
	  pc += bc1t(offset);
	  if(printflag == 1)
	    fprintf(stderr, "bc1t   %d\n", offset);
	  bc1t_c++;
	} else if(opcode == 0x00000000) {
	  fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	  rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	  mfc1(rt, fs);
	  if(printflag == 1)
	    fprintf(stderr, "mfc1    r%-2ld f%-2ld\n", rt-reg, fs-freg);
	  pc++;
	  mfc1_c++;
	} else if(opcode == 0x00800000) {
	  fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	  rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	  mtc1(rt, fs);
	  if(printflag == 1)
	    fprintf(stderr, "mtc1    r%-2ld f%-2ld\n", rt-reg, fs-freg);
	  pc++;
	  mtc1_c++;
	} else {
	  fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
	  pc++;
	}
      }   
    } else if(opcode == 0xe4000000) {
      ft = freg + ((pm[pc] >> 16) & 0x0000001f);
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      offset = pm[pc];
      swc1(ft, offset, base);
      if(printflag == 1)
	fprintf(stderr, "swc1    f%-2ld %d(r%-2ld)\n", ft-freg, offset, base-reg);
      pc++;
      swc1_c++;
    } else if(opcode == 0xc4000000) {
      ft = freg + ((pm[pc] >> 16) & 0x0000001f);
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      offset = pm[pc];
      lwc1(ft, offset, base);
      if(printflag == 1)
	fprintf(stderr, "lwc1    f%-2ld %d(r%-2ld)\n", ft-freg, offset, base-reg);
      pc++;
      lwc1_c++;
    } else {
      fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
      pc++;
    }
    instr_c++;
  }
  
  print_status();
  return 0;
}
