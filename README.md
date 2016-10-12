# OS
Simple Operating System

all : SYSTEM
	cat os.bin kernel.bin > SYSTEM

run : all
	qemu-system-x86_64 SYSTEM

SYSTEM : os.bin kernel.bin

kernel.bin : kernel_entry.o screen.o port.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.o : kernel/kernel.c
	gcc -std=c99 -ffreestanding -c $< -o kernel.o

kernel_entry.o : kernel/kernel_entry.asm
	nasm $< -f elf32 -o kernel_entry.o

screen.o : drivers/screen.c drivers/screen.h
	gcc -std=c99 -ffreestanding -c $< -o screen.o

port.o : kernel/port.c
	gcc -std=c99 -ffreestanding -c $< -o port.o

os.bin : boot/bootloader.asm 
	nasm $< -f bin -I './boot/' -o os.bin

clean:
	rm -fr *.bin *.o 

