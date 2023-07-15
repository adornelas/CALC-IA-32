section .data
bem_vindo       db 'Bem-vindo. Digite seu nome: '
bem_vindo_len   EQU $-bem_vindo
hola            db  'Hola, '
hola_len        EQU $-hola
bem_vindo2        db  ', bem-vindo ao programa de CALC IA-32',00Dh, 0Ah
bem_vindo2_len    EQU $-bem_vindo2
bit_question        db  'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):'
bit_question_len    EQU $-bit_question
nwln            db  0Dh, 0Ah
NWLNSIZE        EQU $-nwln

section .bss
user_name       resb 16
user_name_len   resd 1

section .text
global _start
_start:

    call print_welcome
    call get_name
    call print_hola
    call print_name
    call print_welcome2
    call print_bitquestion

    ; Encerra programa
    mov eax, 1
    mov ebx, 0
    int 80h

print_msg:
    ; Imprime uma string que foi passada pela pilha por parâmetro, com seu tamanho empilhado em seguida
    enter 0,0
    
    mov eax, 4
    mov ebx, 1
    mov ecx, [EBP+12]
    mov edx, [EBP+8]
    int 80h

    leave
    ret

print_welcome:
    enter 0,0
    push DWORD bem_vindo
    push DWORD bem_vindo_len

    call print_msg

    leave
    ret

get_name:
    enter 0,0
    
    mov eax, 3
    mov ebx, 0
    mov ecx, user_name
    mov edx, 16
    int 80h
    dec eax
    mov [user_name_len], eax

    leave
    ret

print_hola:
    enter 0,0
    push DWORD hola
    push DWORD hola_len

    call print_msg

    leave
    ret

print_name:
    enter 0,0
    push DWORD user_name
    push DWORD user_name_len

    call print_msg

    leave
    ret

print_welcome2:
    enter 0,0
    push DWORD bem_vindo2
    push DWORD bem_vindo2_len

    call print_msg

    leave
    ret

print_bitquestion:
    enter 0,0
    push DWORD bit_question
    push DWORD bit_question_len

    call print_msg

    leave
    ret
