default rel ; Вказує використовувати відносні адреси для 64-бітної архітектури
; Для 64-бітної версії Windows
extern ExitProcess
extern GetStdHandle
extern WriteConsoleA
section .data
message db 'KI-232 Reshetnyk', 0Ah, 0 ; Зберігаємо текст, що потрібно вивести
section .bss
written resq 1 ; Резервуємо простір для кількості виведених символів
section .text
global main 
main:
; Отримуємо дескриптор стандартного виводу
mov rcx, -11 ; STD_OUTPUT_HANDLE
call GetStdHandle
mov r12, rax ; Зберігаємо дескриптор виводу 
; Підготовка параметрів для WriteConsoleA
mov rcx, r12 ; hConsoleOutput
lea rdx, [message] ; lpBuffer
mov r8, 20 ; nNumberOfCharsToWrite (додайте 1 для нового рядка)
lea r9, [written] ; lpNumberOfCharsWritten
xor rax, rax ; Обнуляємо регістр rax
push rax ; lpReserved (must be 0)
sub rsp, 32 ; Виділяємо 32 байти тіньового простору
; Виводимо повідомлення
call WriteConsoleA
; Відновлюємо стек
add rsp, 40 ; 32 + 8 (для lpReserved)
; Виходимо з програми
xor rcx, rcx ; exit code 0
call ExitProcess