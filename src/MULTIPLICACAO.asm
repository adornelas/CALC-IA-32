global MULTIPLICACAO 

extern read_int
extern read_int_16
extern int_to_string
extern print_output

extern precision

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8] 

%define arg1_16 word [EBP - 4]
%define arg2_16 word [EBP - 6]

section .data:
    msg_overflow db "OCORREU OVERFLOW ", 0DH, 0Ah
    size_msg_overflow EQU $-msg_overflow

section .text
    MULTIPLICACAO:
        enter 8,0
        push ebx

        cmp byte [precision], 0x30 ; se for '0' é 16 bits
        jne prec32
            call read_int_16
            mov arg1_16, ax

            call read_int_16
            mov arg2_16, ax

            mov ax, arg1_16
            mov bx, arg2_16
            imul ax,bx

            jo overflow_handler

            call int_to_string
            jmp final_mul             

        prec32:
                call read_int
                mov arg1, eax

                call read_int
                mov arg2, eax

                mov eax, arg1
                mov ebx, arg2
                imul ebx 

                jo overflow_handler

                call int_to_string
                jmp final_mul

        overflow_handler: 
            call print_overflow

            mov eax, 1
            mov ebx, 0
            int 80h

        final_mul:
            pop ebx
        leave
        ret

    print_overflow:
        enter 0,0

        push DWORD msg_overflow
        push DWORD size_msg_overflow
        call print_output

        leave
        ret
