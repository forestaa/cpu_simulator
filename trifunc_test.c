#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include "def.h"
#include "main.h"

void exec_debug(uint32_t);
static inline void read_data(void *ptr, size_t size, size_t nmemb, FILE *fp)
{
  if(fread(ptr, size, nmemb, fp) == 0) {
    perror("cannot read\n");
    exit(1);
  }

  return;
}

int main(int argc, char *argv[])
{
  FILE *fp;
  int i, n, pc_init;
  uint32_t pm[50000];
  float x = 0.0;

  fpin = stdin;
  fpout = stdout;

  for(i = 0; i < 32; i++) {
    reg[i].i = 0;
    freg[i].i = 0;
  }

  reg[29].i = 1048575;
  reg[30].i = 65536;
  
  for(i = 0; i < 1048576; i++)
    memory[i].i = 0;

  if((fp = fopen(argv[argc-1],"r")) == NULL) {
    perror("open error");
    return 0;
  }

  i = reg[30].i;
  read_data(&memory[i],4,1,fp);
  while(memory[i].ui != 0x7000003f) {
    reg[30].i++;
    i = reg[30].i;
    read_data(&memory[i],4,1,fp);
  }
  i = reg[30].i;
  memory[i].ui = 0;

  read_data(&pc,4,1,fp);
  read_data(pm,4,50000,fp);
  fclose(fp);

  getoption(argc, argv); 
  
  for(i = 0; i < 50000; i++) {
    if(pm[i] == 0xffffffff) {
      reg[31].i = i;
      break;
    } else {
      if(instrprint == 1)
	fprintf(stderr, "%08x\n",pm[i]);
    }
  }

  pc_init = pc;
  while(x < 2*M_PI) {
    freg[12].f = x;

    while(pc < 50000) {
      if(pm[pc] == 0xffffffff)
	break;
      else
	exec_debug(pm[pc]);
   
    }
    fprintf(fpout, "%f %f\n", x, freg[0].f);
    x += 0.01;
    pc = pc_init;
    for(n = 0; n < 32; n++)
      freg[n].i = 0;
  }

  fprintf(stderr, "complete instructions\n");
  print_status();

  return 0;
}
