CC = gcc
CFLAGS = -O3 -Wall
SRCS = exec.c isa.c print.c opt.c regnum.c fadd.c
OBJS = $(SRCS:.c=.o)

TARGET = sim_machine 
TARGETTEST = trifunc_test

all: $(TARGET)

$(TARGET): sim_machine.c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -lm

test: trifunc_test.c $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGETTEST) $^ -lm
clean:
	rm -f $(TARGET) $(TARGETTEST) $(OBJS) *~ '#'* result.txt output
