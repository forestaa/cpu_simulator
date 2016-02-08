#ifndef __ISA_H_
#define __ISA_H_

#include <math.h>

static inline void receive_data(void *ptr, size_t size, size_t nmemb, FILE *stream)
{
  if(fread(ptr, size, nmemb, stream) == 0)
    perror("receive error\n");
}

static inline void add(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i + reg[rt].i;

  pc++;
}

static inline void sub(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i - reg[rt].i;

  pc++;
}

static inline void slt(int rd, int rs, int rt)
{
  if(reg[rs].i < reg[rt].i)
    reg[rd].i = 1;
  else
    reg[rd].i = 0;

  pc++;
}

static inline void and(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i & reg[rt].i;

  pc++;
}

static inline void or(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i | reg[rt].i;

  pc++;
}

static inline void xor(int rd, int rs, int rt)
{
  reg[rd].i = reg[rs].i ^ reg[rt].i;

  pc++;
}

static inline void sll(int rd, int rt, int sa)
{
  reg[rd].i = reg[rt].i << sa;

  pc++;
}

static inline void sllv(int rd, int rt, int rs)
{
  reg[rd].i = reg[rt].i << reg[rs].i;

  pc++;
}

static inline void srl(int rd, int rt, int sa)
{
  reg[rd].ui = reg[rt].ui >> sa;

  pc++;
}

static inline void addi(int rt, int rs, int i)
{
  reg[rt].i = reg[rs].i + i;

  pc++;
}

static inline void addiu(int rt, int rs, int i)
{
  reg[rt].i = reg[rs].i + i;

  pc++;
}

static inline void j(int instr_index)
{
  pc = instr_index;
}

static inline void jr(int rs)
{
  pc = reg[rs].i;
}

static inline void jal(int instr_index)
{
  reg[31].i = pc + 1; 

  pc = instr_index;
}

static inline void jalr(int rd, int rs)
{
  reg[rd].i = pc + 1;

  pc = reg[rs].i;
}

static inline void beq(int rs, int rt, int offset)
{
  if(reg[rs].i == reg[rt].i)
    pc += offset;
  else
    pc++;
}

static inline void bne(int rs, int rt, int offset)
{
  if(reg[rs].i != reg[rt].i)
    pc += offset;
  else
    pc++;
}

static inline void blez(int rs, int offset)
{
  if(reg[rs].i <= 0)
    pc += offset;
  else
    pc++;
}

static inline void bgez(int rs, int offset)
{
  if(reg[rs].i >= 0)
    pc += offset;
  else
    pc++;
}

static inline void bgtz(int rs, int offset)
{
  if(reg[rs].i > 0)
    pc += offset;
  else
    pc++;
}

static inline void bltz(int rs, int offset)
{
  if(reg[rs].i < 0)
    pc += offset;
  else
    pc++;
}

static inline void lui(int rt, int i)
{
  reg[rt].i = i << 16;

  pc++;
}

static inline void ori(int rt, int rs, int i)
{
  reg[rt].i = reg[rs].i | i;

  pc++;
}

static inline void sw(int rt, int offset, int base)
{
  int i = reg[base].i + offset;

  memory[i].i = reg[rt].i;

  pc++;
} 

static inline void lw(int rt, int offset, int base)
{
  int i = reg[base].i + offset;

  reg[rt].i = memory[i].i;

  pc++;
}

//uint32_t fadd(uint32_t, uint32_t);
static inline void add_s(int fd, int fs, int ft)
{
  //freg[fd].ui = fadd(freg[fs].ui, freg[ft].ui);
  freg[fd].f = freg[fs].f + freg[ft].f;

  pc++;
}

static inline void sub_s(int fd, int fs, int ft)
{
  freg[fd].f = freg[fs].f - freg[ft].f;
  /*
  Value tmp;
  tmp.f = -freg[ft].f;
  freg[fd].ui = fadd(freg[fs].ui, tmp.ui);
  */
  pc++;
}

