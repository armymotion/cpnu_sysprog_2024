BITS 64

extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .data
message db 'KI-231 BALOVA', 0Ah, 0

section .bss
written resq 1

section .text
global main

main:
    mov rcx, -11
    call GetStdHandle
    mov r12, rax
    mov rcx, r12
    lea rdx, [message]
    mov r8, 14                  
    lea r9, [written]
    xor eax, eax
    push rax
    sub rsp, 32
    call WriteConsoleA
    add rsp, 40
    xor ecx, ecx
    call ExitProcess
