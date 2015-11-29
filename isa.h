#ifndef __ISA_H__
#define __ISA_H__

void add(int, int, int);
void addi(int, int, int16_t);
void addiu(int, int, int16_t);
void sub(int, int, int);
void slt(int, int, int);
void and(int, int, int);
void or(int, int, int);
void ori(int, int, uint16_t);
void xor(int, int, int);
void sll(int, int, uint16_t);
void sllv(int, int, int);
void srl(int, int, uint16_t);
void j(int32_t);
void jr(int);
void jal(int32_t);
void jalr(int, int);
void beq(int, int, int16_t);
void bne(int, int, int16_t);
void blez(int, int16_t);
void bgez(int, int16_t);
void bltz(int, int16_t);
void bgtz(int, int16_t);
void lui(int, int16_t);
void sw(int, int16_t, int);
void lw(int, int16_t, int);

void add_s(int, int, int);
void sub_s(int, int, int);
void mul_s(int, int, int);
void inv_s(int, int);
void sqrt_s(int, int);
void mov_s(int, int);
void neg_s(int, int);
void c_eq_s(int, int);
void c_olt_s(int, int);
void c_ole_s(int, int);
void bc1t(int16_t);
void bc1f(int16_t);
void swc1(int, int16_t, int);
void lwc1(int, int16_t, int);
void mfc1(int, int);
void mtc1(int, int);
void cvt_s_w(int, int);
void trunc_w_s(int, int);

void syscall();

#endif
