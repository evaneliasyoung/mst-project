################################################################################
### @file   makefile
### @author Evan Elias Young (eeymrr)
### @brief  The program makefile.
################################################################################

CC      = g++
FLAGS   = -std=c++14 -g -Wall -O0 -W -pedantic-errors
SOURCES = $(wildcard *.cpp)
OBJECTS = ${SOURCES:%.cpp=%.o}
EXEC = prog.exe
PCH_SRC = pch.h
PCH_OUT = pch.h.gch

default: $(EXEC)
all: clean $(EXEC) run

$(PCH_OUT): $(PCH_SRC)
	$(CC) $(FALGS) -o $@ $<

%.o: %.cpp $(PCH_OUT)
	$(CC) $(FLAGS) -c $< -o $@

$(EXEC): $(OBJECTS)
	$(CC) $(FLAGS) $(OBJECTS) -o $@

run: ${EXEC}
	./${EXEC}

clean:
	-@rm -f $(OBJECTS) >/dev/null 2>&1
	-@rm -f $(PCH_OUT) >/dev/null 2>&1
	-@rm -f prog.exe >/dev/null 2>&1
