global EXPONENCIACAO 

extern read_int
extern read_int_16
extern int_to_string
extern write_output

extern precision

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8] 

%define arg1_16 word [EBP - 4]
%define arg2_16 word [EBP - 6]

section .data:
    msg_overflow db "OCORREU OVERFLOW ", 0DH, 0Ah
    size_msg_overflow EQU $-msg_overflow


section .text
    EXPONENCIACAO:
        enter 8,0
        push ebx
        push ecx

        cmp byte [precision], 0x30 
        jne prec32
            call read_int_16
            mov arg1_16, ax

            call read_int_16
            mov arg2_16, ax

            mov ax, arg1_16
            mov bx, arg2_16
            mov cx, ax

            cmp bx, 0
            jne loop_exponenciacao_16
                mov ax, 1
                jmp out_loop

            loop_exponenciacao_16: 
                cmp bx, 1
                jle out_loop
                    imul cx 
                    jo overflow_handler
                    dec bx 
                jmp loop_exponenciacao_16
        
        prec32:
            call read_int
            mov arg1, eax

            call read_int
            mov arg2, eax

            mov eax, arg1
            mov ebx, arg2
            mov ecx, eax

            cmp ebx, 0
            jne loop_exponenciacao
                mov eax, 1
                jmp out_loop

            loop_exponenciacao: 
                cmp ebx, 1
                jle out_loop
                    imul ecx 
                    jo overflow_handler
                    dec ebx 
                jmp loop_exponenciacao

        out_loop:
            call int_to_string
            jmp final_exponenciacao

        overflow_handler: 
            call print_overflow

            mov eax, 1
            mov ebx, 1
            int 80h

        final_exponenciacao:
            pop ebx
        leave
        ret

    print_overflow:
        enter 0,0

        push DWORD msg_overflow
        push DWORD size_msg_overflow
        call write_output

        leave
        ret
