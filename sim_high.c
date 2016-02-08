#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <signal.h>
#include <sys/time.h>
#include "def.h"
#include "main.h"
#include "table.h"
#include "exec.h"

void gnuplot(FILE *);
int main(int argc, char *argv[])
{
  FILE *fp, *gp;
  int i;
  Program pm[50000];
  struct timeval tv0,tv1;
  double time;
  struct sigaction sigact = {.sa_handler = signalcatch, .sa_flags = 0};

  sigemptyset(&sigact.sa_mask);
  sigaction(SIGINT, &sigact, NULL);
  //  sigaction(SIGSEGV, &sigact, NULL);

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

  getoption(argc, argv);

  load(fp, pm);

  fclose(fp);

  gettimeofday(&tv0, NULL);
  
  while(exec(pm[pc]) == 0 && sigint == 0);

  gettimeofday(&tv1, NULL);
  time = (double)(tv1.tv_sec - tv0.tv_sec + (tv1.tv_usec - tv0.tv_usec)*0.001*0.001);

  if(sigint == 1) {
    fprintf(stderr, "sigint caught\npc = %d\n", pc);
    for(i = -4; i < 5; i++)
      print_instr(pm[pc+i], pc+i);
  } else if(sigsegv == 1) {
    fprintf(stderr, "sigsegv caught\npc = %d\n", pc);
    for(i = -4; i < 5; i++)
      print_instr(pm[pc+i], pc+i);
  } else
    fprintf(stderr, "complete instructions\n");
  
  print_status(); 
  
  fprintf(stderr, "time = %lf\nips = %f million instructions / sec\n", time, instructions/time/1000000);
 
  if(inflag == 1)
    fclose(fpin);
  if(outflag == 1)
    fclose(fpout);

  //  gp = popen("gnuplot", "w");
  //  gnuplot(gp);
  //  pclose(gp);

  return 0;
}

void gnuplot(FILE *p)
{
  int i;

  fprintf(p, "set style fill solid border lc rgb 'black'\n");
  fprintf(p, "set xtics font \"Arial, 8\"\n");
  fprintf(p, "set xtics rotate by 270 ('%s' %d", inum2instr[0], 0);
  for(i = 1; i < 44; i++)
    fprintf(p, ", '%s' %d", inum2instr[i], i);
  fprintf(p, ")\n");
  fprintf(p, "set terminal png size 800, 480\n");
  fprintf(p, "set output 'statics.png'\n");
  fprintf(p, "unset key\n");
  fprintf(p, "plot '-' with boxes\n");
  for(i = 0; i < 44; i++)
    fprintf(p, "%d\n", icount[i]);
  fprintf(p, "e\n");
  fprintf(p, "exit\n");
}
