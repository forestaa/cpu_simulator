CC = gcc
CFLAGS = -O3 -Wall
SRCS = isa.c print.c opt.c regnum.c fadd.c
OBJS = $(SRCS:.c=.o)

TARGET = sim_machine 

all: $(TARGET)

$(TARGET): sim_machine.c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

test: trifunc_test.c $(OBJS)
	$(CC) $(CFLAGS) -o trifunc_test $^
clean:
	rm -f $(TARGET) $(OBJS) *~ '#'* result.txt output trifunc_test
