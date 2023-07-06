
PROG := sec86

FLAGS += -I. -static -lgcc_s #-l/usr/x86_64-linux-uclibc/usr/lib/libc.a
FLAGS := -Oz -nostdlib -fwhole-program
FLAGS += -ffunction-sections -fdata-sections -fno-asynchronous-unwind-tables
FLAGS += -m32 -march=i686
FLAGS += -fno-stack-protector -fno-ident
FLAGS += -Wl,-z,norelro -no-pie -Wl,--build-id=none
FLAGS += -Wl,--wrap=write -Wl,--wrap=read -Wl,--wrap=exit

CFLAGS := -std=c99 -Wall -Wextra
LDFLAGS := -s -Wl,--strip-all

SRCs := $(wildcard *.c)
OBJs := $(SRCs:.c=.o)
SRCs += $(wildcard *.h)

all: $(OBJs)
	mkdir -p bin
	gcc $(FLAGS) $(LDFLAGS) $(addprefix tmp/,$^) -o bin/$(PROG)
	strip -s -R .gnu.hash -R .note.gnu.property -R .got.plt bin/$(PROG)

%.o: %.c
	mkdir -p tmp
	gcc $(FLAGS) $(CFLAGS) -c $< -o tmp/$@

clean:
	rm -rf tmp

.PHONY: clean all