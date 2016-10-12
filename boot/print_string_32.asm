[bits 32]

;constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0e

print_string_32:
	pusha
	mov edx, VIDEO_MEMORY
	
	print_string_32_loop:
		mov al, [ebx] ;set character
		mov ah, WHITE_ON_BLACK
		cmp al, 0 ;check for string end
		je print_string_32_return
	
		mov [edx], ax ;set character into VGA 

		add ebx, 1 ;get next character
		add edx, 2 ;go to next VGA field
	
		jmp print_string_32_loop

	print_string_32_return:	
		popa
		ret
