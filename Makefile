BIN      = CALCULADORA
NASM     = nasm -f elf
LINK     = ld -m elf_i386
SRCS     = $(shell find -name "*.asm")
OBJ      = $(addprefix obj/,$(SRCS:%.asm=%.o)) 
DIR      = $(addprefix obj/,$(shell find src/ -type d)) 
RM       = rm -rf

.PHONY: all all-before clean

$(BIN): all-before $(OBJ)
	$(LINK) $(OBJ) -o $(BIN)

all: all-before $(BIN)

all-before: 
	mkdir -p obj $(DIR)

clean:
	${RM} $(OBJ) $(BIN) obj

obj/%.o: %.asm
	$(NASM) $< -o $@
