#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "def.h"

static inline void receive_data(void *ptr, size_t size, size_t nmemb, FILE *stream)
{
  if(fread(ptr, size, nmemb, stream) == 0)
    perror("receive error\n");

  return;
}

/*
static inline void receive_data(FILE *stream, const char *format, void *ptr)
{
  if(fscanf(stream, format, ptr) == 0) {
    perror("receive error\n");
  }

  return;
}
*/
void add(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i + reg[rt].i;
  
  return;
}

void sub(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i - reg[rt].i;

  return;
}

void slt(int rd, int rs, int rt)
{
  if(reg[rs].i < reg[rt].i)
    reg[rd].i = 1;
  else
    reg[rd].i = 0;

  return;
}

void and(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i & reg[rt].i;

  return;
}

void or(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i | reg[rt].i;

  return;
}

void xor(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i ^ reg[rt].i;

  return;
}

void sll(int rd, int rt, uint16_t sa)
{
  reg[rd].i = reg[rt].i << sa;

  return;
}

void sllv(int rd, int rt, int rs)
{
  reg[rd].i = reg[rt].i << reg[rs].i;

  return;
}

void srl(int rd, int rt, uint16_t sa)
{
  reg[rd].ui = reg[rt].ui >> sa;

  return;
}

void addi(int rt, int rs, int16_t i)
{
  reg[rt].i = reg[rs].i + i;

  return;
}

void addiu(int rt, int rs, int16_t i)
{
  reg[rt].i = reg[rs].i + i;

  return;
}

void j(int32_t instr_index)
{
  pc = instr_index;

  return;
}

void jr(int rs)
{
  pc = reg[rs].i;
  
  return;
}

void jal(int32_t instr_index)
{
  reg[31].i = pc + 1; 

  pc = instr_index;
  
  return;
}

void jalr(int rd, int rs)
{
  reg[rd].i = pc + 1;

  pc = reg[rs].i;
  return;
}

void beq(int rs, int rt, int16_t offset)
{
  if(reg[rs].i == reg[rt].i)
    pc += offset;
  else
    pc++;

  return;
}

void bne(int rs, int rt, int16_t offset)
{
  if(reg[rs].i != reg[rt].i)
    pc += offset;
  else
    pc++;

  return;
}

void blez(int rs, int16_t offset)
{
  if(reg[rs].i <= 0)
    pc += offset;
  else
    pc++;

  return;
}

void bgez(int rs, int16_t offset)
{
  if(reg[rs].i >= 0)
    pc += offset;
  else
    pc++;

  return;
}

void bgtz(int rs, int16_t offset)
{
  if(reg[rs].i > 0)
    pc += offset;
  else
    pc++;

  return;
}

void bltz(int rs, int16_t offset)
{
  if(reg[rs].i < 0)
    pc += offset;
  else
    pc++;

  return;
}

void lui(int rt, int16_t i)
{
  int32_t j = i;

  reg[rt].i = j << 16;

  return;
}

void ori(int rt, int rs, uint16_t ui)
{
  uint32_t i = ui;

  reg[rt].i = reg[rs].i | i;

  return;
}

void sw(int rt, int16_t offset, int base)
{
  int i = reg[base].i + offset;

  memory[i].i = reg[rt].i;

  return;
} 

void lw(int rt, int16_t offset, int base)
{
  int i = reg[base].i + offset;

  reg[rt].i = memory[i].i;

  return;
}

uint32_t fadd(uint32_t, uint32_t);
void add_s(int fd, int fs, int ft)
{
  freg[fd].ui = fadd(freg[fs].ui, freg[ft].ui);
  //freg[fd].f = freg[fs].f + freg[ft].f;

  return;
}

void sub_s(int fd, int fs, int ft)
{
  freg[fd].f = freg[fs].f - freg[ft].f;

  return;
}

uint32_t fmul(uint32_t, uint32_t);
void mul_s(int fd, int fs, int ft)
{
  freg[fd].ui = fmul(freg[fs].ui, freg[ft].ui);
  //freg[fd].f = freg[fs].f * freg[ft].f;

  return;
}

void inv_s(int fd, int fs)
{
  freg[fd].f = 1 / freg[fs].f;

  return;
}

void sqrt_s(int fd, int fs)
{
  freg[fd].f = sqrt(freg[fs].f);

  return;
}

void mov_s(int fd, int fs)
{
  freg[fd].f = freg[fs].f;

  return;
}

uint32_t fneg(uint32_t);
void neg_s(int fd, int fs)
{
  freg[fd].ui = fneg(freg[fs].ui);
  //freg[fd].f = -freg[fs].f;

  return;
}
void c_eq_s(int fs, int ft)
{
  if(freg[fs].f == freg[ft].f)
    cc = 1;
  else
    cc = 0;
  
  return;
}

void c_olt_s(int fs, int ft)
{
  if(freg[fs].f < freg[ft].f)
    cc = 1;
  else
    cc = 0;
 
  return;
}

void c_ole_s(int fs, int ft)
{
  if(freg[fs].f <= freg[ft].f)
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

void bc1f(int16_t offset)
{
  if(cc == 0)
    pc += offset;
  else
    pc++;

  return;
}

void swc1(int ft, int16_t offset, int base)
{
  int i = reg[base].i + offset;

  memory[i].f = freg[ft].f;

  return;
}

void lwc1(int ft, int16_t offset, int base)
{
  int i = reg[base].i + offset;

  freg[ft].f = memory[i].f;

  return;
}

void mfc1(int rd, int fs)
{
  reg[rd].i = freg[fs].i;

  return;
}

void mtc1(int rt, int fs)
{
  freg[fs].f = reg[rt].f;

  return;
}

void cvt_s_w(int fd, int fs)
{
  freg[fd].f = freg[fs].i;

  return;
}

void trunc_w_s(int fd, int fs)
{
  freg[fd].i = freg[fs].f;

  return;
}

void syscall()
{
  if(reg[2].i == 1)
    fprintf(fpout, "%d", reg[4].i);
  else if(reg[2].i == 2)
    fprintf(fpout, "%f", freg[12].f);
  else if(reg[2].i == 5)
    receive_data(&reg[2], 4, 1, fpin);
    //receive_data(stdin, "%d", &reg[2].i);
  else if(reg[2].i == 6)
    receive_data(&freg[0], 4, 1, fpin);
    //receive_data(stdin, "%f", &freg[0].f);
  else if(reg[2].i == 11)
    fprintf(fpout, "%c", reg[4].c);
  else if(reg[2].i == 12)
    receive_data(&reg[2], 1, 1, fpin);
    //receive_data(stdin, "%c", &reg[2]);
  else if(reg[2].i == -1)
    freg[0].f = sin(freg[12].f);
  else if(reg[2].i == -2)
    freg[0].f = cos(freg[12].f);
  else if(reg[2].i == -3)
    freg[0].f = atan(freg[12].f);
  else
    fprintf(stderr, "this syscall is not defined, r2 = %08x\n", reg[2].ui);

  return;
}
