global SUBTRACAO 

extern read_int
extern read_int_16
extern int_to_string

extern precision

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8] 

%define arg1_16 word [EBP - 4]
%define arg2_16 word [EBP - 6]

section .text
    SUBTRACAO:
        enter 8,0
        push ebx

        cmp byte [precision], 0x30 ; se for '0' é 16 bits
        jne sub_prec32
            a1:
            call read_int_16
            mov arg1_16, ax

            a2:
            call read_int_16
            mov arg2_16, ax

            a3:
            mov ax, arg1_16
            a4:
            mov bx, arg2_16
            a5:
            sub ax, bx
            a6: 
            jmp final_SUBTRACAO
            

        sub_prec32:
            call read_int
            mov arg1, eax

            call read_int
            mov arg2, eax

            mov eax, arg1
            mov ebx, arg2
            sub eax, ebx 
        
        final_SUBTRACAO:
            call int_to_string
            pop ebx

        leave
        ret
