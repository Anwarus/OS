;anwOS bootloader
[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ;place where kernel will be loaded

mov [BOOT_DRIVE], dl

;Setup stack
mov bp, 0x9000
mov sp, bp

call clear_screen_16

call cursor_zero_16

mov bx, MSG_REAL_MODE
call print_string_16

call new_line_16

call load_kernel_16

call switch_to_pm

jmp $

%include "cursor_zero_16.asm"
%include "clear_screen_16.asm"
%include "new_line_16.asm"
%include "print_string_16.asm"
%include "disk_load_16.asm"
%include "load_kernel_16.asm"

%include "GDT.asm"
%include "init_protect_mode.asm"

%include "print_string_32.asm"

[bits 32]

BEGIN_PM:
	
	mov ebx, MSG_PROTECTED_MODE
	call print_string_32

	call KERNEL_OFFSET
	
	jmp $	

;Data
BOOT_DRIVE db 0
MSG_REAL_MODE db "16-bit mode started!", 0
MSG_PROTECTED_MODE db "32-bit mode started!", 0
MSG_LOAD_KERNEL db "Loading kernel!", 0

times 510-($-$$) db 0
dw 0xaa55
