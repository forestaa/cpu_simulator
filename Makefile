CC = gcc
CFLAGS = -O3 -Wall
SRCS = exec.c isa.c print.c opt.c regnum.c ../FPU/fadd.c ../FPU/fneg.c ../FPU/def.c ../FPU/fmul.c
OBJS = $(SRCS:.c=.o)

TARGET = sim
DEBUG = sim_debug
TRITEST = trifunc_test

default: $(TARGET)

$(TARGET): sim_high.c
	$(CC) $(CFLAGS) -o $@ $^ -lm

debug: sim_debug.c $(OBJS)
	$(CC) $(CFLAGS) -o $(DEBUG) $^ -lm

test: trifunc_test.c $(OBJS)
	$(CC) $(CFLAGS) -o $(TRITEST) $^ -lm

print: print_machinecode.c
	$(CC) -Wall -o $@ $^
clean:
	rm -f $(TARGET) $(DEBUG) $(TRITTEST) $(OBJS) *~ '#'* res.txt output print
