#include <stdint.h>
#include "sim.h"

int32_t reg[32], memory[1048576];

void add(int32_t *rd, int32_t *rs, int32_t *rt)
{
  *rd = *rs + *rt;
  
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

void ori(int32_t *rt, int32_t *rs, uint16_t ui)
{
  uint32_t i = ui;

  *rt = *rs | i;

  return;
}

int32_t jalr(int32_t *rd, int32_t *rs, int32_t *pc)
{
  *rd = *pc + 1;

  return *rs;
}

int32_t blez(int32_t *rs, int16_t offset)
{
  if(*rs <= 0)
    return offset;
  else
    return 0;
}


void lui(int32_t *rt, int16_t i)
{
  int32_t j = i;

  *rt = j << 16;

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
  memory[*base + offset] = *rt;

  return;
} 

void lw(int32_t *rt, int16_t offset, int32_t *base)
{
  *rt = memory[*base + offset];

  return;
}
