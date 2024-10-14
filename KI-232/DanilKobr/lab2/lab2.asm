; Для 64-бітної версії Windows
extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .data
message db 'KI-232 Kobrin', 0Ah, 0

section .bss
written resq 1

section .text
global main

main:
    ; Отримуємо дескриптор стандартного виводу
    mov rcx, -11          ; STD_OUTPUT_HANDLE
    call GetStdHandle

    ; Зберігаємо дескриптор виводу
    mov r12, rax          ; Зберігаємо результат

    ; Підготовка параметрів для WriteConsoleA
    mov rcx, r12          ; hConsoleOutput
    lea rdx, [rel message] ; lpBuffer
    mov r8, 15             ; nNumberOfCharsToWrite
    lea r9, [rel written] ; lpNumberOfCharsWritten
    xor rax, rax         ; Обнуляємо rax

    sub rsp, 40           ; Виділяємо 32 байти для shadow space + 8 для резервного
    push rax              ; lpReserved (must be 0)

    ; Виводимо повідомлення
    call WriteConsoleA

    ; Відновлюємо стек
    add rsp, 40           ; 32 + 8 (для lpReserved)

    ; Виходимо з програми
    xor ecx, ecx         ; exit code 0
    call ExitProcess


