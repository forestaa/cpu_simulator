CC = gcc
CFLAGS = -O3 -Wall
SRCS = print.c option.c register.c load.c
OBJS = $(SRCS:%.c=%.o)
DEPS = $(SRCS:%.c=%.d) sim_high.d sim_debug.d lib_test.d
FPUDIR = ../FPU
FPUSRCS = fadd.c def.c fmul.c fsqrt.c finv.c ftoi.c itof.c
FPUOBJS = $(FPUSRCS:%.c=$(FPUDIR)/%.o)

TARGET = sim
DEBUG = sim_debug
LIBTEST = lib_test

default: $(TARGET)

$(TARGET): sim_high.o $(OBJS) $(FPUOBJS)
		$(CC) $(CFLAGS) -o $@ $^ -lm

debug: sim_debug.o $(OBJS) $(FPUOBJS)
		$(CC) $(CFLAGS) -o $(DEBUG) $^ -lm

test: lib_test.o $(OBJS)
		$(CC) $(CFLAGS) -o $(LIBTEST) $^ -lm

read_sld: read_sld.c
		$(CC) $(CFlAGS) -o $@ $<

%.o: %.c
		$(CC) -O3 -c -MMD -MP -o $@ $<

clean:
		rm -f $(TARGET) $(DEBUG) $(LIBTEST) $(OBJS) $(DEPS) $(FPUOBJS) sim_high.o sim_debug.o lib_test.o *~ '#'* res.txt output read_sld

-include $(DEPS)
