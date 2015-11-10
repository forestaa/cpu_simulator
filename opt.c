#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>

extern int32_t pc, cc, reg[32], memory[1048576];
extern float freg[32];
extern int stepflag, breakflag, breakpoint, printflag;

void getoption(int argc, char *argv[])
{
  int i;
  
  while((i = getopt(argc, argv, "hspb:")) != -1) {
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
    case ':':
      exit(0);
    case '?':
      exit(0);
    }
  }
  
  return;
}
    
void bpoint()
{ 
  char cmd[20], *p;
  int i;
  
  while((stepflag == 1 || breakflag == 1) && pc == breakpoint) {
    fprintf(stderr, "this is breakpoint\n");
    fgets(cmd, 20, stdin);
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
      if(strstr(p, "memory") != NULL) {
	p = strchr(cmd, ']');
	*p = '\0';
	p = strchr(cmd, '[');
	p++;
	i = atoi(p);
	if(i < 1048576)
	  fprintf(stderr, "memory[%d] = %d\n", i, memory[i]);
	else
	  fprintf(stderr, "memory does not have that size\n");
      } else if(strstr(p, "pc") != NULL) {
	fprintf(stderr, "pc = %d\n", pc);
      } else if(strchr(p, 'r') != NULL) {
	p = strchr(p, 'r');
	p++;
	i = atoi(p);
	if(i < 32)
	  fprintf(stderr, "r%-2d = %d\n", i, reg[i]);
	else
	  fprintf(stderr, "this register does not exist : r%d\n", i);
      } else if(strchr(p, 'f') != NULL) {
	p = strchr(p, 'f');
	p++;
	i = atoi(p);
	if(i < 32)
	  fprintf(stderr, "f%-2d = %f\n", i, freg[i]);
	else
	  fprintf(stderr, "this register does not exist : f%d\n", i);
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
