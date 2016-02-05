#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <signal.h>
#include "def.h"
#include "main.h"
#include "table.h"
#include "exec.h"

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  Program pm[50000];
  struct sigaction sigact = {.sa_handler = signalcatch, .sa_flags = 0}, ign = {.sa_handler = SIG_IGN, .sa_flags = SA_RESTART};

  sigemptyset(&sigact.sa_mask);
  sigemptyset(&ign.sa_mask);
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
  
  do{
    if(printflag == 1)
      print_instr(pm[pc], pc);
    
    while((breakflag == 1 && pc == breakpoint) || (stepflag == 1 && stepcount == 0)) {
       sigaction(SIGINT, &ign, NULL);

       bpoint(pm[pc]);

       sigaction(SIGINT, &sigact, NULL);
    }

    if(stepcount > 0)
      stepcount--;

  } while(exec(pm[pc]) == 0 && sigint == 0 && sigsegv == 0);

  if(sigint == 1) {
    fprintf(stderr, "sigint caught\npc = %d\n", pc);
    for(i = -2; i < 3; i++)
      print_instr(pm[pc+i], pc+i);
  } else if(sigsegv == 1) {
    fprintf(stderr, "sigsegv caught\npc = %d\n", pc);
    for(i = -2; i < 3; i++)
      print_instr(pm[pc+i], pc+i);
  } else
    fprintf(stderr, "complete instructions\n");
  
  print_status();
  
  if(inflag == 1)
    fclose(fpin);
  if(outflag == 1)
    fclose(fpout);

  return 0;
}
