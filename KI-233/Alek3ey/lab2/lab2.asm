extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .data
    message db 'KI-233 Alek3ey', 0Ah, 0

section .bss
    written resq 1

section .text
    global main

main:
    ; Отримуємо дескриптор стандартного виводу
    mov rcx, -11
    call GetStdHandle
    mov r12, rax

    ; Підготовка параметрів для WriteConsoleA
    mov rcx, r12
    lea rdx, [message]
    mov r8, 20
    lea r9, [written]
    xor eax, eax
    push rax
    sub rsp, 32
    call WriteConsoleA

    ; Відновлюємо стек і виходимо з програми
    add rsp, 40
    xor ecx, ecx
    call ExitProcess