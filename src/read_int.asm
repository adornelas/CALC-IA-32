global read_int

section .data
    msg db 'Digite um numero '
    SIZE_MSG EQU $-msg

    erro db 'Entrada inválida. Digite o número novamente ', 0dh, 0ah
    size_erro equ $-erro

    negativo db 1

section .bss
    precisao resb 4
    string resd 1
    input_buffer resb 15 
    number_precisao resb 4
    result resb 4

section .text
    read_int:
        ; TODO: remover print da mensagem para digitar precisao 
        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, SIZE_MSG
        int 80h
        ; TODO: remover linhas acima ate comentario quando integrar todo o menu

        mov eax, 3
        mov ebx, 0
        mov ecx, input_buffer
        mov edx, 15
        int 80h

        mov esi, input_buffer
        mov edi, result
        xor ecx, ecx

        find_length: 
            cmp byte [esi + ecx], 0ah ; 0ah = '\n'
            je convert
            inc ecx 
            jmp find_length
        
        convert:
            xor eax, eax
            xor ebx, ebx
            xor edx, edx 
            push byte 0
        
        convert_loop:
            cmp byte [esi], 0x2d ; 0x2d = '-'  
            je handle_negative

            cmp byte [esi], 0x2b ;0x2b = '+' 
            je handle_positive

            cmp byte [esi], 0 ; Final da string
            je final

            cmp byte [esi], 0ah ; 0ah = '\n' (não queremos no numero)
            je final
        
            sub byte [esi], 0x30 ; 0x30 = '0' (transforma de char pra binario)

            cmp byte [esi], 0
            jb invalid_digit
            cmp byte [esi], 9
            ja invalid_digit

            mov ebx, 10 
            mul ebx

            mov bl, [esi]

            add eax, ebx
            inc esi
            loop convert_loop
            jmp final
        
        invalid_digit:
            mov eax, 4
            mov ebx, 1
            mov ecx, erro
            mov edx, size_erro
            int 80h
        
        handle_negative:
            mov byte [esp], 1

            inc esi 
            loop convert_loop
        
        handle_positive:
            loop convert_loop

        final:            
            
            cmp byte [esp], 1
            jne numero_positivo 
                neg eax 

            numero_positivo: 

            pop ecx ; para limpar a pilha

            ; eax contem conteudo de retorno

        ret
