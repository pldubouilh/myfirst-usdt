DTRACE=dtrace
UNAME=$(shell uname)

LDFLAGS=
COPTS=-Wall -g -O2
OBJS=test.o
LIBS=-lpthread
DTOBJS=
DTSRC=
ifneq ($(UNAME),Darwin)
	DTOBJS+=probe.o
endif
ifeq ($(UNAME),FreeBSD)
	DTSRC=$(OBJS)
	LIBS+=-lelf
endif

.c.o:
	$(CC) -c $(COPTS) $<

all: test

test: probe.h $(OBJS) $(DTOBJS)
	$(CC) -o $@ $(OBJS) $(DTOBJS) $(LIBS)

probe.h: probe.d
	$(DTRACE) -o $@ -s $< -h

# Darwin does not require this
probe.o: probe.d $(DTSRC)
	@rm -f $@
	$(DTRACE) -G -o $@ -s $< $(DTSRC)

clean:
	@rm -f test $(OBJS) $(DTOBJS) probe.h

.PHONY: clean
