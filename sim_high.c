#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <signal.h>
#include <sys/time.h>
#include "def.h"
#include "main.h"
#include "table.h"
#include "exec.h"

volatile int sigint = 0, sigsegv = 0;

void signalcatch(int signal)
{
  if(signal == SIGINT)
    sigint = 1;
  else if(signal == SIGSEGV)
    sigsegv = 1;
}

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  Program pm[50000];
  struct timeval tv0,tv1;
  double time;
  struct sigaction sigact = {.sa_handler = signalcatch, .sa_flags = 0};

  sigemptyset(&sigact.sa_mask);
  sigaction(SIGINT, &sigact, NULL);
  sigaction(SIGSEGV, &sigact, NULL);

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

  load(fp, pm);

  fclose(fp);

  getoption(argc, argv);

  gettimeofday(&tv0, NULL);
  
  while(exec(pm[pc]) == 0 && sigint == 0 && sigsegv == 0);

  gettimeofday(&tv1, NULL);
  time = (double)(tv1.tv_sec - tv0.tv_sec + (tv1.tv_usec - tv0.tv_usec)*0.001*0.001);

  if(sigint == 1) {
    fprintf(stderr, "sigint caught\npc = %d\n", pc);
    print_instr(pm[pc]);
  } else if(sigsegv == 1) {
    fprintf(stderr, "sigsegv caught\npc = %d\n", pc);
    print_instr(pm[pc]);
  } else
    fprintf(stderr, "complete instructions\n");
  
  print_status();
  
  fclose(fpin);
  fclose(fpout);

  fprintf(stderr, "time = %lf\nips = %f million instructions / sec\n", time, instructions/time/1000000);

  return 0;
}
