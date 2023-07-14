section .data

bem_vindo db "Bem vindo."
bem_vindo_len equ $ - bem_vindo

section .bss


section .text
global _start
_start:

    ; Imprime bem vindo
    mov eax, 4
    mov ebx, 1
    mov ecx, bem_vindo
    mov edx, bem_vindo_len
    int 80h
   
    ; Encerra programa
    mov eax, 1
    mov ebx, 0
    int 80h