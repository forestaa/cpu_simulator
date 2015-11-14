#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "def.h"
#include "func.h"

int32_t pc = 0, cc, reg[32] = {0};
float freg[32] = {0};
Memory memory[1048576] = {0};
int regnum(char *);

void bufclear(char *buf)
{
  int i;
  for(i = 0; i < 40; i++)
    *(buf+i) = '\0';

  return;
}

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  int32_t *rs, *rt, *rd, *base, pc = 0, i32, instr_index;
  int16_t i16, offset;
  uint16_t ui16, sa;
  Assembli program[65535];
  
  if((fp = fopen(argv[1],"r")) == NULL) {
    perror("open error");
    exit(1);
  }

  while(fgets(str, 40, fp) != NULL) {
    if((p = strchr(str, ':')) == NULL) {
      strcpy(programmemory[pc],str);
      bufclear(str);
      pc++;
    } else {
      *p = '\n';
      p++;
      *p = '\0';
      strcpy(label[pc],str);
      bufclear(str);
    }
  }
  strcpy(programmemory[pc],"END\n");

  fclose(fp);

  for(i = 0; i < 100; i++)
    printf("%s", programmemory[i]);

  pc = 0;
  while(strcmp(label[pc], "_min_caml_start\n") != 0)
    pc++;

  while(pc < 1000) {
    if((p = strcasestr(programmemory[pc], "addiu")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	i16 = atoi(p);
	addiu(rs,rt,i16);
	printf("addiu r%-2ld r%-2ld %d\n", rs-reg, rt-reg, i16);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "addi")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	i16 = atoi(p);
	addi(rs,rt,i16);
	printf("addi  r%-2ld r%-2ld %d\n", rs-reg, rt-reg, i16);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "add")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	add(rd,rs,rt);
	printf("add   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "sub")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	sub(rd,rs,rt);
	printf("sub   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "slt")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	slt(rd,rs,rt);
	printf("slt   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "and")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	and(rd,rs,rt);
	printf("and   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "xor")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	xor(rd,rs,rt);
	printf("xor   r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "ori")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rt = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, ' ');
	p++;
	ui16 = atoi(p);
	ori(rt,rs,ui16);
	printf("ori   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, ui16);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "or")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	or(rd,rs,rt);
	printf("or    r%-2ld r%-2ld r%-2ld\n", rd-reg, rs-reg, rt-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "sll")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	sa = atoi(p);
	sll(rd,rt,sa);
	printf("sll   r%-2ld r%-2ld %d\n", rd-reg, rt-reg, sa);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "srl")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	sa = atoi(p);
	srl(rd,rt,sa);
	printf("srl   r%-2ld r%-2ld %d\n", rd-reg, rt-reg, sa);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "jr")) != NULL){
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	pc = jr(rs);
	printf("jr    r%-2ld\n", rs-reg);
      }
    } else if((p = strcasestr(programmemory[pc], "jalr")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	pc = jalr(rd,rs,&pc);
      }
      printf("jalr  r%-2ld r%-2ld\n", rd-reg, rs-reg);
    } else if((p = strcasestr(programmemory[pc] , "jal")) != NULL){
      p = strchr(p, '\t');
      p++;
      for(i = 0; i < 100; i++) {
	if(strcmp(p, label[i]) == 0)
	  break;
      }
      if(i == 100) {
	printf("this label is not found : %s\n", p);
	pc++;
      } else {
	instr_index = i;
	pc = jal(instr_index, pc);
      }
    } else if((p = strcasestr(programmemory[pc], "beq")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	offset = atoi(p);
	pc = beq(rs,rt,offset);
	printf("beq   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, offset);
      }
    } else if((p = strcasestr(programmemory[pc], "bne")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, '$');
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	offset = atoi(p);
	pc = bne(rs,rt,offset);
	printf("bne   r%-2ld r%-2ld %d\n", rs-reg, rt-reg, offset);
      }
    } else if((p = strcasestr(programmemory[pc], "blez")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, ' ');
	p++;
	for(i = 0; i < 100; i++) {
	  if(strcmp(p, label[i]) == 0)
	    break;
	}
	if(i == 100) {
	  printf("this label is not found : %s\n", p);
	  pc++;
	} else {
	  offset = i - pc;
	  pc += blez(rs, offset);
	  printf("blez  r%-2ld %d\n", rs-reg, offset);
	}
      }
    } else if((p = strcasestr(programmemory[pc], "bgez")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, ' ');
	p++;
	for(i = 0; i < 100; i++) {
	  if(strcmp(p, label[i]) == 0)
	    break;
	}
	if(i == 100) {
	  printf("this label is not found : %s\n", p);
	  pc++;
	} else {
	  offset = i - pc;
	  pc += bgez(rs, offset);
	  printf("bgez  r%-2ld %d\n", rs-reg, offset);
	}
      }
    } else if((p = strcasestr(programmemory[pc], "bgtz")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, ' ');
	p++;
	for(i = 0; i < 100; i++) {
	  if(strcmp(p, label[i]) == 0)
	    break;
	}
	if(i == 100) {
	  printf("this label is not found : %s\n", p);
	  pc++;
	} else {
	  offset = i - pc;
	  pc += bgtz(rs, offset);
	  printf("bgtz  r%-2ld %d\n", rs-reg, offset);
	}
      }
    } else if((p = strcasestr(programmemory[pc], "bltz")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rs = regset(p);
	p = strchr(p, ' ');
	p++;
	for(i = 0; i < 100; i++) {
	  if(strcmp(p, label[i]) == 0)
	    break;
	}
	if(i == 1000) {
	  printf("this label is not found : %s\n", p);
	  pc++;
	} else {
	  offset = i - pc;
	  pc += bltz(rs, offset);
	  printf("bltz  r%-2ld %d\n", rs-reg, offset);
	}
      }
    } else if((p = strcasestr(programmemory[pc], "li")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	i32 = atoi(p);
	li(rt,i32);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "lui")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	i16 = atoi(p);
	lui(rt,i16);
	printf("lui   r%-2ld %d\n", rt-reg, i16);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "move")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rd = regset(p);
	p = strchr(p, '$');
	p++;
	rs = regset(p);
	move(rd,rs);
	printf("move  r%-2ld %-2ld\n", rd-reg, rs-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "sw")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	i = 0;
	while(*p != '(') {
	  buf[i] = *p;
	  p++;
	  i++;
	}
	buf[i] = '\0';
	offset = atoi(buf);
	p = strchr(p, '$');
	p++;
	base = regset(p);
	sw(rt,offset,base);
	printf("sw    r%-2ld %d(r%ld)\n", rt-reg, offset, base-reg);
      }
      pc++;
    } else if((p = strcasestr(programmemory[pc], "lw")) != NULL) {
      if((p = strchr(p, '$')) != NULL) {
	p++;
	rt = regset(p);
	p = strchr(p, ' ');
	p++;
	i = 0;
	while(*p != '(') {
	  buf[i] = *p;
	  p++;
	  i++;
	}
	buf[i] = '\0';
	offset = atoi(buf);
	p = strchr(p, '$');
	p++;
	base = regset(p);
	lw(rt,offset,base);
	printf("lw    r%-2ld %d(r%ld)\n", rt-reg, offset, base-reg);
      }
      pc++;
    } else if(strcmp(programmemory[pc], "END\n") == 0) {
      printf("complete instructions\n");
      break;
    } else {
      printf("this instruction is not defined : %s\n", programmemory[pc]);
      pc++;
    }
  }

  for(i = 0; i < 32; i++)
    printf("r%-2d  %d\n", i, *(reg+i));
  return 0;
}
