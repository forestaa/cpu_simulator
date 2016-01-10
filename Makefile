CC = gcc
CFLAGS = -O3 -Wall
SRCS = print.c opt.c regnum.c
FPUSRCS = ../FPU/fadd.c ../FPU/fneg.c ../FPU/def.c ../FPU/fmul.c ../FPU/fsqrt.c ../FPU/finv.c ../FPU/ftoi.c ../FPU/itof.c
OBJS = $(SRCS:.c=.o)
FPUOBJS = $(FPUSRCS:.c=.o)

TARGET = sim
DEBUG = sim_debug
TRITEST = trifunc_test

default: $(TARGET)

$(TARGET): sim_high.c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -lm

debug: sim_debug.c $(OBJS)
	$(CC) $(CFLAGS) -o $(DEBUG) $^ -lm

test: trifunc_test.c $(OBJS)
	$(CC) $(CFLAGS) -o $(TRITEST) $^ -lm

print: print_machinecode.c
	$(CC) -Wall -o $@ $^
clean:
	rm -f $(TARGET) $(DEBUG) $(TRITEST) $(OBJS) *~ '#'* res.txt output print
