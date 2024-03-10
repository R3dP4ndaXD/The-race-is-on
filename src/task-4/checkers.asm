
section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    ;offsetul elementului de pe pozitiei (x,y): 8 * x + y 

stanga_sus:                             ;pozitia (x - 1, y + 1)  
    ;verific conditii de existenta
    cmp eax, 0
    je gata_1
    cmp ebx, 7
    je gata_1
    push ecx                            ;salvez ecx
    add ecx, ebx                        ;selectez coloana
    add ecx, 1                          
    inc byte[ecx + 8 * (eax - 1)]       ;selectez si linia si marchez pozitia
    pop ecx                             ;restaurez ecx
gata_1:

stanga_jos:                             ;pozitia (x - 1, y - 1)
    ;verific conditii de existenta
    cmp eax, 0
    je gata_2
    cmp ebx, 0
    je gata_2
    push ecx                            ;salvez ecx
    add ecx, ebx                        ;selectez coloana
    sub ecx, 1          
    inc byte[ecx + 8 *(eax - 1)]        ;selectez si linia si marchez pozitia
    pop ecx                             ;restaurez ecx
gata_2:

dreapta_sus:                            ;pozitia (x + 1, y + 1)
    ;verific conditii de existenta
    cmp eax, 7
    je gata_3
    cmp ebx, 7
    je gata_3
    push ecx                            ;salvez ecx
    add ecx, ebx                        ;selectez coloana
    add ecx, 1 
    inc byte[ecx + 8 *(eax + 1)]        ;selectez si linia si marchez pozitia
    pop ecx                             ;restaurez ecx
gata_3:

dreapta_jos:                            ;pozitia (x + 1, y - 1)
    ;verific conditii de existenta
    cmp eax, 7
    je gata_4
    cmp ebx, 0
    je gata_4
    push ecx                            ;salvez ecx
    add ecx, ebx                        ;selectez coloana
    sub ecx, 1
    inc byte[ecx + 8 *(eax + 1)]        ;selectez si linia si marchez pozitia
    pop ecx                             ;restaurez ecx
gata_4:
   
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY