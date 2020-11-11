################################################################################
### @file   makefile
### @author Evan Elias Young (eeymrr)
### @brief  The program makefile.
################################################################################

CC      = g++
BASE_FLAGS = -std=c++17
SOURCES = $(wildcard *.cpp)
OBJECTS = ${SOURCES:%.cpp=%.o}
EXEC = prog.exe
PCH_SRC = pch.h
PCH_OUT = pch.h.gch

release: TARGET_FLAGS = -O3
debug: TARGET_FLAGS = -g -Wall -O0 -W -pedantic-errors

release: EXEC = prog.rel.exe
debug: EXEC = prog.dbg.exe
leakcheck: EXEC = prog.dbg.exe
clean: EXEC = prog.rel.exe prog.dbg.exe

default: release
all: clean release run

$(PCH_OUT): $(PCH_SRC)
	$(CC) $(FLAGS) -o $@ $<

%.o: %.cpp $(PCH_OUT)
	$(CC) $(BASE_FLAGS) $(TARGET_FLAGS) -c $< -o $@

release: $(OBJECTS)
	$(CC) $(BASE_FLAGS) $(TARGET_FLAGS) $(OBJECTS) -o $(EXEC)

debug: $(OBJECTS)
	$(CC) $(BASE_FLAGS) $(TARGET_FLAGS) $(OBJECTS) -o $(EXEC)

leakcheck: debug
	valgrind --leak-check=full ./$(EXEC)

run: release
	./$(EXEC)

clean:
	-@rm -f $(OBJECTS) >/dev/null 2>&1
	-@rm -f $(PCH_OUT) >/dev/null 2>&1
	-@rm -f $(EXEC) >/dev/null 2>&1
