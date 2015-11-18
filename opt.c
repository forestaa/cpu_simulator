#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include "def.h"

int regnum(char *);
void getoption(int argc, char *argv[])
{
  int i;
  
  while((i = getopt(argc, argv, "hspb:i:o:")) != -1) {
    switch(i) {
    case 'h':
      fprintf(stderr, "options\n-h: help\n-s: step exec\n-p: print execut instructions\n-b n: breakpoint n\n");
      exit(0);
    case 's':
      stepflag = 1;
      breakpoint = pc;
      break;
    case 'p':
      printflag = 1;
      break;
    case 'b':
      breakflag = 1;
      breakpoint = atoi(optarg);
      break;
    case 'i':
      fpin = fopen(optarg, "r");
      fprintf(stderr, "%s\n", optarg);
      break;
    case 'o':
      fpout = fopen(optarg, "w");
      fprintf(stderr, "%s\n", optarg);
      break;
    case ':':
      exit(0);
    case '?':
      exit(0);
    }
  }
  
  return;
}
    
void bpoint(uint32_t instr)
{ 
  char cmd[30], *p, *q;
  int i, f = 0, c = 0;
  
  while((stepflag == 1 || breakflag == 1) && pc == breakpoint) {
    stepflag = 1;
    fprintf(stderr, ">");
    if(fgets(cmd, 30, stdin) == NULL) {
      perror("no commands");
    }
    p = strchr(cmd, '\n');
    *p = '\0';
    if(strcmp(cmd, "step") == 0 || strcmp(cmd, "\0") == 0)
      breakpoint++;
    else if(strcmp(cmd, "pflagon") == 0)
      printflag = 1;
    else if(strcmp(cmd, "pflagoff") == 0)
      printflag = 0;
    else if(strstr(cmd, "print") != NULL) {
      p = strchr(cmd, ' ');
      if(strstr(p, "all") != NULL) {
	for(i = 0; i < 32; i++)
	  fprintf(stderr, "r%-2d  %8d  0x%08x\n", i, reg[i].i, reg[i].ui);
	for(i = 0; i < 32; i++)
	  fprintf(stderr, "f%-2d  %8f  0x%08x\n", i, freg[i].f, freg[i].ui);
      } else if(strstr(p, "instr") != NULL) {
	fprintf(stderr, "instr = 0x%08x\n", instr);
      } else if(strstr(p, "memory") != NULL) {
	if(strstr(cmd, "-f") != NULL)
	  f = 1;
	p = strchr(cmd, ']');
	*p = '\0';
	p = strchr(cmd, '[');
	p++;
	i = atoi(p);
	if(i < 1048576) {
	  if(f == 1)
	    fprintf(stderr, "memory[%d] = %f  0x%08x\n", i, memory[i].f, memory[i].i);
	  else
	    fprintf(stderr, "memory[%d] = %d  0x%08x\n", i, memory[i].i, memory[i].i);
	} else
	  fprintf(stderr, "memory does not have that size\n");
	f = 0;
      } else if(strstr(p, "pc") != NULL) {
	fprintf(stderr, "pc = %d\n", pc);
      } else if(strchr(p, 'f') != NULL) {
	p = strchr(p, 'f');
	p++;
	i = atoi(p);
	if(i < 32)
	  fprintf(stderr, "f%-2d = %f  0x%08x\n", i, freg[i].f, freg[i].ui);
	else
	  fprintf(stderr, "this register does not exist : f%d\n", i);
      } else {
	p++;
	if((q = strstr(cmd, "-c")) != NULL) {
	  c = 1;
	  q--;
	  *q = '\0';
	}
	i = regnum(p);
	if(i < 32) {
	  if(c == 1)
	    fprintf(stderr, "r%-2d = %c  0x%08x\n", i, reg[i].i, reg[i].ui);
	  else
	    fprintf(stderr, "r%-2d = %d  0x%08x\n", i, reg[i].i, reg[i].ui);
	} else
	  fprintf(stderr, "this register does not exist : r%d\n", i);
	c = 0;
      }
    } else if(strstr(cmd, "break") != NULL) {
      p = strchr(cmd, ' ');
      p++;
      breakpoint = atoi(p);
      breakflag = 1;
    } else if(strcmp(cmd, "run") == 0) {
      stepflag = 0;
      breakflag = 0;
    }
    else
      fprintf(stderr, "usage\nstep: one instruction execute\nprintflag: printflag goes on\nprint rn: print r[n]\nprint memory[n]: print memory[n]\nbreak n: n is set as breakpoint\nrun: run until quit\n");
  }

  return;
}
