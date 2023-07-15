extern display_msg ; declara que a função é externa 

global _start

section .text
_start:
    ; a linha abaixo pode aparecer como erro no VSCODE se vc usar a extensao
    ; do nasm. Mas fazendo o procedimento correto de ligação, esse erro pode ser 
    ; ignorado
    call display_msg ; chama funcao de outro modulo

    push eax ; coloco EAX na pilha pra nao sobreescrever retorno

    mov eax, 4
    mov ebx, 1
    pop ecx ; pego o valor de EAX que foi retornado na função display_msg
    mov edx, 3
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
    
