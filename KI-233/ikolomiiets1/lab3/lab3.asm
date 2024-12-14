section .data
    msg_input db "Enter the Fibonacci number you want to calculate (0-93): ", 0
    msg_invalid db "Please enter a number between 0 and 93.", 0
    msg_result db "The %dth Fibonacci number is %llu", 10, 0

section .bss
    num resd 1

section .text
    global _start
    extern printf, scanf, puts 

fibonacci:
    push    rbp
    mov     rbp, rsp
    push    rbx
    sub     rsp, 24
    mov     DWORD [rbp-20], edi
    cmp     DWORD [rbp-20], 0
    jne     .L2
    mov     eax, 0
    jmp     .L3
.L2:
    cmp     DWORD [rbp-20], 1
    jne     .L4
    mov     eax, 1
    jmp     .L3
.L4:
    mov     eax, DWORD [rbp-20]
    sub     eax, 1
    mov     edi, eax
    call    fibonacci
    mov     rbx, rax
    mov     eax, DWORD [rbp-20]
    sub     eax, 2
    mov     edi, eax
    call    fibonacci
    add     rax, rbx
.L3:
    mov     rbx, QWORD [rbp-8]
    leave
    ret

_start:
    ; Print input prompt
    mov     rdi, msg_input
    xor     eax, eax
    call    printf

    ; Scan input
    lea     rsi, [num]
    mov     rdi, msg_invalid
    xor     eax, eax
    call    scanf

    ; Check input range
    mov     eax, [num]
    test    eax, eax
    js      .invalid
    cmp     eax, 93
    jg      .invalid

    ; Calculate Fibonacci
    mov     edi, eax
    call    fibonacci

    ; Print result
    mov     rdx, rax
    mov     eax, [num]
    mov     esi, eax
    mov     rdi, msg_result
    xor     eax, eax
    call    printf

    ; Exit
    mov     eax, 60       
    xor     edi, edi     
    syscall

.invalid:
    mov     rdi, msg_invalid
    call    puts           
    mov     eax, 60
    mov     edi, 1
    syscall
