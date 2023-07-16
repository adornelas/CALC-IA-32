global MOD

extern read_int
extern read_int_16
extern int_to_string

extern precision

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8]

%define arg1_16 word[EBP-4]
%define arg2_16 word[EBP-6]

section .text
    MOD:
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
            xor edx, edx
            cwd
            idiv bx

            mov ax, dx

            jmp final_MOD


        prec32:
            call read_int
            mov arg1, eax

            call read_int
            mov arg2, eax

            mov eax, arg1
            mov ebx, arg2
            xor edx, edx
            cdq 
            idiv ebx 

            mov eax, edx

        final_MOD:
            call int_to_string
            pop ebx
        leave
        ret