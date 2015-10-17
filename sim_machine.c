#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "sim.h"

int32_t reg[32] = {0}, memory[1048576] = {0};
uint32_t pm[1000];

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  int32_t pc, *rs, *rt, *rd, *base, opcode;
  int16_t i16, offset;
  uint16_t ui16;

  if((fp = fopen(argv[1],"r")) == NULL) {
    perror("open error");
    exit(1);
  }

  fread(pm,4,1000,fp);
  fclose(fp);
  
  for(i = 0; i < 11; i++) {
    if(pm[i] == 0)
      break;
    else {
      pm[i] = (pm[i] >> 24) | ((pm[i] >> 8) & 0x0000ff00) | ((pm[i] << 8) & 0x00ff0000) | (pm[i] << 24);
      printf("%08x\n",pm[i]);
    }
  }
 
  pc = 0;
  while(1) {
    opcode = pm[pc] & 0xfc000000;
    if(pm[pc] == 0) {
      printf("complete instructions\n");
      break;
    } else if(opcode == 0x00000000) {
      opcode = pm[pc] & 0x0000003f;
      if(opcode == 0x00000020) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	add(rd,rs,rt);
	printf("add   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000022) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	sub(rd,rs,rt);
	printf("sub   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x0000002a) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	slt(rd,rs,rt);
	printf("slt   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000024) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	and(rd,rs,rt);
	printf("and   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000025) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rt = reg + ((pm[pc] >> 16) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	or(rd,rs,rt);
	printf("or    r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
	pc++;
      } else if(opcode == 0x00000009) {
	rs = reg + ((pm[pc] >> 21) & 0x0000001f);
	rd = reg + ((pm[pc] >> 11) & 0x0000001f);
	printf("jalr  r%-2ld r%-2ld\n", rd-reg, rs-reg);
	pc = jalr(rd,rs,&pc);
      } else {
	printf("this instruction is not defined : 0x%x\n", pm[pc]);
	pc++;
      }
    } else if(opcode == 0x20000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      addi(rs,rt,i16);
      printf("addi  r%-2ld r%-2ld %d\n", rs-reg, rt-reg, i16);
      pc++;
    } else if(opcode == 0x24000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      addiu(rs,rt,i16);
      printf("addiu r%-2ld r%-2ld %d\n", rs-reg, rt-reg, i16);
      pc++;
    } else if(opcode == 0x18000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f); 
      offset = pm[pc];
      pc += blez(rs,offset);
      printf("blez  r%-2ld %d\n", rs-reg, offset);
    } else if(opcode == 0x3c000000) {
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      i16 = pm[pc];
      lui(rt,i16);
      printf("lui   r%-2ld %d\n", rt-reg, i16);
      pc++;
    } else if(opcode == 0x34000000) {
      rs = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      ui16 = pm[pc];
      ori(rt,rs,ui16);
      printf("ori   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, ui16);
      pc++;
    } else if(opcode == 0x8c000000) {
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      lw(rt,offset,base);
      printf("lw    r%-2ld %d(r%-2ld)\n", rt-reg, offset, base-reg);
      pc++;
    } else if(opcode == 0xac000000) {
      base = reg + ((pm[pc] >> 21) & 0x0000001f);
      rt = reg + ((pm[pc] >> 16) & 0x0000001f);
      offset = pm[pc];
      sw(rt,offset,base);
      printf("sw    r%-2ld %d(r%-2ld)\n", rt-reg, offset, base-reg);
      pc++;
    } else {
      printf("this instruction is not defined : 0x%x\n", pm[pc]);
      pc++;
    }
  }

  for(i = 0; i < 32; i++)
    printf("r%-2d  %d\n", i, *(reg+i));
 
  return 0;
}
