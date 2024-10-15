.global _start

.section __TEXT,__text
_start:
    # Підготовка до системного виклику write
    movq $0x2000004, %rax     # Номер системного виклику write для macOS (x86_64)
    movq $1, %rdi             # Файловий дескриптор (1 = stdout)
    leaq message(%rip), %rsi  # Адреса повідомлення
    movq $message_len, %rdx   # Довжина повідомлення
    syscall                   # Виклик системного виклику

    # Підготовка до системного виклику exit
    movq $0x2000001, %rax     # Номер системного виклику exit для macOS (x86_64)
    xorq %rdi, %rdi           # Статус виходу 0
    syscall                   # Виклик системного виклику

.section __DATA,__data
message:
    .ascii "KI-231 DOROPII\n"         # Рядок з новим рядком
message_len = . - message     # Обчислюємо довжину повідомлення
