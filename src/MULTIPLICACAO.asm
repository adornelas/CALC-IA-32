global MULTIPLICACAO 

extern read_int
extern int_to_string

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8] 

section .data:
    msg_overflow db "OCORREU OVERFLOW ", 0DH, 0Ah
    size_msg_overflow EQU $-msg_overflow


section .text
    MULTIPLICACAO:
        enter 8,0
        push ebx

        call read_int
        mov arg1, eax

        call read_int
        mov arg2, eax

        mov eax, arg1
        mov ebx, arg2
        imul ebx 

        jo overflow_handler

        call int_to_string

        overflow_handler: 
            mov eax, 4
            mov ebx, 1
            mov ecx, msg_overflow
            mov edx, size_msg_overflow
            int 80h

            mov eax, 1
            mov ebx, 0
            int 80h

        pop ebx
        leave
        ret
