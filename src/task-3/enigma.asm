%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE

;verific si eventual mut ecx pe linia rotorului x
    cmp ebx, 0
    je rot_selected
select_rot:
    add ecx, 2 * LETTERS_COUNT
    dec ebx
    cmp ebx, 0
    jne select_rot

rot_selected:

;calculez rotirea efectiva care apare in rotor
    push edx                                ;salvez edx
    xor edx, edx
    mov ebx, LETTERS_COUNT
    div ebx
    mov eax, edx                            ;calculez noua pozitia(relativ la restul modulo 26)
    xor ebx, ebx
    cmp eax, 0
    je identic                              ;rotirea aduce rotorul in aceeasi pozitie
    mov esi, eax                            ;pastrez eax calculat

;selectez tipul de rotire
    pop edx                                 ;restaurez edx
    cmp edx, 1
    je la_dreapta

;salvez pe stiva primele x (eax) caractere de pe cele doua linii ale rotorului x
push_inceput:
    mov bl, [ecx + eax - 1]                 ;salvez de la caracterul eax - 1 catre caracterul 0
    push ebx
    mov bl, [ecx + LETTERS_COUNT + eax - 1]
    push ebx
    dec eax
    cmp eax, 0
    jne push_inceput

    mov ebx, LETTERS_COUNT
    mov eax, esi                            ;readuc eax calculat
    sub ebx, eax                            ;ebx = 26 - eax = nr caractere de shiftat

left_shift:                                 ;caracterul i devinie caracterul i + eax, cu i de la 0 la 26 - eax - 1
    push ebx                                ;salvez ebx
    mov bl, [ecx + eax]
    mov [ecx], bl                           
    mov bl, [ecx + LETTERS_COUNT + eax]
    mov [ecx + LETTERS_COUNT], bl
    pop ebx                                 ;restaurez ebx
    inc ecx
    dec ebx
    cmp ebx, 0
    jg left_shift

;aduc la final vechile eax caractere de la inceput
;ecx iese din loop-ul anterior cu pozitia de unde se incep pop ururile (26 - eax)
pop_sfarsit:
    pop ebx
    mov [ecx + LETTERS_COUNT], bl
    pop ebx
    mov [ecx], bl
    dec eax
    inc ecx
    cmp eax, 0
    jne pop_sfarsit

    jmp done

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

la_dreapta:

;salvez pe stiva ultimele eax caractere de pe cele doua linii ale rotorului
    add ecx, LETTERS_COUNT - 1
    sub ecx, eax
    add ecx, 1
    xor ebx, ebx
push_final:                                     ;salvez de la caracterul 26 - eax catre caracterul 25
    mov bl, [ecx]
    push ebx
    mov bl, [ecx + LETTERS_COUNT]
    push ebx
    dec eax
    inc ecx
    cmp eax, 0
    jne push_final

    dec ecx                 ;aduc ecx inapoi pe ultimul caracter
    mov eax, esi            ;readuc eax calculat
    mov ebx, -1
    mul ebx
    mov ebx, LETTERS_COUNT
    add ebx, eax                                ;ebx = 26 - eax = nr caractere de shiftat
               
right_shift:                                    ;caracterul i devinie caracterul i - eax, cu i de la 25 la eax
    push ebx                                    ;salvez ebx
    mov bl, [ecx + eax]
    mov [ecx], bl
    mov bl, [ecx + LETTERS_COUNT + eax]
    mov [ecx + LETTERS_COUNT], bl
    pop ebx                                     ;restaurez ebx
    dec ecx
    dec ebx
    cmp ebx, 0
    jg right_shift

;aduc la inceput vechile eax caractere de la final
;ecx iese din loop-ul anterior cu pozitia de unde se incep pop ururile (eax - 1)
pop_inceput:
    pop ebx
    mov [ecx + LETTERS_COUNT], bl
    pop ebx
    mov [ecx], bl
    inc eax
    dec ecx
    cmp eax, 0
    jne pop_inceput
    jmp done

identic:
    pop edx

done:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    ;mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov esi, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE
    
    
criptare:

;pregatire rotor 3
mut_rot3:
    push ebx                                    ;salved ebx
    mov ebx, LETTERS_COUNT
    dec ebx                                     ;contor shiftare
    xor eax, eax
    mov al, [edx + 4 * LETTERS_COUNT]           ;salvez pe stiva primul caracter de pe fiecare din cele doua linii ale rotorului 3
    push eax
    mov al, [edx + 5 * LETTERS_COUNT]
    push eax
    push edx                                    ;salved edx

