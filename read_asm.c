#include <stdio.h>

void read_asm(Assembli *program, FILE *fp)
{
  int i = 0;
  char str[40];

  while(fgets(str, 40, fp) != NULL) {
    if(strstr(str, ".data") != NULL || strstr(str, ".text") != NULL || strchr(str, '#') != NULL)
      strcpy
  }
}
