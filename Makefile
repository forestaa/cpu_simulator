CC = gcc
CFLAGS = -O3 -Wall
SRCS = isa.c print.c opt.c regnum.c fadd.c
OBJS = $(SRCS:.c=.o)

TARGET = sim_machine

all: $(TARGET)

$(TARGET): sim_machine.c $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(TARGET) $(OBJS) *~ '#'* result.txt output
