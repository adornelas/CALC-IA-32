# CALC-IA-32
Repo for CIC0104 - Software Básico project


# Pra compilar , ligar e executar

`nasm -f elf -o EXEMPLO_FUNCAO.o EXEMPLO_FUNCAO.asm && nasm -f elf -o read_int.o read_int.asm && nasm -f elf -o int_to_string.o int_to_string.asm`

`ld -m elf_i386 -o EXEMPLO read_int.o int_to_string.o EXEMPLO_FUNCAO.o  `

`./EXEMPLO`