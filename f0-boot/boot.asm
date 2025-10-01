section .multiboot
align 8
mb_header:
    dd 0xE85250D6
    dd 0
    dd mb_header_end - mb_header
    dd 0x100000000 - (0xE85250D6 + 0 + (mb_header_end - mb_header))
    dw 0
    dw 0
    dd 8
mb_header_end:

section .bss
align 16
stack_bottom: resb 16384
stack_top:

section .text
global _start
extern kmain
_start:
    mov rsp, stack_top
    call kmain
    cli
hang: hlt
    jmp hang
