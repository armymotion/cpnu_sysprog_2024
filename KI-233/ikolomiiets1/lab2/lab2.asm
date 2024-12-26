; Для 64-бітної версії Windows
extern ExitProcess
extern GetStdHandle
extern WriteConsoleA
section .data
message db 'KI-000', 0Ah, 0
section .bss
written resq 1
section .text
global main
main:
; Отримуємо дескриптор стандартного виводу
mov rcx, -11 ; STD_OUTPUT_HANDLE
call GetStdHandle
; Зберігаємо дескриптор виводу
mov r12, rax ; Зберігаємо результат
GetStdHandle в r12
; Підготовка параметрів для WriteConsoleA
mov rcx, r12 ; hConsoleOutput
lea rdx, [message] ; lpBuffer
mov r8, 5 ; nNumberOfCharsToWrite
lea r9, [written] ; lpNumberOfCharsWritten
xor eax, eax ; Обнуляємо верхню частину
rax
push rax ; lpReserved (must be 0)
sub rsp, 32 ; Виділяємо 32 байти
тіньового простору
; Виводимо повідомлення
call WriteConsoleA
; Відновлюємо стек
add rsp, 40 ; 32 + 8 (для lpReserved)
; Виходимо з програми
xor ecx, ecx ; exit code 0
call ExitProcess