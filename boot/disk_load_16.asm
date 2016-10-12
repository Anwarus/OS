disk_load_16:
	push dx

	mov ah, 0x02
	mov al, dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02
	
	int 0x13

	jc disk_error
	
	pop dx
	;cmp dh, al
	;jne disk_error
	ret

	disk_error:
		mov bx, MSG_ERROR_DISK
		call print_string_16
		jmp $

	MSG_ERROR_DISK db "Error on disk loading", 0
