CC      = gcc
CFLAGS  = -pie -g -std=c99 -Werror -pedantic

SRCS = $(wildcard *.c)

PROGS = $(patsubst %.c,%,$(SRCS))

all: $(PROGS)

%: %.c
	$(CC) $(CFLAGS)  -o $@ $<
	rm -rf *.dSYM

