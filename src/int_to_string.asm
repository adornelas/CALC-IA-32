global int_to_string

extern precision

section .data
    msg db '' ; Coloquei pra nao dar erro com o gdb


section .bss
    buffer resb 15

section .text
    int_to_string:
        ; mov eax, [esp + 4] TODO: corrigir pra usar enter e leave
        push 0
        mov esi, buffer
        add esi, 14
        mov byte [esi], 0
        dec esi
        mov byte [esi], 0ah
        mov ebx, 10

        cmp byte [precision], 0x30 ; '0' - 16 bits
        jne prec32_int_to_string
        prec16_int_to_string:
            cmp ax, 0
            jge next_digit
            neg_int_16:
                mov byte [esp], 1
                not ax
                add ax, 1
                jmp next_digit

        prec32_int_to_string:
            cmp eax, 0
            jge next_digit
            neg_int_32:
                mov byte [esp], 1
                neg eax

    next_digit: 
        xor edx,edx
        div ebx 
        
        add edx, 0x30
        dec esi 
        mov [esi], dl
        test eax, eax
        jnz next_digit
    
    cmp byte [esp], 1
    jne final_int_to_string 
    dec esi 
    mov byte [esi], 0x2d ; 0x2d = '-' 

    final_int_to_string: 
        mov eax, esi
        pop ecx

    ret
    