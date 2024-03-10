%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

;calculez shifarea efectiva care se produce (restul modulo 26)
    mov eax, edx
    xor edx, edx
    mov ebx, 26
    div ebx                         ;restul impartirii(step-ul efectiv) ramana in edx
    cmp edx, 0
    xor eax, eax

while:
    mov al, [esi]                   ;citesc un caracter
    add al, dl                      
    cmp al, 90
    jbe no_sub
    sub al, 26                      ;daca prin shiftare se depaseste 'Z', se revine inapoi in cadrul alfabetului 
no_sub:    
    mov [edi], al                   ;scriu caracterul shiftat
    inc esi                         ;trec la urmatorul caracter
    inc edi
    loop while                      ;ecx scade

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
