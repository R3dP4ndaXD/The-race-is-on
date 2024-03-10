section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ;nr pozitii de shiftat pt a ajunge la bitul corespunzator pozitiei (x,y): 8 * x + y

stanga_sus:                                 ;pozitia (x + 1, y - 1)
    ;conditii de existenta
    cmp ebx, 0
    je gata_1
    cmp eax, 7
    je gata_1
    push ecx                                ;salvez ecx
    lea ecx, [8 * (eax + 1) + ebx - 1]      ;calculez nr de pozitii de shiftat
    mov edi, 1
    cmp ecx, 31     
    jg superior_1
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    mov [ecx + 4], edi                      ;adaut bitul la al doilea dword aferent tablei
    jmp gata_1
superior_1:                                 ;pozitia se afla in jumatatea superioara a tablei
    sub ecx, 32                             ;actualizez nr de pozitii de shiftat relativ la 32 de biti
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    mov [ecx], edi                          ;adaut bitul la primul dword aferent tablei
gata_1:
    
stanga_jos:                                 ;pozitia (x - 1, y - 1)
    ;conditii de existenta
    cmp ebx, 0
    je gata_2
    cmp eax, 0
    je gata_2
    push ecx                                ;salvez ecx
    lea ecx, [8 * (eax - 1) + ebx - 1]      ;calculez nr de pozitii de shiftat
    mov edi, 1
    cmp ecx, 31
    jg superior_2
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    add [ecx + 4], edi                      ;adaut bitul la al doilea dword aferent tablei
    jmp gata_2
superior_2:                                 ;pozitia se afla in jumatatea superioara a tablei
    sub ecx, 32                             ;actualizez nr de pozitii de shiftat relativ la 32 de biti
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    add [ecx], edi                          ;adaut bitul la primul dword aferent tablei
gata_2:

dreapt_sus:                                 ;pozitia (x + 1, y + 1)
    ;conditii de existenta
    cmp ebx, 7
    je gata_3
    cmp eax, 7
    je gata_3
    push ecx                                ;salvez ecx
    lea ecx, [8 * (eax + 1) + ebx + 1]      ;calculez nr de pozitii de shiftat
    mov edi, 1
    cmp ecx, 31
    jg superior_3
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    add [ecx + 4], edi                      ;adaut bitul la al doilea dword aferent tablei
    jmp gata_3
superior_3:                                 ;pozitia se afla in jumatatea superioara a tablei
    sub ecx, 32                             ;actualizez nr de pozitii de shiftat relativ la 32 de biti
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    add [ecx], edi                          ;adaut bitul la primul dword aferent tablei
gata_3:

dreapta_jos:                                ;pozitia (x - 1, y + 1)
    ;conditii de existenta
    cmp ebx, 7
    je gata_4
    cmp eax, 0
    je gata_4
    push ecx                                ;salvez ecx
    lea ecx, [8 * (eax -1) + ebx + 1]       ;calculez nr de pozitii de shiftat
    mov edi, 1
    cmp ecx, 31
    jg superior_4
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    add [ecx + 4], edi                      ;adaut bitul la al doilea dword aferent tablei
    jmp gata_4
superior_4:                                 ;pozitia se afla in jumatatea superioara a tablei
    sub ecx, 32                             ;actualizez nr de pozitii de shiftat relativ la 32 de biti
    shl edi, cl                             ;aduc bitul de 1 pe pozitia corespunzatoare
    pop ecx                                 ;restaurez ecx
    add [ecx], edi                          ;adaut bitul la primul dword aferent tablei
gata_4:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY