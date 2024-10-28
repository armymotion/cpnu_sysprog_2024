global _start

section .text
_start:
    ; Підготовка до системного виклику write
    mov rax, 1          ; Номер системного виклику write
    mov rdi, 1          ; Файловий дескриптор (1 = stdout)
    mov rsi, message    ; Адреса повідомлення
    mov rdx, 16          ; Довжина повідомлення

    syscall             ; Виконати системний виклик

    ; Підготовка до системного виклику exit
    mov rax, 60         ; Номер системного виклику exit
    xor rdi, rdi        ; Статус виходу 0

    syscall             ; Виконати системний виклик

section .data
message db "KI-231 Zabarnyi", 10  ; де "Zabarnyi" - додане прізвище (\n)


