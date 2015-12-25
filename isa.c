#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "def.h"

static inline void receive_data(void *ptr, size_t size, size_t nmemb, FILE *stream)
{
  if(fread(ptr, size, nmemb, stream) == 0)
    perror("receive error\n");
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
}

void sub(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i - reg[rt].i;
}

void slt(int rd, int rs, int rt)
{
  if(reg[rs].i < reg[rt].i)
    reg[rd].i = 1;
  else
    reg[rd].i = 0;
}

void and(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i & reg[rt].i;
}

void or(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i | reg[rt].i;
}

void xor(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i ^ reg[rt].i;
}

void sll(int rd, int rt, uint16_t sa)
{
  reg[rd].i = reg[rt].i << sa;
}

void sllv(int rd, int rt, int rs)
{
  reg[rd].i = reg[rt].i << reg[rs].i;
}

void srl(int rd, int rt, uint16_t sa)
{
  reg[rd].ui = reg[rt].ui >> sa;
}

void addi(int rt, int rs, int16_t i)
{
  reg[rt].i = reg[rs].i + i;
}

void addiu(int rt, int rs, int16_t i)
{
  reg[rt].i = reg[rs].i + i;
}

void j(int32_t instr_index)
{
  pc = instr_index;
}

void jr(int rs)
{
  pc = reg[rs].i;
}

void jal(int32_t instr_index)
{
  reg[31].i = pc + 1; 

  pc = instr_index;
}

void jalr(int rd, int rs)
{
  reg[rd].i = pc + 1;

  pc = reg[rs].i;
}

void beq(int rs, int rt, int16_t offset)
{
  if(reg[rs].i == reg[rt].i)
    pc += offset;
  else
    pc++;
}

void bne(int rs, int rt, int16_t offset)
{
  if(reg[rs].i != reg[rt].i)
    pc += offset;
  else
    pc++;
}

void blez(int rs, int16_t offset)
{
  if(reg[rs].i <= 0)
    pc += offset;
  else
    pc++;
}

void bgez(int rs, int16_t offset)
{
  if(reg[rs].i >= 0)
    pc += offset;
  else
    pc++;
}

void bgtz(int rs, int16_t offset)
{
  if(reg[rs].i > 0)
    pc += offset;
  else
    pc++;
}

void bltz(int rs, int16_t offset)
{
  if(reg[rs].i < 0)
    pc += offset;
  else
    pc++;
}

void lui(int rt, int16_t i)
{
  int32_t j = i;

  reg[rt].i = j << 16;
}

void ori(int rt, int rs, uint16_t ui)
{
  uint32_t i = ui;

  reg[rt].i = reg[rs].i | i;
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
}

//uint32_t fadd(uint32_t, uint32_t);
void add_s(int fd, int fs, int ft)
{
  //freg[fd].ui = fadd(freg[fs].ui, freg[ft].ui);
  freg[fd].f = freg[fs].f + freg[ft].f;
}

void sub_s(int fd, int fs, int ft)
{
  freg[fd].f = freg[fs].f - freg[ft].f;
}

//uint32_t fmul(uint32_t, uint32_t);
void mul_s(int fd, int fs, int ft)
{
  //freg[fd].ui = fmul(freg[fs].ui, freg[ft].ui);
  freg[fd].f = freg[fs].f * freg[ft].f;
}

uint32_t finv(uint32_t);
void inv_s(int fd, int fs)
{
  //freg[fd].f = 1 / freg[fs].f;
  freg[fd].ui = finv(freg[fs].ui);
}

uint32_t fsqrt(uint32_t);
void sqrt_s(int fd, int fs)
{
  //freg[fd].f = sqrt(freg[fs].f);
  freg[fd].ui = fsqrt(freg[fs].ui);
}

void mov_s(int fd, int fs)
{
  freg[fd].f = freg[fs].f;
}

//uint32_t fneg(uint32_t);
void neg_s(int fd, int fs)
{
  //freg[fd].ui = fneg(freg[fs].ui);
  freg[fd].f = -freg[fs].f;
}

void c_eq_s(int fs, int ft)
{
  if(freg[fs].f == freg[ft].f)
    cc = 1;
  else
    cc = 0;
}

void c_olt_s(int fs, int ft)
{
  if(freg[fs].f < freg[ft].f)
    cc = 1;
  else
    cc = 0;
}

void c_ole_s(int fs, int ft)
{
  if(freg[fs].f <= freg[ft].f)
    cc = 1;
  else
    cc = 0;
}

void bc1t(int16_t offset)
{
  if(cc == 1)
    pc += offset;
  else
    pc++;
}

void bc1f(int16_t offset)
{
  if(cc == 0)
    pc += offset;
  else
    pc++;
}

void swc1(int ft, int16_t offset, int base)
{
  int i = reg[base].i + offset;

  memory[i].f = freg[ft].f;
}

void lwc1(int ft, int16_t offset, int base)
{
  int i = reg[base].i + offset;

  freg[ft].f = memory[i].f;
}

void mfc1(int rt, int fs)
{
  reg[rt].i = freg[fs].i;
}

void mtc1(int rt, int fs)
{
  freg[fs].f = reg[rt].f;
}

uint32_t itof(uint32_t);
void cvt_s_w(int fd, int fs)
{
  //freg[fd].f = freg[fs].i;
  freg[fd].ui = itof(freg[fs].ui);
}

uint32_t ftoi(uint32_t);
void trunc_w_s(int fd, int fs)
{
  //freg[fd].i = freg[fs].f;
  freg[fd].ui = ftoi(freg[fs].ui);
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
}
