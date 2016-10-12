[bits 16]

switch_to_pm:

	cli ;turn of interrupts
	lgdt [gdt_descriptor] ;load GDT
	
	mov eax, cr0 ;Switch first bit of cr0 to get into PM
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_pm ;Jump to new segment to force CPU to flush

[bits 32]

init_pm:

	mov ax, DATA_SEG ;set up segments
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax 

	mov ebp, 0x90000 ;update stack position
	mov esp, ebp

	call BEGIN_PM
