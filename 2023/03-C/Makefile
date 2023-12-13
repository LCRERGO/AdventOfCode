VERSION = 1.0.0

PREFIX =
MANPREFIX =

INCS =
LIBS =

CFLAGS = -O2 -Wall -pedantic
LDFLAGS =
CC ?= gcc

DLEVEL ?= 1
BIN = phase1 phase1_debug phase2 phase2_debug

main: phase1 phase2

debug: phase1_debug

phase1: phase1.c
	${CC} -o $@ $^ ${CFLAGS} ${LDFLAGS}

phase2: phase2.c
	${CC} -o $@ $^ ${CFLAGS} ${LDFLAGS}

phase1_debug: phase1.c
	${CC} -g -o $@ $^ -O0 -Wall -pedantic ${LDFLAGS} -DDEBUG=${DLEVEL}

phase2_debug: phase2.c
	${CC} -g -o $@ $^ -O0 -Wall -pedantic ${LDFLAGS} -DDEBUG=${DLEVEL}

clean:
	rm -rf ${BIN} *.o

install:

uninstall:
