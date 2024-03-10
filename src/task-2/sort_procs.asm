%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    mov ecx, 0          ; i = index for1
    mov edx, 0          ; j = index for2
    mov esi, [ebp + 8]  ; processes

for1:
    mov edx, 0                              ;j = 0
for2:
    mov bl, byte[esi + edx  + 2]            ;aduc in bl procs[j].prio
    cmp bl, [esi + edx + proc_size + 2]     ;comparar cu procs[j + 1].prio
    jl end_swap                             ;if (procs[j].prio < procs[j + 1].prio), sunt deja sortate
    jne swap                                ;if (procs[j].prio != procs[j + 1].prio), se face swap
                                            ;else, se verifica si campul time
    mov bx, word[esi + edx  + 3]            ;aduc in bl procs[j].time
    cmp bx, [esi + edx + proc_size + 3]     ;comparar cu procs[j + 1].time
    jl end_swap                             ;if (procs[j].time < procs[j + 1].time), sunt deja sortate
    jne swap                                ;else, se verifica si campul pid

    mov bx, word[esi + edx]                 ;aduc in bl procs[j].pid
    cmp bx, [esi + edx + proc_size]         ;comparar cu procs[j + 1].pid
    jl end_swap                             ;if (procs[j].pid < procs[j + 1].pid), sunt deja sortate

swap:                                       
    mov bx, [esi + edx]                     ;aduc in bl pe procs[j].pid
    xchg [esi + edx + proc_size], bx        ;procs[j + 1].pid = bl si bl = procs[j + 1].pid
    mov [esi + edx], bx                     ;procs[j].pid = bl

    mov bl, byte[esi + edx  + 2]            
    xchg [esi + edx + proc_size + 2], bl    ;analog pentru campul prio
    mov [esi + edx + 2], bl

    mov bl, [esi + edx + 3]
    xchg [esi + edx + proc_size + 3], bl    ;analog pentru campul time
    mov [esi + edx + 3], bl
    jmp end_swap

end_swap:
    add edx, proc_size      ;j ajunge pe urmatorul element din procs
    push edx                ;salvez edx 
    sub eax , 1             
    sub eax, ecx
    mov ebx, proc_size
    mul ebx
    mov ebx, eax            ;ebx = (len - 1 - i) * proc_size
    pop edx                 ;restaurez edx
    mov eax, [ebp + 12]     ;repar eax (len)
    cmp edx, ebx            
    
    jge prep_for1           ; if (j >= ebx), se iese din for2
    jmp for2

prep_for1:
    add ecx, 1              ;i++
    mov ebx, [ebp + 12]     
    sub ebx, 1
    cmp ecx, ebx
    jl for1                 ;if(i < len - 1), se incepe din nou cu sortatul(dar acum se verifica cu un element mai putin de la final) 

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY