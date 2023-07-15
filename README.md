# CALC-IA-32
Repo for CIC0104 - Software Básico project

# Para executar 

É necessário compilar todos os modulos que estão sendo utilizados, não importa a ordem.
Nesse caso do exemplo, pode ser 

```nasm -f elf -o main.o main.asm && nasm -f elf -o display.o display.asm ```

Para ligar os arquivos, é preciso se atentar a ordem de dependencia. Assim, o arquivo principal
será o ultimo da lista pois depende de todos os outros

```ld -m elf_i386 -o programa display.o main.o ```

Tem que configurar o Makefile para não precisarmos fazer isso manualmente 

Depois disso, basta executar

```./programa```
