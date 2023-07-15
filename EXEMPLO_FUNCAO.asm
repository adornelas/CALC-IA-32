extern read_int
extern int_to_string

section .data

bem_vindo db "Bem vindo.", 0dh, 0ah
bem_vindo_len equ $ - bem_vindo

numero db 'O numero é ',
numero_size equ $ - numero

section .bss
    precisao resb 4

section .text
global _start
_start:

    ; Imprime bem vindo
    mov eax, 4
    mov ebx, 1
    mov ecx, bem_vindo
    mov edx, bem_vindo_len
    int 80h

    call read_int
    push eax

    push eax
    call int_to_string
    add esp,4 

    push eax
    mov eax, 4
    mov ebx, 1
    mov ecx, numero
    mov edx, numero_size
    int 80h

    pop ecx
    mov eax, 4
    mov ebx, 1
    mov edx, 30
    int 80h
    
    ; Encerra programa
    mov eax, 1
    mov ebx, 0
    int 80h