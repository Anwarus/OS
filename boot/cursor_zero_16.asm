cursor_zero_16:
	pusha

	mov ah, 0x02
	mov bh, 0x00 ;page
	mov dx, 0x0000 ;row and column
	int 0x10
	
	popa
	ret