shiftere_stanga_rot3:                           ;caracterul i devine caracterul i + 1, cu i de la 0 la 24
    mov al, [edx + 4 * LETTERS_COUNT + 1]
    mov [edx + 4 * LETTERS_COUNT], al
    mov al, [edx + 5 * LETTERS_COUNT + 1]
    mov [edx + 5 * LETTERS_COUNT], al
    inc edx
    dec ebx
    cmp ebx, 0
    jg shiftere_stanga_rot3
    pop edx                                     ;restaurez edx

    ;aduc la final cele doua caractere salvate
    ;edx iese din loop-ul anterior pe pozitia ultimului caracter
    pop eax
    mov [edx + 6 * LETTERS_COUNT- 1], al
    pop eax
    mov [edx + 5 * LETTERS_COUNT - 1], al
    pop ebx                                     ;restaurez ebx

;incrementez keys[2]
    xor eax, eax
    push edi                                    ;salvez edi
    xor edi, edi
    mov al, [ebx + 2]                           ;aduc in al keys[2]
    push eax                                    ;salvez keys[2] curent
    inc al
    cmp al, 90
    jle fara_modul  
    sub al, 26                                  ;daca incrementez 'Z', acum devine 'A'
fara_modul:         
    mov [ebx + 2], al

    ;verific conditie double stepping:  daca key[1] = notch[1] => rotire in toti cei trei rotori
    mov al, [ecx + 1]
    cmp byte[ebx + 1], al
    je double_stepping
    pop edi                                     ;aduc keys[2] vechi
    mov al, [ecx + 2]
    cmp edi, eax
    pop edi                                     ;restaurez edi
    je mut_rot2                                 ;keys[2] vechi = notch[2] => mutare in rotorul 2   
    jne setat

double_stepping:
    pop eax                                     ;restaurez eax 
    pop edi                                     ;restaurez edi

;pregatire rotor 2
mut_rot2:
    push ebx                                    ;salved ebx
    mov ebx, LETTERS_COUNT
    dec ebx                                     ;contor shiftare
    xor eax, eax
    mov al, [edx + 2 * LETTERS_COUNT]           ;salvez pe stiva primul caracter de pe fiecare din cele doua linii ale rotorului 2
    push eax
    mov al, [edx + 3 * LETTERS_COUNT]
    push eax
    push edx                                    ;salved edx

shiftere_stanga_rot2:                           ;caracterul i devine caracterul i + 1, cu i de la 0 la 24
    mov al, [edx + 2 * LETTERS_COUNT + 1]   
    mov [edx + 2 * LETTERS_COUNT], al
    mov al, [edx + 3 * LETTERS_COUNT + 1]
    mov [edx + 3 * LETTERS_COUNT], al
    inc edx
    dec ebx
    cmp ebx, 0
    jg shiftere_stanga_rot2
    pop edx                                     ;restaurez edx

    ;aduc la final cele doua caractere salvate
    ;edx iese din loop-ul anterior pe pozitia ultimului caracter
    pop eax
    mov [edx + 4 * LETTERS_COUNT- 1], al
    pop eax
    mov [edx + 3 * LETTERS_COUNT - 1], al
    pop ebx                                     ;restaurez ebx

;incrementez keys[1]
    xor eax, eax
    push edi                                    ;salvez edi
    xor edi, edi
    mov al, [ebx + 1]                           ;aduc in al keys[1]
    push eax                                    ;salvez keys[1] curent
    inc al
    cmp al, 90
    jle fara_modul_rot2
    sub al, 26                                  ;daca incrementez 'Z', acum devine 'A'
fara_modul_rot2:
    mov [ebx + 1], al
    pop edi                                     ;aduc keys[1] vechi
    mov al, [ecx + 1]
    cmp edi, eax
    pop edi                                     ;restaurez edi
    jne setat                                   ;keys[1] vechi = notch[1] => mutare in rotorul 1 

;pregatire rotor 1
mut_rot1:   
    push ebx                                    ;salved ebx
    mov ebx, LETTERS_COUNT
    dec ebx                                     ;contor shiftare 
    xor eax, eax
    mov al, [edx]       
    push eax
    mov al, [edx + LETTERS_COUNT]               ;salvez pe stiva primul caracter de pe fiecare din cele doua linii ale rotorului 1
    push eax
    push edx                                    ;salved edx

shiftere_stanga_rot1:                           ;caracterul i devine caracterul i + 1, cu i de la 0 la 24
    mov al, [edx + 1]
    mov [edx], al
    mov al, [edx + LETTERS_COUNT + 1]       
    mov [edx + LETTERS_COUNT], al
    inc edx
    dec ebx
    cmp ebx, 0
    jg shiftere_stanga_rot1
    pop edx                                     ;restaurez edx

    ;aduc la final cele doua caractere salvate
    ;edx iese din loop-ul anterior pe pozitia ultimului caracter
    pop eax
    mov [edx + 2 * LETTERS_COUNT- 1], al
    pop eax
    mov [edx + LETTERS_COUNT - 1], al
    pop ebx                                     ;restaurez ebx

    ;incrementez keys[0]
    mov al, [ebx]                               ;aduc in al keys[0]
    inc al
    cmp al, 90
    jle fara_modul_rot1
    sub al, 26                                  ;daca incrementez 'Z', acum devine 'A'
