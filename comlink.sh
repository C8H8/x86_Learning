# E Tovell
# 2022-05-24
# Assembles and links x86_64 assembly. specify filename without extension as an argument
nasm -f elf64 $1.asm -o $1.o
ld $1.o -o $1
