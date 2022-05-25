; E Tovell
; 2022-05-24
; Takes in filename, and single-line text input, writes to file. Uses call and ret.

section .text
	global _start
_start:
	mov rsi, fname_message	;set write buffer to fname_message
	mov rdx, 11		;set write buffer length to 11
	call .write_to_screen ;call .write_to_screen "function"

	call .read_fname

	mov rsi, input_message
	mov rdx, 8
	call .write_to_screen

	call .read_file_input

	call .write_to_file

	call .exit
	
.write_to_screen:
	mov rax, 0x1	;"Write" syscall flag
	mov rdi, 0x1	;"stdout" fd
	syscall
	ret

.read_fname:
	mov rax, 0x0	;"Read" syscall flag
	mov rdi, 0x0	;"stdin" fd
	mov rsi, fname	;use fname bytes for buffer
	mov rdx, 64		;use size of fname bytes as count
	syscall

	mov byte [rsi + rax - 1], 0 ;remove newline character at end of fname input
	;Done by taking the file pointer in rsi, moving it over by the returned length of the string in rax, subtracting 1 to get to the newline character, and replacing it with 0x0 (the end character)

	ret

.read_file_input:
	mov rax, 0x0	;"Read" syscall flag
	mov rdi, 0x0	;"stdin" fd
	mov rsi, input	;use input bytes for buffer
	mov rdx, 1024	;use max size of input as buffer size
	syscall
	ret
	
.write_to_file:
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
	ret

.exit:
	mov rax, 0x3c	;"exit" syscall flag
	mov rdi, 0x0	;set return value to 0
	syscall
	ret

section .data
	fname_message db "Filename?: "
	input_message db "Input: ", 0xA

section .bss
	fname resb 64
	fname_len resb 8
	input resb 1024
	input_len resb 8
