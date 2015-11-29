CC = gcc
CFLAGS = -O3 -Wall
SRCS = exec.c isa.c print.c opt.c regnum.c ../FPU/fadd.c ../FPU/fneg.c ../FPU/def.c ../FPU/fmul.c
OBJS = $(SRCS:.c=.o)

TARGET = sim_machine 
TARGETTEST = trifunc_test

all: $(TARGET)

$(TARGET): sim_machine.c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -lm

test: trifunc_test.c $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGETTEST) $^ -lm
clean:
	rm -f $(TARGET) $(TARGETTEST) $(OBJS) *~ '#'* res.txt output
