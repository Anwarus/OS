clear_screen_16:
	pusha
	
	mov ah, 0x07
	mov al, 0x00 ;clear
	mov bh, 0x07 ;color mode
	mov cx, 0x0000 ;row and col to 0
	mov dx, 0x184f ;right lower corner
	int 0x10
	
	popa
	ret
