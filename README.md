# CALC-IA-32

Equipe:

- André Dornelas Sanches - 17/0099369
- Maria Claudia Campos Martins - 17/0109968

O projeto CALC-IA-32 é um trabalho feito para a disciplina de Software Básico (CIC0104) na Universidade de Brasília. 

Seu objetivo principal é implementar uma calculadora de número com duas precisões diferentes: 16 e 32 bits, seguindo uma série de requisitos detalhados no roteiro do [Trabalho 2](./docs/trabalho2.pdf) disponibilizado pelo Professor Bruno L. M. Espinoza. 

O projeto foi feito e testado no Unix, mais especificadamente, no Ubuntu.


# Pra compilar e ligar

Para compilar e ligar, basta digitar no terminal 

```
make
```

Esse comando irá executar **todos** os comandos necessários para o projeto, de acordo com o que foi definido na Makefile. 

### Alternativa para compilação 

Também podem ser usados os seguintes comandos:

#### Para compilar os arquivos:

`nasm -f elf -o CALCULADORA.o CALCULADORA.asm && nasm -f elf -o read_int.o read_int.asm && nasm -f elf -o int_to_string.o int_to_string.asm && nasm -f elf -o read_int_16.o read_int_16.asm && nasm -f elf -o DIVISAO.o DIVISAO.asm && nasm -f elf -o EXPONENCIACAO.o EXPONENCIACAO.asm && nasm -f elf -o MOD.o MOD.asm && nasm -f elf -o MULTIPLICACAO.o MULTIPLICACAO.asm && nasm -f elf -o SOMA.o SOMA.asm && nasm -f elf -o SUBTRACAO.o SUBTRACAO.asm`

#### Para ligar o programa:

`ld -m elf_i386 obj/./src/EXPONENCIACAO.o obj/./src/SOMA.o obj/./src/read_int.o obj/./src/MULTIPLICACAO.o obj/./src/read_int_16.o obj/./src/MOD.o obj/./src/CALCULADORA.o obj/./src/DIVISAO.o obj/./src/SUBTRACAO.o obj/./src/int_to_string.o obj/./find_length.o  -o CALCULADORA`

## Como executar 

`./CALCULADORA`

# Observações:

A entrada de nome do usuário permite apenas 15 caracteres, e a entrada de números para operações permite apenas 13 dígitos, podendo ser negativo ou positivo.
Caso a operação dê overflow, o programa é encerrado com a flag 1 (erro).
Caso o usuário digite um número inválido o programa também é encerrado com a flag 1.
