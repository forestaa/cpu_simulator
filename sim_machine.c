#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "sim.h"

int32_t pc = 0, cc = 0, reg[32] = {0}, memory[1048576] = {0};
float freg[32] = {0};

int main(int argc, char *argv[])
{
  FILE *fp;
  int i, file = 1, breakflag = 0, breakpoint = 0;
  uint32_t pm[50000];
  int32_t *rs, *rt, *rd, *base, opcode, instr_index;
  float *fs, *ft, *fd;
  int16_t i16, offset;
  uint16_t ui16, sa;
  char cmd[20], *p;

  if(argc == 2) {
    if(strcmp(argv[1], "-h") == 0) {
      fprintf(stderr, "options\n-h: help\n-s: step exec\n-b n: breakpoint n\n");
      return  0;
    }
  } else if(argc == 3) {
    if(strcmp(argv[1], "-s") == 0) {
      breakflag = 1;
      file = 2;
    } else if(strcmp(argv[1], "-h") == 0) {
      fprintf(stderr, "options\n-h: help\n-s: step exec\n-b n: n is set as breakpoint\n");
      return  0;
    } else {
      fprintf(stderr, "usage: ./sim_machine (option) sourcefile\n");
      return 0;
    }
  } else if(argc == 4) {
    if(strcmp(argv[1], "-b") == 0) {
      breakflag = 1;
      breakpoint = atoi(argv[2]);
      file = 3;
    } else {
      fprintf(stderr, "usage: ./sim_machine (option) sourcefile\n");
      return 0;
    }
  } else {
    fprintf(stderr, "usage: ./sim_machine (option) sourcefile\n");
    return 0;
  }

  if((fp = fopen(argv[file],"r")) == NULL) {
    perror("open error");
    return 0;
  }

  fread(pm,4,50000,fp);
  fclose(fp);
  
  for(i = 0; i < 50000; i++) {
    if(pm[i] == 0xffffffff) {
      reg[31] = i;
      break;
    } else {
      fprintf(stderr, "%08x\n",pm[i]);
    }
  }

  pc = 34;
  while(pc < 50000) {
    while(breakflag == 1 && pc == breakpoint) {
      fprintf(stderr, "this is breakpoint\n");
      fgets(cmd, 20, stdin);
      p = strchr(cmd, '\n');
      *p = '\0';
      if(strcmp(cmd, "step") == 0 || strcmp(cmd, "\0") == 0)
	breakpoint++;
      else if(strstr(cmd, "print") != NULL) {
	p = strchr(cmd, ' ');
	if((p = strchr(p, 'r')) != NULL) {
	  p++;
	  i = atoi(p);
	  if(i < 32)
	    fprintf(stderr, "r%-2d = %d\n", i, reg[i]);
	  else
	    fprintf(stderr, "this register does not exist : r%d\n", i);
	} else if((p = strstr(p, "memory")) != NULL) {
	    p = strchr(cmd, ']');
	    *p = '\0';
	    p = strchr(cmd, '[');
	    p++;
	    i = atoi(p);
	    if(i < 1048576)
	      fprintf(stderr, "memory[%d] = %d\n", i, memory[i]);
	    else
	      fprintf(stderr, "memory does not have that size\n");
	} 
      } else if(strstr(cmd, "break") != NULL) {
	  p = strchr(cmd, ' ');
	  p++;
	  breakpoint = atoi(p);
      } else if(strcmp(cmd, "run") == 0)
	breakflag = 0;
      else
	fprintf(stderr, "usage\nstep: one instruction execute\nprint rn: print r[n]\nprint memory[n]: print memory[n]\nbreak n: n is set as breakpoint\nrun: run until quit\n");
    }

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
	//fprintf(stderr, "add   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000022) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sub(rd,rs,rt);
	//fprintf(stderr, "sub   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x0000002a) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	slt(rd,rs,rt);
	//fprintf(stderr, "slt   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000024) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	and(rd,rs,rt);
	//fprintf(stderr, "and   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000025) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	or(rd,rs,rt);
	//fprintf(stderr, "or    r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000026) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	xor(rd,rs,rt);
	//fprintf(stderr, "xor   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000008) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	//fprintf(stderr, "jr    r%-2ld\n", rs-reg);
	if(breakflag == 1 && pc == breakpoint - 1) {
	  pc = jr(rs);
	  breakpoint = pc;
	} else
	  pc = jr(rs);
      } else if(opcode == 0x00000009) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	//fprintf(stderr, "jalr  r%-2ld r%-2ld\n", rd-reg, rs-reg);
	if(breakflag == 1 && pc == breakpoint - 1) {
	  pc = jalr(rd,rs);
	  breakpoint = pc;
	} else
	  pc = jalr(rd,rs);
      } else if(opcode == 0x00000000) {
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sa = (pm[pc] >> 6) & 0x0000001f;
	sll(rd,rt,sa);
	//fprintf(stderr, "sll   r%-2ld r%-2ld %d\n", rd-reg, rt-reg, sa);
	pc++;
      } else if(opcode == 0x00000002) {
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sa = (pm[pc] >> 6) & 0x0000001f;
	srl(rd,rt,sa);
	//fprintf(stderr, "srl   r%-2ld r%-2ld %d\n", rd-reg, rt-reg, sa);
	pc++;
      } else if(opcode == 0x0000000c) {
	syscall();
	//fprintf(stderr, "syscall $v0 = %d\n", reg[2]);
	pc++;
      } else {
	//fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
	pc++;
      }
    } else if(opcode == 0x20000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      addi(rt,rs,i16);
      //fprintf(stderr, "addi  r%-2ld r%-2ld %d\n", rt-reg, rs-reg, i16);
      pc++;
    } else if(opcode == 0x24000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      addiu(rt,rs,i16);
      //fprintf(stderr, "addiu r%-2ld r%-2ld %d\n", rs-reg, rt-reg, i16);
      pc++;
    } else if(opcode == 0x0c000000) {
      if((pm[pc] & 0x02000000) == 0x02000000)
	instr_index = pm[pc] | 0xfc000000;
      else
	instr_index = pm[pc] & 0x03ffffff;
      //fprintf(stderr, "jal   %08x\n", instr_index);
      pc += jal(instr_index);
    } else if(opcode == 0x10000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      pc += beq(rs,rt,offset);
      //fprintf(stderr, "beq   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, offset);
    } else if(opcode == 0x14000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      pc += bne(rs,rt,offset);
      //fprintf(stderr, "bne   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, offset);
    } else if(opcode == 0x18000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      pc += blez(rs,offset);
      //fprintf(stderr, "blez  r%-2ld %d\n", rs-reg, offset);
    } else if(opcode == 0x04000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      if((pm[pc] & 0x000f0000) == 0x00010000) {
	pc += bgez(rs,offset);
	//fprintf(stderr, "bgez  r%-2ld %d\n", rs-reg, offset);
      } else if((pm[pc] & 0x000f0000) == 0x00000000) {
	pc += bltz(rs,offset);
	//fprintf(stderr, "bltz  r%-2ld %d\n", rs-reg, offset);
      } else {
	//fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
	pc++;
      }
    } else if(opcode == 0x1c000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      pc += bgtz(rs,offset);
      //fprintf(stderr, "bgtz  r%-2ld %d\n", rs-reg, offset);
    } else if(opcode == 0x3c000000) {
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      lui(rt,i16);
      //fprintf(stderr, "lui   r%-2ld %d\n", rt-reg, i16);
      pc++;
    } else if(opcode == 0x34000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      ui16 = pm[pc];
      ori(rt,rs,ui16);
      //fprintf(stderr, "ori   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, ui16);
      pc++;
    } else if(opcode == 0x8c000000) {
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      lw(rt,offset,base);
      //fprintf(stderr, "lw    r%-2ld %d(r%ld)\n", rt-reg, offset, base-reg);
      pc++;
    } else if(opcode == 0xac000000) {
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      sw(rt,offset,base);
      //fprintf(stderr, "sw    r%-2ld %d(r%ld)\n", rt-reg, offset, base-reg);
      pc++;
    } else if(opcode == 0x44000000) {
      opcode = pm[pc] & 0x0000003f;
      if(opcode == 0x00000000) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	add_s(fd,fs,ft);
	//fprintf(stderr, "add.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x00000001) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	sub_s(fd,fs,ft);
	//fprintf(stderr, "sub.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x00000002) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	mul_s(fd,fs,ft);
	//fprintf(stderr, "mul.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x00000003) {
	fs = freg + ((pm[pc] >> 16) & 0x0000001f);
	ft = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	div_s(fd,fs,ft);
	//fprintf(stderr, "div.s   f%-2ld f%-2ld f%-2ld\n", fd-freg, fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x00000006) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	fd = freg + ((pm[pc] >> 6) & 0x0000001f);
	mov_s(fd,fs);
	//fprintf(stderr, "mov.s   f%-2ld f%-2ld\n", fd-freg, fs-freg);
	pc++;
      } else if(opcode == 0x00000002) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_eq_s(fs, ft);
	//fprintf(stderr, "c.eq.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x00000032) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_eq_s(fs, ft);
	//fprintf(stderr, "c.eq.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x00000034) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_olt_s(fs, ft);
	//fprintf(stderr, "c.olt.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
      } else if(opcode == 0x0000036) {
	fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	ft = freg + ((pm[pc] >> 16) & 0x0000001f);
	c_ole_s(fs, ft);
	//fprintf(stderr, "c.ole.s  f%-2ld f%-2ld\n", fs-freg, ft-freg);
	pc++;
      } else {
	opcode = pm[pc] & 0x03e00000;
	if(opcode == 0x01000000) {
	  offset = pm[pc];
	  pc += bc1t(offset);
	  //fprintf(stderr, "bc1t   %d\n", offset);
	} else if(opcode == 0x00000000) {
	  fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	  rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	  mfc1(rt, fs);
	  //fprintf(stderr, "mfc1    r%-2ld f%-2ld\n", rt-reg, fs-freg);
	  pc++;
	} else if(opcode == 0x00800000) {
	  fs = freg + ((pm[pc] >> 11) & 0x0000001f);
	  rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	  mtc1(rt, fs);
	  //fprintf(stderr, "mtc1    r%-2ld f%-2ld\n", rt-reg, fs-freg);
	  pc++;
	} else {
	  //fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
	  pc++;
	}
      }   
    } else if(opcode == 0xe4000000) {
      ft = freg + ((pm[pc] >> 16) & 0x0000001f);
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      offset = pm[pc];
      swc1(ft, offset, base);
      //fprintf(stderr, "swc1    f%-2ld %d(r%-2ld)\n", ft-freg, offset, base-reg);
      pc++;
    } else if(opcode == 0xc4000000) {
      ft = freg + ((pm[pc] >> 16) & 0x0000001f);
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      offset = pm[pc];
      lwc1(ft, offset, base);
      //fprintf(stderr, "lwc1    f%-2ld %d(r%-2ld)\n", ft-freg, offset, base-reg);
      pc++;
    } else {
      //fprintf(stderr, "this instruction is not defined : 0x%08x\n", pm[pc]);
      pc++;
    }
  }
  
  for(i = 0; i < 32; i++)
    fprintf(stderr, "r%-2d  %d\n", i, reg[i]);
 
  for(i = 0; i < 32; i++)
    fprintf(stderr, "f%-2d  %f\n", i, freg[i]);

  return 0;
}
