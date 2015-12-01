#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  FILE *fp;
  int i = 0, j = 0, size;
  unsigned int array[100000];

  if((fp = fopen(argv[1], "r")) == NULL) {
    perror("open error\n");
    return 0;
  }

  if((size  = fread(array,4,100000,fp)) == 0) {
    perror("read error\n");
    return 0;
  }

  fclose(fp);

  printf("type table is array(0 to %d) of std_logic_vector(31 downto 0);\n", size-1);
  printf(" constant testtable : table := (\n  ");
  while(i < size-1) {
    printf(" x\"%08x\",", array[i]);
    j++;
    if(j == 5) {
      printf("\n  ");
      j = 0;
    }
    i++;
  }

  printf(" x\"%08x\");", array[i]);
  return 0;
}
