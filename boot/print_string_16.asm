;Prints on screen string, which address is stored in bx using BIOS calls

print_string_16:
	pusha

	print_string_16_loop:
		mov al, [bx] ;get character
		cmp al, 0 ;check for end of string
		je print_string_16_return 
		push bx ;save current addres before BIOS call
		mov ah, 0x0e ;set TTL mode
		int 0x10
		pop bx 
		inc bx ;get next character address
		jmp print_string_16_loop

	print_string_16_return:
		popa
		ret
