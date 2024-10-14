global _start

section .text
_start:
    ; Підготовка до системного виклику write
    mov rax, 1          ; Номер системного виклику write
    mov rdi, 1          ; Файловий дескриптор (1 = stdout)
    mov rsi, message    ; Адреса повідомлення
    mov rdx, 15          ; Довжина повідомлення (6 символов + 1 символ новой строки)
    syscall             ; Виклик системного виклику

    ; Підготовка до системного виклику exit
    mov rax, 60         ; Номер системного виклику exit
    xor rdi, rdi        ; Статус виходу 0
    syscall             ; Виклик системного виклику

section .data
message: db "KI-232 Verevkin", 10  ; Сообщение "KI-232" с символом новой строки

section .note.GNU-stack noalloc noexec nowrite progbits

