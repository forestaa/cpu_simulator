#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

int32_t *regset(char *p)
{
  char buf[3];
  int i;

  if(*p == 'r') {
    p++;
    if(*p == 'a')
      return reg + 31;
    else {
      buf[0] = *p;
      p++;
      if(*p == ',') 
	buf[1] = '\0';
      else {
	buf[1] = *p;
	buf[2] = '\0';
      }
      i = atoi(buf);
      if(i < 32)
	return reg + i;
      else {
	printf("this register does not exist : r%d\n", i);
	return reg;
      }
    }
  } else if(*p == 'z')
    return reg;
  else if(*p == 'v') {
    p++;
    if(*p == '0')
      return reg + 2;
    else if(*p == '1')
      return reg + 3;
    else {
      printf("this register does not exist : v\n");
      return reg;
    }
  } else if(*p == 'a') {
    p++;
    if(*p == 't')
      return reg + 1;
    else {
      buf[0] = *p;
      buf[1] = '\0';
      i = atoi(buf);
      if(i < 4)
	return reg + 4 + i;
      else {
	printf("this register does not exist : a%d\n", i);
	return reg;
      }
    }
  } else if(*p == 't') {
    p++;
    if(*p == 'm')
      return reg + 24;
    else {
      buf[0] = *p;
      buf[1] = '\0';
      i = atoi(buf);
      if(i < 8)
	return reg + 8 + i;
      else if(i == 8 || i ==9)
	return reg + 16 + i;
      else {
	printf("this register does not exist : t%d\n", i);
	return reg;
      }
    } 
  } else if(*p == 's') {
    p++;
    if(*p == 'w')
      return reg + 1;
    else if(*p == 'p') 
      return reg + 29;
    else if(*p == '8')
      return reg + 30;
    else {
      buf[0] = *p;
      buf[1] = '\0';
      i = atoi(buf);
      if(i < 8)
	return reg + 16 + i;
      else {
	printf("this register does not exist : s%d\n", i);
	return reg;
      }
    }
  } else if(*p == 'k') {
    p++;
    if(*p == '0')
      return reg + 26;
    else if(*p == '1')
      return reg + 27;
    else {
      printf("this register does not exist : k\n");
      return reg;
    }
  } else if(*p == 'g')
    return reg + 28;
  else if(*p == 'h')
    return reg + 30;
  else if(*p == 'c')
    return reg + 31;
  else {
    printf("not defined register\n");
    return reg;
  }
}
