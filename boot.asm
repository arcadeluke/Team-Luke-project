;boot.asm:the bootloader to boot our operating system with grub
[bits 32] ;we are in 32 bit
global start ;starts the operating system:we call it in the linker script
extern main ;this is in our .cpp file and it is the main function of our kernel
;do not modify these limits(these are needed by grub!)
section .mbHeader

align 0x4

; setting up the Multiboot loader - see GRUB docs for details
MODULEALIGN equ	1<<0		;align the loaded modules on page boundaries
MEMINFO	    equ 1<<1		;provide memory snap
FLAGS	    equ	MODULEALIGN | MEMINFO ;this is the Multiboot 'flag' field
MAGIC	    equ  0x1BADB002	; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS); checksum required

MultiBootHeader:
  dd MAGIC
  dd FLAGS
  dd CHECKSUM

;you can modify these
start:
push ebx
call  _kernel_main
