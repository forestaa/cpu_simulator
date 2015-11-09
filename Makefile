CC = gcc
CFLAGS = -Wall
SRCS1 = isa.c regset_asm.c
SRCS2 = isa.c print.c opt.c
OBJS1 = $(SRCS1:.c=.o)
OBJS2 = $(SRCS2:.c=.o)

TARGET1 = sim_asm
TARGET2 = sim_machine

all: $(TARGET1) $(TARGET2)

$(TARGET1): sim_asm.c $(OBJS1)
	$(CC) $(CFLAGS) -o $@ $^

$(TARGET2): sim_machine.c $(OBJS2)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(TARGET1) $(TARGET2) $(OBJS1) $(OBJS2) *~ '#'* result.txt output
