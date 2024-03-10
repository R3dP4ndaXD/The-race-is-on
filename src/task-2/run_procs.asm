%include "../include/io.mac"

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

for_insumare:
    push ebx                                    ;salvez ebx
    xor ebx, ebx                                
    mov bl, [ecx + 2]                           ;aduc in bl campul prio al unui element din procs
    mov dx, [ecx + 3]                           ;aduc in dx campul time al unui element din procs
    add [prio_result + 4 *(ebx - 1)], dword 1   ;cresc numarul elementelor din prio_result cu aceeasi prioritate cu a elementului analizat
    add [time_result + 4 *(ebx - 1)], dx        ;adun dx in prio_result pe pozitia aferenta prioritatii elementului analizat
    pop ebx                                     ;restaurez ebx
    add ecx, proc_size                          ;trec la urmatorul element din procs
    dec ebx
    cmp ebx, 0
    jg for_insumare

xor ebx, ebx                                    ;counter pentru parcurgerea vectorilor time_result si prio_result
mov ecx, [ebp + 16]                             ;refac ecx = procs

for_impartiri:
    xor edx, edx
    push ebx                                    ;salvez ebx
    mov eax, [time_result + 4*ebx]              ;iau numaratorul din time_result
    mov ebx, [prio_result + 4*ebx]              ;iau numitorul din prio_result
    cmp ebx, 0                                  
    je no_divide                                ;daca nu am elemente cu o anumita prioritate in vectorul procs(atat numaratorul cat si numitorul vor fi ambele zero)
    div ebx                                     
no_divide:     
    mov [ecx], ax                               ;salvez catul in avg_out
    mov [ecx + 2], dx                           ;salvez restul in avg_out
    pop ebx                                     ;restaurez ebx
    add ecx, 4                                  ;trec la urmatoarea pozitie din vectorul avg_out
    inc ebx                                     
    cmp ebx, 5
    jl for_impartiri

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY