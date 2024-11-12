section .data
	; variable declaration
message: db  "KI-233 Pogodin", 10


section .text
	global _start	; entry point

_start:
	;program code
	mov rax, 1		; 1 - system call write
	mov rdi, 1		; 1 - stdout - destination ptr
	mov rsi, message ; message to src ptr
	mov rdx, 15		; message len 
	syscall

	mov rax, 60		; 60 - system call exit
	xor rdi, rsi	; status call 0
	syscall

