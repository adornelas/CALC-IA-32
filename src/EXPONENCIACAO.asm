global EXPONENCIACAO 

extern read_int
extern int_to_string

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8] 

section .data:
    msg_overflow db "OCORREU OVERFLOW ", 0DH, 0Ah
    size_msg_overflow EQU $-msg_overflow


section .text
    EXPONENCIACAO:
        enter 8,0
        push ebx
        push ecx

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
            mov eax, 4
            mov ebx, 1
            mov ecx, msg_overflow
            mov edx, size_msg_overflow
            int 80h

            mov eax, 1
            mov ebx, 0
            int 80h

        final_exponenciacao:
            pop ebx
        leave
        ret
