;Moving cursor to new line using BIOS calls

new_line_16:
	pusha

	mov ah, 0x03 ;get cursor position
	mov bh, 0x00 ;from page
	int 0x10

	inc dh ;increment row
	mov dl, 0x00 ;set column to 0
	mov ah, 0x02 ;set cursor position
	int 0x10

	popa
	ret
