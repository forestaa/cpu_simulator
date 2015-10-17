#ifndef __SIM_H__
#define __SIM_H__

extern int32_t reg[32], memory[1048576];

void add(int32_t *, int32_t *, int32_t *);
void addi(int32_t *, int32_t *, int16_t);
void addiu(int32_t *, int32_t *, int16_t);
void sub(int32_t *, int32_t *, int32_t *);
void slt(int32_t *, int32_t *, int32_t *);
void and(int32_t *, int32_t *, int32_t *);
void or(int32_t *, int32_t *, int32_t *);
void ori(int32_t *, int32_t *, uint16_t);
int32_t jalr(int32_t *, int32_t *, int32_t *);
int32_t blez(int32_t *, int16_t);
void lui(int32_t *, int16_t);
void li(int32_t *, int32_t);
void move(int32_t *, int32_t *);
void sw(int32_t *, int16_t, int32_t *);
void lw(int32_t *, int16_t, int32_t *);

#endif
