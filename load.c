#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "def.h"

extern void print_instr(Program, int);
extern inline int instr2inum(const char *);
void load(FILE *fp, Program p[])
{
  int i = 0, j = 0, hp;
  uint32_t instr, opcode, tmp[50000];

  if(fread(tmp, 4, 50000, fp) == 0) {
    perror("read error\n");
    exit(1);
  }
  
  hp = reg[30].i;

  while(tmp[i] != 0x7000003f) {
    memory[hp].i = tmp[i];
    hp++;
    i++;
  }
  reg[30].i = hp;
  i++;
  pc = tmp[i];
  i++;

  while((instr = tmp[i]) != 0xffffffff) {
    opcode = instr & 0xfc000000;
    if(opcode == 0x00000000) {
      opcode = instr & 0x0000003f;
      if(opcode == 0x00000020) {
        p[j].inum = instr2inum("add");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x00000022) {
        p[j].inum = instr2inum("sub");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x0000002a) {
        p[j].inum = instr2inum("slt");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x00000024) {
        p[j].inum = instr2inum("and");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x00000025) {
        p[j].inum = instr2inum("or");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x00000026) {
        p[j].inum = instr2inum("xor");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x00000008) {
        p[j].inum = instr2inum("jr");
        p[j].op1 = (instr >> 21) & 0x0000001f;	
      } else if(opcode == 0x00000009) {
        p[j].inum = instr2inum("jalr");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 11) & 0x0000001f;
      } else if(opcode == 0x00000000) {
        p[j].inum = instr2inum("sll");
        p[j].op1 = (instr >> 16) & 0x0000001f;
        p[j].op2 = (instr >> 11) & 0x0000001f;
        p[j].op3 = (instr >> 6) & 0x0000001f;	
      } else if(opcode == 0x00000002) {
        p[j].inum = instr2inum("srl");
        p[j].op1 = (instr >> 16) & 0x0000001f;
        p[j].op2 = (instr >> 11) & 0x0000001f;
        p[j].op3 = (instr >> 6) & 0x0000001f;	
      } else if(opcode == 0x00000004) {
        p[j].inum = instr2inum("sllv");
        p[j].op1 = (instr >> 21) & 0x0000001f;
        p[j].op2 = (instr >> 16) & 0x0000001f;
        p[j].op3 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x0000000c) {
        p[j].inum = instr2inum("syscall");	
      } else {
        fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", j, instr);
      }
    } else if(opcode == 0x20000000) {
      p[j].inum = instr2inum("addi");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;      
    } else if(opcode == 0x24000000) {
      p[j].inum = instr2inum("addiu");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;      
    } else if(opcode == 0x08000000) {
      p[j].inum = instr2inum("j");
      p[j].op1 = instr & 0x03ffffff;      
    } else if(opcode == 0x0c000000) {
      p[j].inum = instr2inum("jal");
      p[j].op1 = instr & 0x03ffffff;      
    } else if(opcode == 0x10000000) {
      p[j].inum = instr2inum("beq");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;      
    } else if(opcode == 0x14000000) {
      p[j].inum = instr2inum("bne");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;      
    } else if(opcode == 0x18000000) {
      p[j].inum = instr2inum("blez");
      p[j].op1 = (instr >> 21) & 0x0000001f; 
      p[j].op2 = (int16_t)instr;      
    } else if(opcode == 0x04000000) {
      p[j].inum = ((instr & 0x000f0000) == 0x00010000) ? instr2inum("bgez") : instr2inum("bltz");
      p[j].op1 = (instr >> 21) & 0x0000001f; 
      p[j].op2 = (int16_t)instr;      
    } else if(opcode == 0x1c000000) {
      p[j].inum = instr2inum("bgtz");
      p[j].op1 = (instr >> 21) & 0x0000001f; 
      p[j].op2 = (int16_t)instr;      
    } else if(opcode == 0x3c000000) {
      p[j].inum = instr2inum("lui");
      p[j].op1 = (instr >> 16) & 0x0000001f;
      p[j].op2 = (int16_t)instr;      
    } else if(opcode == 0x34000000) {
      p[j].inum = instr2inum("ori");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (uint16_t)instr;      
    } else if(opcode == 0x8c000000) {
      p[j].inum = instr2inum("lw");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;
    } else if(opcode == 0xac000000) {
      p[j].inum = instr2inum("sw");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;
    } else if(opcode == 0x44000000) {
      opcode = instr & 0x03e00000;
      if(opcode == 0x01000000) {
        p[j].inum = ((instr & 0x00010000) == 0x00010000) ? instr2inum("bc1t") : instr2inum("bc1f");
        p[j].op1 = (int16_t)instr;	
      } else if(opcode == 0x00000000) {
        p[j].inum = instr2inum("mfc1");
        p[j].op1 = (instr >> 16) & 0x0000001f;
        p[j].op2 = (instr >> 11) & 0x0000001f;	
      } else if(opcode == 0x00800000) {
        p[j].inum = instr2inum("mtc1");
        p[j].op1 = (instr >> 16) & 0x0000001f;
        p[j].op2 = (instr >> 11) & 0x0000001f;
      } else { 
        opcode = instr & 0x0000003f;
        if(opcode == 0x00000000) {
          p[j].inum = instr2inum("add.s");
          p[j].op1 = (instr >> 16) & 0x0000001f;
          p[j].op2 = (instr >> 11) & 0x0000001f;
          p[j].op3 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000001) {
          p[j].inum = instr2inum("sub.s");
          p[j].op1 = (instr >> 16) & 0x0000001f;
          p[j].op2 = (instr >> 11) & 0x0000001f;
          p[j].op3 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000002) {
          p[j].inum = instr2inum("mul.s");
          p[j].op1 = (instr >> 16) & 0x0000001f;
          p[j].op2 = (instr >> 11) & 0x0000001f;
          p[j].op3 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000003) {
          p[j].inum = instr2inum("inv.s");
          p[j].op1 = (instr >> 11) & 0x0000001f;
          p[j].op2 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000004) {
          p[j].inum = instr2inum("sqrt.s");
          p[j].op1 = (instr >> 11) & 0x0000001f;
          p[j].op2 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000006) {
          p[j].inum = instr2inum("mov.s");
          p[j].op1 = (instr >> 11) & 0x0000001f;
          p[j].op2 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000007) {
          p[j].inum = instr2inum("neg.s");
          p[j].op1 = (instr >> 11) & 0x0000001f;
          p[j].op2 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x0000000d) {
          p[j].inum = instr2inum("trunc.w.s");
          p[j].op1 = (instr >> 11) & 0x0000001f;
          p[j].op2 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000020) {
          p[j].inum = instr2inum("cvt.s.w");
          p[j].op1 = (instr >> 11) & 0x0000001f;
          p[j].op2 = (instr >> 6) & 0x0000001f;	  
        } else if(opcode == 0x00000032) {
          p[j].inum = instr2inum("c.eq.s");
          p[j].op1 = (instr >> 16) & 0x0000001f;
          p[j].op2 = (instr >> 11) & 0x0000001f;	  
        } else if(opcode == 0x00000034) {
          p[j].inum = instr2inum("c.olt.s");
          p[j].op1 = (instr >> 16) & 0x0000001f;
          p[j].op2 = (instr >> 11) & 0x0000001f;	  
        } else if(opcode == 0x0000036) {
          p[j].inum = instr2inum("c.ole.s");
          p[j].op1 = (instr >> 16) & 0x0000001f;
          p[j].op2 = (instr >> 11) & 0x0000001f;
        } else {
          fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", j, instr);
        }
      }   
    } else if(opcode == 0xe4000000) {
      p[j].inum = instr2inum("swc1");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;      
    } else if(opcode == 0xc4000000) {
      p[j].inum = instr2inum("lwc1");
      p[j].op1 = (instr >> 21) & 0x0000001f;
      p[j].op2 = (instr >> 16) & 0x0000001f;
      p[j].op3 = (int16_t)instr;      
    } else {
      fprintf(stderr, "this instruction is not defined : [%d]:0x%08x\n", j, instr);
    }

    if(instrprint == 1)
      print_instr(p[j], j);

    i++;
    j++;
  }
  p[j].inum = 44;
  
  reg[31].i = j;

}

int instr2inum(const char *instr)
{
  int i = 0;

  while(i < 44) {
    if(strcmp(inum2instr[i], instr) == 0)
      return i;
    i++;
  }

  return 45;
}
