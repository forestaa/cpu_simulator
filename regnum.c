#include <string.h>

int regnum(char *buf)
{
  if(strcmp(buf, "zero") == 0 || strcmp(buf, "r0") == 0)
    return 0;
  else if(strcmp(buf, "at") == 0 || strcmp(buf, "r1") == 0)
    return 1;
  else if(strcmp(buf, "v0") == 0 || strcmp(buf, "r2") == 0)
    return 2;
  else if(strcmp(buf, "v1") == 0 || strcmp(buf, "r3") == 0)
    return 3;
  else if(strcmp(buf, "a0") == 0 || strcmp(buf, "r4") == 0)
    return 4;
  else if(strcmp(buf, "a1") == 0 || strcmp(buf, "r5") == 0)
    return 5;
  else if(strcmp(buf, "a2") == 0 || strcmp(buf, "r6") == 0)
    return 6;
  else if(strcmp(buf, "a3") == 0 || strcmp(buf, "r7") == 0)
    return 7;
  else if(strcmp(buf, "t0") == 0 || strcmp(buf, "r8") == 0)
    return 8;
  else if(strcmp(buf, "t1") == 0 || strcmp(buf, "r9") == 0)
    return 9;
  else if(strcmp(buf, "t2") == 0 || strcmp(buf, "r10") == 0)
    return 10;
  else if(strcmp(buf, "t3") == 0 || strcmp(buf, "r11") == 0)
    return 11;
  else if(strcmp(buf, "t4") == 0 || strcmp(buf, "r12") == 0)
    return 12;
  else if(strcmp(buf, "t5") == 0 || strcmp(buf, "r13") == 0)
    return 13;
  else if(strcmp(buf, "t6") == 0 || strcmp(buf, "r14") == 0)
    return 14;
  else if(strcmp(buf, "t7") == 0 || strcmp(buf, "r15") == 0)
    return 15;
  else if(strcmp(buf, "s0") == 0 || strcmp(buf, "r16") == 0)
    return 16;
  else if(strcmp(buf, "s1") == 0 || strcmp(buf, "r17") == 0)
    return 17;
  else if(strcmp(buf, "s2") == 0 || strcmp(buf, "r18") == 0)
    return 18;
  else if(strcmp(buf, "s3") == 0 || strcmp(buf, "r19") == 0)
    return 19;
  else if(strcmp(buf, "s4") == 0 || strcmp(buf, "r20") == 0)
    return 20;
  else if(strcmp(buf, "s5") == 0 || strcmp(buf, "r21") == 0)
    return 21;
  else if(strcmp(buf, "s6") == 0 || strcmp(buf, "r22") == 0)
    return 22;
  else if(strcmp(buf, "s7") == 0 || strcmp(buf, "r23") == 0)
    return 23;
  else if(strcmp(buf, "t8") == 0 || strcmp(buf, "r24") == 0)
    return 24;
  else if(strcmp(buf, "t9") == 0 || strcmp(buf, "r25") == 0)
    return 25;
  else if(strcmp(buf, "k0") == 0 || strcmp(buf, "r26") == 0)
    return 26;
  else if(strcmp(buf, "k1") == 0 || strcmp(buf, "r27") == 0)
    return 27;
  else if(strcmp(buf, "gp") == 0 || strcmp(buf, "r28") == 0)
    return 28;
  else if(strcmp(buf, "sp") == 0 || strcmp(buf, "r29") == 0)
    return 29;
  else if(strcmp(buf, "s8") == 0 || strcmp(buf, "hp") == 0 || strcmp(buf, "r30") == 0)
    return 30;
  else if(strcmp(buf, "ra") == 0 || strcmp(buf, "r31") == 0)
    return 31;
  else
    return 32;
}

char *regname(int i)
{
  if(i == 0)
    return "$zero";
  else if(i == 1)
    return "$at";
  else if(i == 2)
    return "$v0";
  else if(i == 3)
    return "$v1";
  else if(i == 4)
    return "$a0";
  else if(i == 5)
    return "$a1";
  else if(i == 6)
    return "$a2";
  else if(i == 7)
    return "$a3";
  else if(i == 8)
    return "$t0";
  else if(i == 9)
    return "$t1";
  else if(i == 10)
    return "$t2";
  else if(i == 11)
    return "$t3";
  else if(i == 12)
    return "$t4";
  else if(i == 13)
    return "$t5";
  else if(i == 14)
    return "$t6";
  else if(i == 15)
    return "$t7";
  else if(i == 16)
    return "$s0";
  else if(i == 17)
    return "$s1";
  else if(i == 18)
    return "$s2";
  else if(i == 19)
    return "$s3";
  else if(i == 20)
    return "$s4";
  else if(i == 21)
    return "$s5";
  else if(i == 22)
    return "$s6";
  else if(i == 23)
    return "$s7";
  else if(i == 24)
    return "$t8";
  else if(i == 25)
    return "$t9";
  else if(i == 26)
    return "$k0";
  else if(i == 27)
    return "$k1";
  else if(i == 28)
    return "$gp";
  else if(i == 29)
    return "$sp";
  else if(i == 30)
    return "$hp";
  else if(i == 31)
    return "$ra";
  else
    return "unknown regsiter";
}
