#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include "def.h"

void getoption(int argc, char *argv[])
{
  int i;
  
  while((i = getopt(argc, argv, "hspvb:i:o:")) != -1) {
    switch(i) {
    case 'h':
      fprintf(stderr, "options\n-h: help\n-s: step exec\n-p: print execut instructions\n-b n: breakpoint n\n");
      exit(0);
    case 's':
      stepflag = 1;
      break;
    case 'p':
      printflag = 1;
      break;
    case 'v':
      instrprint = 1;
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
