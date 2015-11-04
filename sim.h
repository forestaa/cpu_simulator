#ifndef __SIM_H__
#define __SIM_H__

extern int32_t cc, reg[32], memory[1048576];
extern float freg[32];

void add(int32_t *, int32_t *, int32_t *);
void addi(int32_t *, int32_t *, int16_t);
void addiu(int32_t *, int32_t *, int16_t);
void sub(int32_t *, int32_t *, int32_t *);
void slt(int32_t *, int32_t *, int32_t *);
void and(int32_t *, int32_t *, int32_t *);
void or(int32_t *, int32_t *, int32_t *);
void ori(int32_t *, int32_t *, uint16_t);
void xor(int32_t *, int32_t *, int32_t *);
void sll(int32_t *, int32_t *, uint16_t);
void srl(int32_t *, int32_t *, uint16_t);
int32_t jr(int32_t *);
int32_t jal(int32_t, int32_t);
int32_t jalr(int32_t *, int32_t *, int32_t *);
int32_t beq(int32_t *, int32_t *, int16_t);
int32_t bne(int32_t *, int32_t *, int16_t);
int32_t blez(int32_t *, int16_t);
int32_t bgez(int32_t *, int16_t);
int32_t bltz(int32_t *, int16_t);
int32_t bgtz(int32_t *, int16_t);
void lui(int32_t *, int16_t);
void li(int32_t *, int32_t);
void move(int32_t *, int32_t *);
void sw(int32_t *, int16_t, int32_t *);
void lw(int32_t *, int16_t, int32_t *);

void add_s(float *, float *, float *);
void sub_s(float *, float *, float *);
void mul_s(float *, float *, float *);
void div_s(float *, float *, float *);
void mov_s(float *, float *);
void c_eq_s(float *, float *);
void c_olt_s(float *, float *);
void c_ole_s(float *, float *);
int32_t bc1t(int16_t);
void swc1(float *, int16_t, int32_t *);
void lwc1(float *, int16_t, int32_t *);
void mfc1(int32_t *, float *);
void mtc1(int32_t *, float *);

void syscall();
#endif
