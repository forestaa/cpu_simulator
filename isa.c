#include <stdio.h>
#include <stdint.h>
#include "def.h"

void add(int32_t *rd, int32_t *rs, int32_t *rt)
{
  *rd = *rs + *rt;
  
  return;
}

void sub(int32_t *rd, int32_t *rs, int32_t *rt)
{
  *rd = *rs - *rt;

  return;
}

void slt(int32_t *rd, int32_t *rs, int32_t *rt)
{
  if(*rs < *rt)
    *rd = 1;
  else
    *rd = 0;

  return;
}

void and(int32_t *rd, int32_t *rs, int32_t *rt)
  {
  *rd = *rs & *rt;

  return;
}

void or(int32_t *rd, int32_t *rs, int32_t *rt)
{
  *rd = *rs | *rt;

  return;
}

void xor(int32_t *rd, int32_t *rs, int32_t *rt)
{
  *rd = *rs ^ *rt;

  return;
}

void sll(int32_t *rd, int32_t *rt, uint16_t sa)
{
  *rd = *rt << sa;

  return;
}

void srl(int32_t *rd, int32_t *rt, uint16_t sa)
{
  *rd = (uint32_t)*rt >> sa;

  return;
}

void addi(int32_t *rt, int32_t *rs, int16_t i)
{
  *rt = *rs + i;

  return;
}

void addiu(int32_t *rt, int32_t *rs, int16_t i)
{
  *rt = *rs + i;

  return;
}

void j(int32_t instr_index)
{
  pc = instr_index;

  return;
}

void jr(int32_t *rs)
{
  pc = *rs;
  
  return;
}

void jal(int32_t instr_index)
{
  reg[31] = pc + 1; 

  pc = instr_index;
  
  return;
}

void jalr(int32_t *rd, int32_t *rs)
{
  *rd = pc + 1;

  pc = *rs;
  return;
}

void beq(int32_t *rs, int32_t *rt, int16_t offset)
{
  if(*rs == *rt)
    pc += offset;
  else
    pc++;

  return;
}

void bne(int32_t *rs, int32_t *rt, int16_t offset)
{
  if(*rs != *rt)
    pc += offset;
  else
    pc++;

  return;
}

void blez(int32_t *rs, int16_t offset)
{
  if(*rs <= 0)
    pc += offset;
  else
    pc++;

  return;
}

void bgez(int32_t *rs, int16_t offset)
{
  if(*rs >= 0)
    pc += offset;
  else
    pc++;

  return;
}

void bgtz(int32_t *rs, int16_t offset)
{
  if(*rs > 0)
    pc += offset;
  else
    pc++;

  return;
}

void bltz(int32_t *rs, int16_t offset)
{
  if(*rs < 0)
    pc += offset;
  else
    pc++;

  return;
}

void lui(int32_t *rt, int16_t i)
{
  int32_t j = i;

  *rt = j << 16;

  return;
}

void ori(int32_t *rt, int32_t *rs, uint16_t ui)
{
  uint32_t i = ui;

  *rt = *rs | i;

  return;
}

void li(int32_t *rd, int32_t i)
{
  int16_t j = i >> 16;
  uint16_t ui = i;

  lui(rd, j);
  ori(rd, rd, ui);

  return;
}

void move(int32_t *rd, int32_t *rs)
{
  or(rd, rs, reg);

  return;
}

void sw(int32_t *rt, int16_t offset, int32_t *base)
{
  memory[*base + offset].i = *rt;

  return;
} 

void lw(int32_t *rt, int16_t offset, int32_t *base)
{
  *rt = memory[*base + offset].i;

  return;
}

void add_s(float *fd, float *fs, float *ft)
{
  *fd = *fs + *ft;

  return;
}

void sub_s(float *fd, float *fs, float *ft)
{
  *fd = *fs - *ft;

  return;
}

void mul_s(float *fd, float *fs, float *ft)
{
  *fd = *fs * *ft;

  return;
}

void div_s(float *fd, float *fs, float *ft)
{
  *fd = *fs / *ft;

  return;
}

void mov_s(float *fd, float *fs)
{
  *fd = *fs;

  return;
}

void c_eq_s(float *fs, float *ft)
{
  if(*fs == *ft)
    cc = 1;
  else
    cc = 0;
  
  return;
}

void c_olt_s(float *fs, float *ft)
{
  if(*fs < *ft)
    cc = 1;
  else
    cc = 0;

  return;
}

void c_ole_s(float *fs, float *ft)
{
  if(*fs <= *ft)
    cc = 1;
  else
    cc = 0;

  return;
}

void bc1t(int16_t offset)
{
  if(cc == 1)
    pc += offset;
  else
    pc++;

  return;
}

void swc1(float *ft, int16_t offset, int32_t *base)
{
  memory[*base + offset].f = *ft;

  return;
}

void lwc1(float *ft, int16_t offset, int32_t *base)
{
  *ft = memory[*base + offset].f;

  return;
}

void mfc1(int32_t *rd, float *fs)
{
  *rd = *(int32_t *)fs;

  return;
}

void mtc1(int32_t *rt, float *fs)
{
  *fs = *(float *)rt;

  return;
}

void cvt_s_w(float *fd, float *fs)
{
  *fd = *(int32_t *)fs;

  return;
}

void trunc_w_s(float *fd, float *fs)
{
  *fd = (int32_t)*fs;

  return;
}

void syscall()
{
  if(reg[2] == 1)
    fprintf(stdout, "%d", reg[4]);
  else if(reg[2] == 2)
    fprintf(stdout, "%f", freg[12]);
  else if(reg[2] == 5)
    fscanf(stdin, "%d", &reg[2]);
  else if(reg[2] == 6)
    fscanf(stdin, "%f", &freg[0]);
  else if(reg[2] == 11)
    fprintf(stdout, "%c", reg[4]);
  else if(reg[2] == 12)
    fscanf(stdin, "%c", reg[2]);
  else
    fprintf(stderr, "this syscall is not defined, r2 = %08x\n", reg[2]);

  return;
}
