.global main

fibonacci:
        push    %rbp
        mov     %rsp, %rbp
        push    %rbx
        sub     $24, %rsp
        movl    %edi, -20(%rbp)
        cmpl    $0, -20(%rbp)
        jne     .L2
        movl    $0, %eax
        jmp     .L3
.L2:
        cmpl    $1, -20(%rbp)
        jne     .L4
        movl    $1, %eax
        jmp     .L3
.L4:
        movl    -20(%rbp), %eax
        subl    $1, %eax
        movl    %eax, %edi
        call    fibonacci
        movl    %eax, %ebx
        movl    -20(%rbp), %eax
        subl    $2, %eax
        movl    %eax, %edi
        call    fibonacci
        addl    %ebx, %eax
.L3:
        mov     -8(%rbp), %rbx
        leave
        ret

.LC0:
        .string "Enter the Fibonacci number you want to calculate: "
.LC1:
        .string "%d"
.LC2:
        .string "Please enter a number between 0 and 93."
.LC3:
        .string "The %dth Fibonacci number is %llu\n"

main:
        push    %rbp
        mov     %rsp, %rbp
        sub     $16, %rsp
        mov     $.LC0, %edi
        mov     $0, %eax
        call    printf
        lea     -4(%rbp), %rax
        mov     %rax, %rsi
        mov     $.LC1, %edi
        mov     $0, %eax
        call    __isoc99_scanf
        mov     -4(%rbp), %eax
        test    %eax, %eax
        js      .L6
        cmpl    $93, %eax
        jle     .L7
.L6:
        mov     $.LC2, %edi
        call    puts
        mov     $1, %eax
        jmp     .L9
.L7:
        mov     -4(%rbp), %eax
        mov     %eax, %edi
        call    fibonacci
        mov     %rax, %rdx
        mov     -4(%rbp), %eax
        mov     %eax, %esi
        mov     $.LC3, %edi
        mov     $0, %eax
        call    printf
        mov     $0, %eax
.L9:
        leave
        ret

.section .note.GNU-stack,"",@progbits

