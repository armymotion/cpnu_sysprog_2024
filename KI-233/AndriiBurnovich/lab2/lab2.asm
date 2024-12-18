bits 64

extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .data
    message db 'KI-233 Burnovich', 0Ah, 0
    message_len equ $ - message  ; Длина сообщения

section .bss
    written resq 1

section .text
global main

main:
    ; Получаем дескриптор стандартного вывода
    mov rcx, -11             ; STD_OUTPUT_HANDLE
    call GetStdHandle        ; Вызов функции GetStdHandle
    mov r12, rax             ; Сохраняем дескриптор в r12

    ; Подготовка параметров для WriteConsoleA
    mov rcx, r12             ; hConsoleOutput
    lea rdx, [rel message]   ; lpBuffer (используем rel для 64-битной адресации)
    mov r8, message_len      ; nNumberOfCharsToWrite
    lea r9, [rel written]    ; lpNumberOfCharsWritten (используем rel для 64-битной адресации)
    sub rsp, 32              ; Shadow space для вызова функции

    ; Вызов WriteConsoleA
    call WriteConsoleA

    ; Восстанавливаем стек
    add rsp, 32

    ; Выход из программы
    xor ecx, ecx             ; Код возврата 0
    call ExitProcess         ; Вызов функции завершения
