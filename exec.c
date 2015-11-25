#include <stdio.h>
#include <stdint.h>
#include "def.h"
#include "func.h"

void print_instr(const char *, ...);
void exec(uint32_t instr)
{
  int rs, rt, rd, base, fs, ft, fd;
  int32_t instr_index;
  int16_t i16, offset;
  uint16_t ui16, sa;
  uint32_t opcode;

  opcode = instr & 0xfc000000;
  if(opcode == 0x00000000) {
    opcode = instr & 0x0000003f;
    if(opcode == 0x00000020) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(printflag == 1)
	print_instr("add", rd, rs, rt);
      add(rd,rs,rt);
      pc++;
      add_c++;
    } else if(opcode == 0x00000022) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(printflag == 1)
	print_instr("sub", rd, rs, rt);
      sub(rd,rs,rt);
      pc++;
      sub_c++;
    } else if(opcode == 0x0000002a) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      slt(rd,rs,rt);
      if(printflag == 1)
	print_instr("slt", rd, rs, rt);
      pc++;
      slt_c++;
    } else if(opcode == 0x00000024) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(printflag == 1)
	print_instr("and", rd, rs, rt);
      and(rd,rs,rt);
      pc++;
      and_c++;
    } else if(opcode == 0x00000025) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      or(rd,rs,rt);
      if(printflag == 1)
	print_instr("or", rd, rs, rt);
      pc++;
      or_c++;
    } else if(opcode == 0x00000026) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(printflag == 1)
	print_instr("xor", rd, rs, rt);
      xor(rd,rs,rt);
      pc++;
      xor_c++;
    } else if(opcode == 0x00000008) {
      rs = (instr >> 21) & 0x0000001f;
      if(printflag == 1)
	print_instr("jr", rs);
      jr(rs);
      jr_c++;
    } else if(opcode == 0x00000009) {
      rs = (instr >> 21) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(printflag == 1)
	print_instr("jalr", rd, rs);
      jalr(rd,rs);
      jalr_c++;
    } else if(opcode == 0x00000000) {
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      sa = (instr >> 6) & 0x0000001f;
      if(printflag == 1)
	print_instr("sll", rd, rt, sa);
      sll(rd,rt,sa);
      pc++;
      sll_c++;
    } else if(opcode == 0x00000002) {
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      sa = (instr >> 6) & 0x0000001f;
      srl(rd,rt,sa);
      if(printflag == 1)
	print_instr("srl", rd, rt, sa);
      pc++;
      srl_c++;
    } else if(opcode == 0x00000004) {
      rs = (instr >> 21) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      rd = (instr >> 11) & 0x0000001f;
      if(printflag == 1)
	print_instr("sllv", rd, rt, rs);
      sllv(rd,rt,rs);
      pc++;
      sllv_c++;
    } else if(opcode == 0x0000000c) {
      syscall();
      if(printflag == 1)
	print_instr("syscall");
      pc++;
      syscall_c++;
    } else {
      fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
      pc++;
    }
  } else if(opcode == 0x20000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    i16 = instr;
    if(printflag == 1)
      print_instr("addi", rt, rs, i16);
    addi(rt,rs,i16);
    pc++;
    addi_c++;
  } else if(opcode == 0x24000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    i16 = instr;
    addiu(rt,rs,i16);
    if(printflag == 1)
      print_instr("addiu", rt, rs, i16);
    pc++;
    addiu_c++;
  } else if(opcode == 0x08000000) {
    if((instr & 0x02000000) == 0x02000000)
      instr_index = instr | 0xfc000000;
    else
      instr_index = instr & 0x03ffffff;
    if(printflag == 1)
      print_instr("j", instr_index);
    j(instr_index);
    j_c++;
  } else if(opcode == 0x0c000000) {
    if((instr & 0x02000000) == 0x02000000)
      instr_index = instr | 0xfc000000;
    else
      instr_index = instr & 0x03ffffff;
    if(printflag == 1)
      print_instr("jal", instr_index);
    jal(instr_index);
    jal_c++;
  } else if(opcode == 0x10000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    if(printflag == 1)
      print_instr("beq", rs, rt, offset);
    beq(rs,rt,offset);
    beq_c++;
  } else if(opcode == 0x14000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    if(printflag == 1)
      print_instr("bne", rs, rt, offset);
    bne(rs,rt,offset);
    bne_c++;
  } else if(opcode == 0x18000000) {
    rs = (instr >> 21) & 0x0000001f; 
    offset = instr;
    if(printflag == 1)
      print_instr("blez", rs, offset);
    blez(rs,offset);
    blez_c++;
  } else if(opcode == 0x04000000) {
    rs = (instr >> 21) & 0x0000001f; 
    offset = instr;
    if((instr & 0x000f0000) == 0x00010000) {
      if(printflag == 1)
	print_instr("bgez", rs, offset);
      bgez(rs,offset);
      bgez_c++;
    } else if((instr & 0x000f0000) == 0x00000000) {
      if(printflag == 1)
	print_instr("bltz", rs, offset);
      bltz(rs,offset);
      bltz_c++;
    } else {
      fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
      pc++;
    }
  } else if(opcode == 0x1c000000) {
    rs = (instr >> 21) & 0x0000001f; 
    offset = instr;
    if(printflag == 1)
      print_instr("bgtz", rs, offset);
    bgtz(rs,offset);
    bgtz_c++;
  } else if(opcode == 0x3c000000) {
    rt = (instr >> 16) & 0x0000001f;
    i16 = instr;
    if(printflag == 1)
      print_instr("lui", rt, i16);
    lui(rt,i16);
    pc++;
    lui_c++;
  } else if(opcode == 0x34000000) {
    rs = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    ui16 = instr;
    if(printflag == 1)
      print_instr("ori", rt, rs, ui16);
    ori(rt,rs,ui16);
    pc++;
    ori_c++;
  } else if(opcode == 0x8c000000) {
    base = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    if(printflag == 1)
      print_instr("lw", rt, offset, base);
    lw(rt,offset,base);
    pc++;
    lw_c++;
  } else if(opcode == 0xac000000) {
    base = (instr >> 21) & 0x0000001f;
    rt = (instr >> 16) & 0x0000001f;
    offset = instr;
    if(printflag == 1)
      print_instr("sw", rt, offset, base);
    sw(rt,offset,base);
    pc++;
    sw_c++;
  } else if(opcode == 0x44000000) {
    opcode = instr & 0x03e00000;
    if(opcode == 0x01000000) {
      offset = instr;
      if((instr & 0x00010000) == 0x00010000) {
	if(printflag == 1)
	  print_instr("bc1t", offset);
	bc1t(offset);
	bc1t_c++;
      } else {
	if(printflag == 1)
	  print_instr("bc1f", offset);
	bc1f(offset);
	bc1f_c++;
      }
    } else if(opcode == 0x00000000) {
      fs = (instr >> 11) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      if(printflag == 1)
	print_instr("mfc1", rt, fs);
      mfc1(rt, fs);
      pc++;
      mfc1_c++;
    } else if(opcode == 0x00800000) {
      fs = (instr >> 11) & 0x0000001f;
      rt = (instr >> 16) & 0x0000001f;
      if(printflag == 1)
	print_instr("mtc1", rt, fs);
      mtc1(rt, fs);
      pc++;
      mtc1_c++;
    } else { 
      opcode = instr & 0x0000003f;
      if(opcode == 0x00000000) {
	ft = (instr >> 16) & 0x0000001f;
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("add.s", fd, fs, ft);
	add_s(fd,fs,ft);
	pc++;
	add_s_c++;
      } else if(opcode == 0x00000001) {
	ft = (instr >> 16) & 0x0000001f;
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("sub.s", fd, fs, ft);
	sub_s(fd,fs,ft);
	pc++;
	sub_s_c++;
      } else if(opcode == 0x00000002) {
	ft = (instr >> 16) & 0x0000001f;
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("mul.s", fd, fs, ft);
	mul_s(fd,fs,ft);
	pc++;
	mul_s_c++;
      } else if(opcode == 0x00000003) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("inv.s", fd, fs);
	inv_s(fd,fs);
	pc++;
	inv_s_c++;
      } else if(opcode == 0x00000004) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("sqrt.s", fd, fs);
	sqrt_s(fd,fs);
	pc++;
	sqrt_s_c++;
      } else if(opcode == 0x00000006) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("mov.s", fd, fs);
	mov_s(fd,fs);
	pc++;
	mov_s_c++;
      } else if(opcode == 0x00000007) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("neg.s", fd, fs);
	neg_s(fd,fs);
	pc++;
	neg_s_c++;
      } else if(opcode == 0x0000000d) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("trunc.w.s", fd, fs);
	trunc_w_s(fd, fs);
	pc++;
	trunc_w_s_c++;
      } else if(opcode == 0x00000020) {
	fs = (instr >> 11) & 0x0000001f;
	fd = (instr >> 6) & 0x0000001f;
	if(printflag == 1)
	  print_instr("cvt.s.w", fd, fs);
	cvt_s_w(fd, fs);
	pc++;
	cvt_s_w_c++;
      } else if(opcode == 0x00000032) {
	fs = (instr >> 11) & 0x0000001f;
	ft = (instr >> 16) & 0x0000001f;
	if(printflag == 1)
	  print_instr("c.eq.s", fs, ft);
	c_eq_s(fs, ft);
	pc++;
	c_eq_s_c++;
      } else if(opcode == 0x00000034) {
	fs = (instr >> 11) & 0x0000001f;
	ft = (instr >> 16) & 0x0000001f;
	if(printflag == 1)
	  print_instr("c.olt.s", fs, ft);
	c_olt_s(fs, ft);
	pc++;
	c_olt_s_c++;
      } else if(opcode == 0x0000036) {
	fs = (instr >> 11) & 0x0000001f;
	ft = (instr >> 16) & 0x0000001f;
	if(printflag == 1)
	  print_instr("c.ole.s", fs, ft);
	c_ole_s(fs, ft);
	pc++;
	c_ole_s_c++;
      } else {
	fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
	pc++;
      }
    }   
  } else if(opcode == 0xe4000000) {
    ft = (instr >> 16) & 0x0000001f;
    base = (instr >> 21) & 0x0000001f;
    offset = instr;
    if(printflag == 1)
      print_instr("swc1", ft, offset, base);
    swc1(ft, offset, base);
    pc++;
    swc1_c++;
  } else if(opcode == 0xc4000000) {
    ft = (instr >> 16) & 0x0000001f;
    base = (instr >> 21) & 0x0000001f;
    offset = instr;
    if(printflag == 1)
      print_instr("lwc1", ft, offset, base);
    lwc1(ft, offset, base);
    pc++;
    lwc1_c++;
  } else {
    fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", pc, instr);
    pc++;
  }

   return;
}