fara_modul_rot1:
    mov [ebx], al
    
;lin 0-1: rotor 1
;lin 2-3: rotor 2
;lin 4-5: rotor 3
;lin 6-7: reflector
;lin 8-9: plugboard
;ordinea in care se traverseaza liniile:(initial) 9 -> 8 -> 5 -> 4 -> 3 -> 2-> 1 -> 0 -> 7 -> 6 -> 0 -(reflectare)-> 1 -> 2 -> 3 -> 4 -> 5 -> 8 -> 9 (codificat)

setat:                                          ;incep procesul de criptare
    push ecx                                    ;salvez ecx
    push ebx                                    ;salvez ebx
    xor eax, eax
    mov al, [esi]                               ;citesc un caracter
    sub al, 65                                  ;aflu pe ce pozitie e in linia 9 (65 = 'A')
    mov al, [edx + 9 * LETTERS_COUNT + eax]     ;salvez caracterul de pe pozitia calculata

    ;aflu pozitia lui al in lin 8
    xor ebx, ebx                                ;contor coloana
caut_in_lin8:
    mov cl, [edx + 8 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al                                  ;fiecare lin e o permutare a literelor din alfabet, deci in final trebuie sa existe
    jne caut_in_lin8
    sub ebx, 1                                  ;pozitia lui al in lin 8
    mov al, [edx + 5 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 5

    ;aflu pozitia lui al in lin 4
    xor ebx, ebx                                ;contor coloana
caut_in_lin4:
    mov cl, [edx + 4 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin4
    sub ebx, 1                                  ;pozitia lui al in lin 4
    mov al, [edx + 3 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 3

    ;aflu pozitia lui al in lin 2
    xor ebx, ebx
caut_in_lin2:
    mov cl, [edx + 2 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin2
    sub ebx, 1                                  ;pozitia lui al in lin 1
    mov al, [edx + 1 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 1

    ;aflu pozitia lui al in lin 0
    xor ebx, ebx
caut_in_lin0:
    mov cl, [edx + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin0
    sub ebx, 1                                  ;pozitia lui al in lin 0
    mov al, [edx + 7 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 7(am ajuns la reflector)

    ;aflu pozitia lui al in lin 6
    xor ebx, ebx
caut_in_lin6:
    mov cl, [edx + 6 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al
    jne caut_in_lin6
    sub ebx, 1                                  ;pozitia lui al in lin 6
    mov al, [edx + ebx]                         ;aflu caracterul aflat pe aceeasi coloana din lin 0

    ;aflu pozitia lui al in lin 1 (incep drumul de la reflector catre iesire)
    xor ebx, ebx
caut_in_lin1:
    mov cl, [edx + LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin1
    sub ebx, 1                                  ;pozitia lui al in lin 1
    mov al, [edx + 2 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 2

    ;aflu pozitia lui al in lin 3
    xor ebx, ebx
caut_in_lin3:
    mov cl, [edx + 3 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin3
    sub ebx, 1                                  ;pozitia lui al in lin 3
    mov al, [edx + 4 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 4

    ;aflu pozitia lui al in lin 5
    xor ebx, ebx
caut_in_lin5:
    mov cl, [edx + 5 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin5
    sub ebx, 1                                  ;pozitia lui al in lin 5
    mov al, [edx + 8 * LETTERS_COUNT + ebx]     ;aflu caracterul aflat pe aceeasi coloana din lin 8

    ;aflu pozitia lui al in lin 9
    xor ebx, ebx
caut_in_lin9:
    mov cl, [edx + 9 * LETTERS_COUNT + ebx]
    inc ebx
    cmp cl, al          
    jne caut_in_lin9
    sub ebx, 1                                  ;pozitia lui al in alfabet

gata:
    add bl, 65                                  ;caracterul criptat
    mov [edi], bl                               ;salvez caracterul in enc
    inc edi
    inc esi
    pop ebx                                     ;restaurez ebx
    pop ecx                                     ;restaurez ecx
    ;verific daca am ajuns la finalul stringului care trebuie criptat
    mov eax, esi
    sub eax, [ebp + 8]                          ;diferenta dintre adresa urmatorului caracter care se va citi si inceputul stringului de criptat
    cmp eax, [len_plain]
    jne criptare                                ;la egalitate, s-ar iesi din stringul de criptat

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY