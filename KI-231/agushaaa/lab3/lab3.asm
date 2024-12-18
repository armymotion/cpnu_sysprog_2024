section .data
prompt db "Enter the Fibonacci number you want to calculate (1-93): ", 0
  format_input db "%d", 0
  out_of_range_msg db "Please enter a number between 1 and 93.", 10, 0
  format_output db "The %dth Fibonacci number is %llu", 10, 0
section .bss
  n resd 1 ; Переменная для хранения введенного числа
section .text
  extern printf, puts, __isoc99_scanf
  global main
; Функция вычисления числа Фибоначчи
fibonacci:
  ; Вход: edi = n
  ; Выход: rax = Fibonacci(n)
  push rbp
  mov rbp, rsp

  mov ecx, edi      ; ecx = n
  cmp ecx, 1
  jle .return_one   ; если n <= 1, возвращаем 1
  ; Инициализируем начальные значения для цикла
  mov rax, 1 ; fib(1)
  xor rbx, rbx ; fib(0) = 0
  dec ecx ; цикл выполняется (n - 1) раз
.loop:
  ; Следующее число Фибоначчи
  mov rdx, rax ; сохраняем текущее значение rax
  add rax, rbx ; rax = rax + rbx
  mov rbx, rdx ; rbx = предыдущее значение rax
  dec ecx
  jnz .loop
  jmp .done
.return_one:
  mov rax, 1 ; Возвращаем 1
.done:
  mov rsp, rbp
  pop rbp
  ret
main:
  push rbp
  mov rbp, rsp
  sub rsp, 16
  ; Вывод приглашения
  mov edi, prompt
  xor eax, eax
  call printf
  ; Чтение числа n
  lea rax, [n]
  mov rsi, rax
  mov edi, format_input
  xor eax, eax
  call __isoc99_scanf
  ; Проверка, что число в пределах 1-93
  mov eax, [n]
  cmp eax, 1
  jl error ; если n < 1, переход к error
  cmp eax, 93
  jg error ; если n > 93, переход к error
  ; Уменьшаем значение на 1 перед передачей в функцию fibonacci
  dec eax
  mov edi, eax
  call fibonacci
  mov rdx, rax ; сохраняем результат в rdx для printf
  ; Вывод результата (теперь отображаем (n-1) для сообщения)
  mov eax, [n]
  dec eax ; уменьшаем для корректного отображения индекса в выводе
  mov esi, eax
  mov edi, format_output
  xor eax, eax
  call printf
  ; Завершаем программу
  ret

error:
  ; Сообщение об ошибке
  mov edi, out_of_range_msg
  call puts
  mov eax, 1
  ret
  section .note.GNU-stack
  ; empty section
