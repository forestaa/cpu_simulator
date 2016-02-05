#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#define BOOL int
#define TRUE (1)
#define FALSE (0)

typedef union {
  int i;
  float f;
} fi_union;

#define MAX_N_WORDS 4096
static fi_union sld_words[MAX_N_WORDS];
static unsigned sld_n_words = 0;
static int error_flag = 0;

void error(char *fmt, ...)
{
  va_list ap;
  va_start(ap,fmt);
  vfprintf(stderr, fmt, ap);
  va_end(ap);
  error_flag = 1;
}

static float read_float(FILE* fp)
{
  float f;

  if(sld_n_words >= MAX_N_WORDS){
    error("read_float : too many sld words.\n");
    exit(1);
  }
  
  if(fscanf(fp, "%f", &f) != 1){
    error("failed to read a float\n");
    fprintf(stderr, "sld_n_words: %d\n", sld_n_words);
    exit(1);
  }

  return (sld_words[sld_n_words++].f = f);
}

static int read_int(FILE* fp)
{
  int i;
  if(sld_n_words >= MAX_N_WORDS){
    error("read_int : too many sld words.\n");
    exit(1);
  }

  if(fscanf(fp, "%d", &i) != 1){
    error("failed to read an int\n");
    exit(1);
  }
  
  return (sld_words[sld_n_words++].i = i);
}

static void read_vec3(FILE* fp)
{
  read_float(fp);
  read_float(fp);
  read_float(fp);
}

static void read_sld_env(FILE* fp)
{
  /* screen pos */
  read_vec3(fp);
  /* screen rotation */
  read_float(fp);  read_float(fp); 
  /* n_lights : Actually, it should be an int value ! */
  read_float(fp);
  /* light rotation */
  read_float(fp);  read_float(fp);
  /* beam  */
  read_float(fp);
}

static void read_objects(FILE* fp)
{

  while (read_int(fp) != -1) {  /* texture : -1 -> end */
    /* form */
    read_int(fp);
    /* refltype */
    read_int(fp);
    /* isrot_p*/
    int is_rot = read_int(fp);
    /* abc */
    read_vec3(fp);
    /* xyz */
    read_vec3(fp);
    /* is_invert */
    read_float(fp);
    /* refl_param */
    read_float(fp); read_float(fp);
    /* color */
    read_vec3(fp);
    /* rot */
    if(is_rot){
      read_vec3(fp);
    }
  }
}

static void read_and_network(FILE* fp)
{
  while(read_int(fp) != -1){
    while(read_int(fp) != -1);
  }
}

static void read_or_network(FILE* fp)
{
  while(read_int(fp) != -1){
    while(read_int(fp) != -1);
  }
}

static void read_sld(FILE* fp, BOOL conv_to_big_endian)
{
  read_sld_env(fp);
  read_objects(fp);
  read_and_network(fp);
  read_or_network(fp);
  if(conv_to_big_endian){
    unsigned u;
    for(u = 0; u < sld_n_words; u++){
      int i = sld_words[u].i;
      sld_words[u].i = 
        ((i & 0xff) << 24) | ((i & 0xff00) << 8) |
          ((i >> 8) & 0xff00) | ((i >> 24) & 0xff);
    }
  }
}

int main(int argc, char *argv[])
{
  FILE *fpin, *fpout;
  BOOL little_endian = 0;

  fpin = fopen(argv[argc-2], "r");
  read_sld(fpin, little_endian);

  fpout = fopen(argv[argc-1], "w");
  fwrite(sld_words, 4, sld_n_words, fpout);

  return 0;
}
