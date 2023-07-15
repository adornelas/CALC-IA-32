global display_msg ; pra usar o extern em outros modulos, tem que usar global pra cada 
; procedimento ou variavel que vc for exportar 

; abaixo é so uma função pra exemplificar o uso de global, extern e o retorno por EAX 
; A função pede pra digitar um numero mas aceita qualquer caractere 
section .data
    str: times 100 db 0
    lf: db 10
    msg: db 'DIGITE UM NUMERO '
    sizemsg: EQU $-msg

section .bss 
    e1_len resd 2
    dummy resd 2

section .text
    display_msg: 
        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, sizemsg
        int 80h

        mov eax, 3
        mov ebx, 0
        mov ecx, str
        mov edx, 200
        int 80h

        ; abaixo é um procedimento pra lidar com o buffer 
        mov [e1_len], eax
        cmp eax, edx
        jb .2 
        mov bl, [ecx+eax-1]
        cmp bl, 10
        jb .2
        inc DWORD [e1_len]

        .1:
            mov eax, 3
            mov ebx, 0
            mov ecx, dummy
            mov edx, 1
            int 80h 
            test eax,eax

            jz .2
            mov al, [dummy]
            cmp al, 10
            jne .1

        .2:
            mov eax, 4
            mov ebx, 1
            mov ecx, str
            mov edx, [e1_len]
            int 80h
            mov eax, ecx ; aqui eu passo a string q o usuario digitou pra EAX
        
        ret
