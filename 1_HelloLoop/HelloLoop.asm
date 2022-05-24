; E  Tovell
; 2022-05-19
; Prints Hello World 10 times.

section .text	;Code Section
	global _start	;Sets startpoint
_start: 
	mov r15, 0xA 	;set r15 to 10 for loop counter

print_loop:
	mov rax, 0x1			;set Syscall to "write"
	;syscall args
	mov rdi, 0x1 			;use stdout as fd
	mov rsi, message		;use message as buffer
	mov rdx, message_length	;use message length as stringlen
	syscall					;call syscall

	dec r15			;Decrement r15, compare it to 0
	jnz print_loop	;If r15 wasnt equal to 0, jump back to print_loop. Otherwise, continue.

return:
	mov rax, 0x3c	;syscall to return
	mov rdi, 0x0	;return value set to 0
	syscall			;call syscall

section .data	;Variable Section
	message: db "Hello World!", 0xA	;makes string called message. 0xA is newline character
	message_length equ $-message	;creates message length variable
