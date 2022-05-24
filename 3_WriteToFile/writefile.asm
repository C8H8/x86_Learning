; E Tovell
; 2022-05-24
; Takes in filename, and single-line text input, writes to file.

section .text
	global _start
_start:

	mov rax, 0x1	;"Write" syscall flag
	mov rdi, 0x1	;"stdout" fd
	mov rsi, fname_message	;use inputted text as buffer
	mov rdx, 11		;length of fname_message
	syscall

	mov rax, 0x0	;"Read" syscall flag
	mov rdi, 0x0	;"stdin" fd
	mov rsi, fname	;use fname bytes for buffer
	mov rdx, 64		;use size of fname bytes as count
	syscall

	mov byte [rsi + rax - 1], 0 ;remove newline character at end of fname input
	;Done by taking the file pointer in rsi, moving it over by the returned length of the string in rax, subtracting 1 to get to the newline character, and replacing it with 0x0 (the end character)

	mov rax, 0x1	;"Write" syscall flag
	mov rdi, 0x1	;"stdout" fd
	mov rsi, input_message	;use input_message as buffer
	mov rdx, 8		;length of input_message
	syscall

	mov rax, 0x0	;"Read" syscall flag
	mov rdi, 0x0	;"stdin" fd
	mov rsi, input	;use input bytes for buffer
	mov rdx, 1024	;use max size of input as buffer size
	syscall

	mov rax, 0x2	;"Open" syscall flag
	mov rdi, fname 	;uses fname as filename
	mov rsi, 102o	;use 0_CREAT flag with 0_RDWR (64+2 -> octal)
	mov rdx, 0600o	;when creating a new file, make it a 0700 permissions (treat normal notation as octal)
	syscall

	mov rdi, rax	;move the returned fd to rdi for write use
	mov rax, 0x1	;"Write" syscall flag
	mov rsi, input 	;Use input as buffer
	mov rdx, 1024 	;use  max length of input as buffer len
	syscall

	mov rax, 0x3 	;"close" syscall flag
	syscall			;fd already in rdi

	mov rax, 0x3c	;"exit" syscall flag
	mov rdi, 0x0	;set return value to 0
	syscall


section .data
	fname_message db "Filename?: "
	input_message db "Input: ", 0xA

section .bss
	fname resb 64
	fname_len resb 8
	input resb 1024
	input_len resb 8
