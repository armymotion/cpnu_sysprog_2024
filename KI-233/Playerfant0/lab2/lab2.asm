extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .data
message db 'KI-233 Fil`', 0Ah, 0

section .bss
written resq 1

section .text
global main
main:
    ; Отримуємо дескриптор стандартного виводу
    mov rcx, -11 ; STD_OUTPUT_HANDLE
    call GetStdHandle
    ; Зберігаємо дескриптор виводу
    mov r12, rax

    ; Підготовка аргументів для WriteConsoleA
    mov rcx, r12           ; hConsoleOutput
    lea rdx, [message]      ; lpBuffer
    mov r8, 11               ; nNumberOfCharsToWrite
    lea r9, [written]       ; lpNumberOfCharsWritten
    xor eax, eax            ; Обнуляємо верхню частину rax
    push rax                ; lpReserved (must be 0)
    sub rsp, 32             ; Виділяємо 32 байти тіньового простору
    
    ; Виводимо повідомлення
    call WriteConsoleA
    ; Відновлюємо стек
    add rsp, 40             ; 32 + 8 (для lpReserved)

    ; Завершуємо програму
    xor ecx, ecx           ; exit code 0
    call ExitProcess
