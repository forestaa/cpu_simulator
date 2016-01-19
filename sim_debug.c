#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "def.h"
#include "main.h"
#include "table.h"
#include "exec.h"

int main(int argc, char *argv[])
{
  FILE *fp;
  int i;
  Program pm[50000];

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
  
  do{
    if(printflag == 1)
      print_instr(pm[pc]);
    
    while((breakflag == 1 && pc == breakpoint) || (stepflag == 1 && stepcount == 0))
      bpoint(pm[pc]);
    
    if(stepcount > 0)
      stepcount--;

  } while(exec(pm[pc]) == 0);

  fprintf(stderr, "complete instructions\n");
  
  print_status();
  
  fclose(fpin);
  fclose(fpout);

  return 0;
}
