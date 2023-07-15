global debug_msg

section .data
    msg db 'DEBUG '
    SIZE_MSG EQU $-msg
    nwln db 0dh, 0ah
    SIZE_NWLN EQU $-nwln

section .bss
    arg1 resb 1
    arg2 resb 1

section .text
    debug_msg: 
        push eax

        mov eax, 4
        mov ebx, 1
        pop ecx
        mov edx, SIZE_MSG
        int 80h

        ret
