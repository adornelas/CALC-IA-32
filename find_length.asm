global find_length

section .text
    find_length:
        enter 0,0

        push esi
        mov esi, [EBP + 8]
        xor eax, eax

        find_length_loop: 
            cmp byte [esi + eax], 0ah ; 0ah = '\n'
            je final_find_length
            inc eax 
            jmp find_length_loop

        final_find_length: 
            pop esi
        leave
        ret 