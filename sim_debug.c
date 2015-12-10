#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
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
  int i;
  uint32_t pm[50000];
  struct timeval tv0,tv1;
  double time;

  fpin = stdin;
  fpout = stdout;

  for(i = 0; i < 32; i++) {
    reg[i].i = 0;
    freg[i].i = 0;
  }

  reg[29].i = 1048575;
  reg[30].i = 0;
  
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
	fprintf(stderr, "[%d]: %08x\n", i, pm[i]);
    }
  }

  gettimeofday(&tv0, NULL);

  while(pc < 50000) {
    if(pm[pc] == 0xffffffff)
      break;
    else 
      exec_debug(pm[pc]);
  }

  gettimeofday(&tv1, NULL);
  time = (double)(tv1.tv_sec - tv0.tv_sec + (tv1.tv_usec - tv0.tv_usec)*0.001*0.001);
  fprintf(stderr, "complete instructions\n");
  
  print_status();
  
  fclose(fpin);
  fclose(fpout);

  fprintf(stderr, "time = %lf\n", time);
  return 0;
}
