extern read_int
extern int_to_string
extern SUBTRACAO
extern DIVISAO
extern MULTIPLICACAO
extern SOMA

section .data
bem_vindo       db 'Bem-vindo. Digite seu nome: '
bem_vindo_len   EQU $-bem_vindo
hola            db  'Hola, '
hola_len        EQU $-hola
bem_vindo2        db  ', bem-vindo ao programa de CALC IA-32',00Dh, 0Ah,
bem_vindo2_len    EQU $-bem_vindo2
bit_question        db  'Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):'
bit_question_len    EQU $-bit_question
menu        db  'ESCOLHA UMA OPÇÃO:',00Dh, 0Ah,'- 1: SOMA',00Dh, 0Ah,'- 2: SUBTRACAO',00Dh, 0Ah,'- 3: MULTIPLICACAO',00Dh, 0Ah,'- 4: DIVISAO',00Dh, 0Ah,'- 5: EXPONENCIACAO',00Dh, 0Ah,'- 6: MOD',00Dh, 0Ah,'- 7: SAIR',00Dh, 0Ah,
menu_len    EQU $-menu

nwln            db  0Dh, 0Ah
NWLNSIZE        EQU $-nwln

section .bss
user_name       resb 16
user_name_len   resd 1
precision       resb 1
op_option       resb 1

section .text
global _start
_start:

    call print_welcome
    call get_name
    call print_hola
    call print_name         ;TODO: retirar quebra de linha após printar nome
    call print_welcome2
    call print_bitquestion
    call get_precison
    call print_menu
    call handle_menu

exit:               ; Encerra programa
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

get_precison:
    enter 0,0
    
    mov eax, 3
    mov ebx, 0
    mov ecx, precision
    mov edx, 2
    int 80h

    leave
    ret

print_menu:
    enter 0,0
    push DWORD menu
    push DWORD menu_len

    call print_msg

    leave
    ret

get_option:
    enter 0,0
    
    mov eax, 3
    mov ebx, 0
    mov ecx, op_option
    mov edx, 2
    int 80h

    leave
    ret

handle_menu:
    enter 0,0
    
    call get_option

    cmp BYTE [op_option], '1'
    je case_soma
    cmp BYTE [op_option], '2'
    je case_subtracao
    cmp BYTE [op_option], '3'
    je case_multiplicacao
    cmp BYTE [op_option], '4'
    je case_divisao
    ; cmp BYTE [op_option], '5'
    ; je case_3
    ; cmp BYTE [op_option], '6'
    ; je case_3
    cmp BYTE [op_option], '7'
    je exit

end_switch:
    leave
    ret

case_soma:
    call SOMA

    push DWORD eax
    push DWORD 32

    call print_msg
    jmp end_switch


case_subtracao:
    call SUBTRACAO

    push DWORD eax
    push DWORD 32

    call print_msg
    jmp end_switch


case_multiplicacao:
    call MULTIPLICACAO

    push DWORD eax
    push DWORD 32

    call print_msg
    jmp end_switch


case_divisao:
    call DIVISAO
    
    push DWORD eax
    push DWORD 32

    call print_msg
    jmp end_switch
