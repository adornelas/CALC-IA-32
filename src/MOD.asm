extern read_int
extern int_to_string

global MOD

%define arg1 dword[EBP-4] 
%define arg2 dword[EBP-8] 

section .text
    MOD:
        enter 8,0
        push ebx

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

        call int_to_string

        pop ebx
        leave
        ret