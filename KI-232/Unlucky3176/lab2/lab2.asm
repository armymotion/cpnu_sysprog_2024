extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .data
    message db 'KI-232 Dyuka', 0Ah, 0 ; Повідомлення для виводу

section .bss
    written resq 1 ; Змінна для кількості записаних символів

section .text
    global main

main:
    ; Отримуємо дескриптор стандартного виводу
    mov rcx, -11 ; STD_OUTPUT_HANDLE
    call GetStdHandle

    ; Зберігаємо дескриптор виводу
    mov r12, rax ; Зберігаємо результат GetStdHandle в r12

    ; Підготовка параметрів для WriteConsoleA
    mov rcx, r12 ; hConsoleOutput
    lea rdx, [message] ; lpBuffer
    mov r8, 12 ; nNumberOfCharsToWrite (враховуємо символ нового рядка)
    lea r9, [written] ; lpNumberOfCharsWritten
    sub rsp, 32 ; Виділяємо 32 байти тіньового простору

    ; Виводимо повідомлення
    call WriteConsoleA

    ; Відновлюємо стек
    add rsp, 32

    ; Вихід з програми
    xor ecx, ecx ; Код виходу 0
    call ExitProcess