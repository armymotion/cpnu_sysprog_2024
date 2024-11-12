extern ExitProcess
extern GetStdHandle
extern WriteConsoleA
extern _getch  ; Підключення функції для очікування клавіші

section .data
    message db 'KI-233 Borovik', 0Ah, 0    

section .bss
    written resq 1                           

section .text
global main

main:
    ; Отримуємо дескриптор стандартного виводу
    mov rcx, -11                          ; STD_OUTPUT_HANDLE
    call GetStdHandle

    ; Зберігаємо дескриптор виводу
    mov r12, rax                          ; Зберігаємо дескриптор у r12

    ; Підготовка параметрів для функції WriteConsoleA
    mov rcx, r12                          ; hConsoleOutput
    lea rdx, [message]                    ; lpBuffer - адреса повідомлення
    mov r8, 18                            ; nNumberOfCharsToWrite - кількість символів
    lea r9, [written]                     ; lpNumberOfCharsWritten - записуємо кількість записаних символів
    xor eax, eax                          ; lpReserved (має бути 0)

    ; Виклик WriteConsoleA для виведення повідомлення
    sub rsp, 32                   ; Виділяємо 32 байти тіньового простору
    call WriteConsoleA
    add rsp, 32                   ; Відновлюємо стек
    
    ; Очікування натискання клавіші перед завершенням
    call _getch

    ; Завершення програми
    xor ecx, ecx                  ; Код завершення програми 0
    call ExitProcess
