load_kernel_16:
	
	pusha	

	mov bx, MSG_LOAD_KERNEL
	call print_string_16
	
	call new_line_16

	mov bx, KERNEL_OFFSET
	mov dh, 3 ;load into memory 15 disk sectors
	mov dl, [BOOT_DRIVE]

	call disk_load_16

	popa
	ret

