; E  Tovell
; 2022-05-19
; Prints hello world to console. Mainly to learn basic system calls and variables

section .text	;Code Section
	global _start	;Sets startpoint
_start: 
	mov rax, 0x1			;set Syscall to "write"
	;syscall args
	mov rdi, 1 				;use stdout as fd
	mov rsi, message		;use message as buffer
	mov rdx, message_length	;use message length as stringlen
	syscall					;call syscall

	mov rax, 0x3c	;syscall to return
	mov rdi, 0x0	;return value set to 0
	syscall			;call syscall

section .data	;Variable Section
	message: db "Hello World!", 0xA	;makes string called message. 0xA is newline character
	message_length equ $-message	;creates message length variable