//uint32_t fmul(uint32_t, uint32_t);
static inline void mul_s(int fd, int fs, int ft)
{
  //freg[fd].ui = fmul(freg[fs].ui, freg[ft].ui);
  freg[fd].f = freg[fs].f * freg[ft].f;

  pc++;
}

//uint32_t finv(uint32_t);
static inline void inv_s(int fd, int fs)
{
  freg[fd].f = 1 / freg[fs].f;
  //freg[fd].ui = finv(freg[fs].ui);

  pc++;
}

//uint32_t fsqrt(uint32_t);
static inline void sqrt_s(int fd, int fs)
{
  freg[fd].f = sqrt(freg[fs].f);
  //freg[fd].ui = fsqrt(freg[fs].ui);

  pc++;
}

static inline void mov_s(int fd, int fs)
{
  freg[fd].f = freg[fs].f;

  pc++;
}

static inline void neg_s(int fd, int fs)
{
  freg[fd].f = -freg[fs].f;

  pc++;
}

static inline void c_eq_s(int fs, int ft)
{
  if(freg[fs].f == freg[ft].f)
    cc = 1;
  else
    cc = 0;

  pc++;
}

static inline void c_olt_s(int fs, int ft)
{
  if(freg[fs].f < freg[ft].f)
    cc = 1;
  else
    cc = 0;

  pc++;
}

static inline void c_ole_s(int fs, int ft)
{
  if(freg[fs].f <= freg[ft].f)
    cc = 1;
  else
    cc = 0;

  pc++;
}

static inline void bc1t(int offset)
{
  if(cc == 1)
    pc += offset;
  else
    pc++;
}

static inline void bc1f(int offset)
{
  if(cc == 0)
    pc += offset;
  else
    pc++;
}

static inline void swc1(int ft, int offset, int base)
{
  int i = reg[base].i + offset;

  memory[i].f = freg[ft].f;

  pc++;
}

static inline void lwc1(int ft, int offset, int base)
{
  int i = reg[base].i + offset;

  freg[ft].f = memory[i].f;

  pc++;
}

static inline void mfc1(int rt, int fs)
{
  reg[rt].i = freg[fs].i;

  pc++;
}

static inline void mtc1(int rt, int fs)
{
  freg[fs].f = reg[rt].f;

  pc++;
}

//uint32_t itof(uint32_t);
static inline void cvt_s_w(int fd, int fs)
{
  freg[fd].f = freg[fs].i;
  //freg[fd].ui = itof(freg[fs].ui);

  pc++;
}

//uint32_t ftoi(uint32_t);
static inline void trunc_w_s(int fd, int fs)
{
  freg[fd].i = freg[fs].f;
  //freg[fd].ui = ftoi(freg[fs].ui);

  pc++;
}
//int counter = 0;
static inline void syscall()
{
  if(reg[2].i == 1)
    fprintf(fpout, "%d", reg[4].i);
  else if(reg[2].i == 2)
    fprintf(fpout, "%f", freg[12].f);
  else if(reg[2].i == 5)
    receive_data(&reg[2], 4, 1, fpin);
  else if(reg[2].i == 6)
    receive_data(&freg[0], 4, 1, fpin);
  else if(reg[2].i == 11) {
    fprintf(fpout, "%c", reg[4].c);
    //    if(reg[4].c == '\n')
    //      counter++;
    //    if(counter >= 2663)
    //      stepflag = 1;

  } else if(reg[2].i == 12)
    receive_data(&reg[2], 1, 1, fpin);
  else if(reg[2].i == -1)
    freg[0].f = sin(freg[12].f);
  else if(reg[2].i == -2)
    freg[0].f = cos(freg[12].f);
  else if(reg[2].i == -3)
    freg[0].f = atan(freg[12].f);
  else
    fprintf(stderr, "this syscall is not defined, r2 = %08x\n", reg[2].ui);

  pc++;
}

#endif
