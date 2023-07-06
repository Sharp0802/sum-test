
PROG := sum-test

CC := g++

FLAGS := -I. -Oz
FLAGS += -ffunction-sections -fdata-sections -fno-asynchronous-unwind-tables
FLAGS += -m32 -march=i686
FLAGS += -fno-stack-protector -Wl,--build-id=none

CFLAGS := -std=c++11 -Wall -Wextra
LDFLAGS := -s -Wl,--strip-all

SRCs := $(wildcard *.cpp)
OBJs := $(SRCs:.cpp=.o)
SRCs += $(wildcard *.h)

all: $(OBJs)
	mkdir -p bin
	$(CC) $(FLAGS) $(LDFLAGS) $^ -o bin/$(PROG)
	strip -s -R .gnu.hash -R .note.gnu.property bin/$(PROG)

%.o: %.cpp
	$(CC) $(FLAGS) $(CFLAGS) -c $< -o $@

sum.o: sum.cpp

clean:
	rm -rf tmp

.PHONY: clean all
