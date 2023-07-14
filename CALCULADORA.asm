section .data
bem_vindo       db  "Bem-vindo. Digite seu nome:"
bem_vindo_len   EQU $ - bem_vindo
hola            db  "Hola, "
hola_len        EQU $ - hola
programa        db  ", bem-vindo ao programa de CALC IA-32", 0
programa_len    EQU $ - programa
nwln            db  0Dh, 0Ah
NWLNSIZE        EQU $-nwln

section .bss
user_name   resb    16

section .text
global _start
_start:

    ; Imprime bem vindo
    mov eax, 4
    mov ebx, 1
    mov ecx, bem_vindo
    mov edx, bem_vindo_len
    int 80h

    ; Pega nome
    mov eax, 3
    mov ebx, 0
    mov ecx, user_name
    mov edx, 16
    int 80h

    ; Imprime Hola
    mov eax, 4
    mov ebx, 1
    mov ecx, hola
    mov edx, hola_len
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, user_name  ;TODO: após o nome existe uma quebra de linha, retirar
    mov edx, 16
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, programa
    mov edx, programa_len
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, nwln
    mov edx, NWLNSIZE
    int 80h

    ; Encerra programa
    mov eax, 1
    mov ebx, 0
    int 80h