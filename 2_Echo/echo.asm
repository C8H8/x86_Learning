; E Tovell
; 2022-05-24
; Echos user input. (up to 64 bytes, or whatever you put as the input reserved size)

section .text	;Code Section
	global _start	;Set Startpoint
_start:
	mov rax, 0x0	;"Read" syscall flag
	mov rdi, 0x0	;"stdin" fd
	mov rsi, input	;use input bytes for buffer
	mov rdx, 64		;use size of input bytes as count
	syscall

	mov rax, 0x1	;"Write" syscall flag
	mov rdi, 0x1	;"stdout" fd
	mov rsi, input	;use inputted text as buffer
	mov rdx, 64		;Max length of inputted text
	syscall

	mov rax, 0x3c	;"exit" syscall flag
	mov rdi, 0x0	;set return value to 0
	syscall
	

section .data	;statics

section .bss	;reserved bytes
	input resb 64	;reserve 64 bytes

	
