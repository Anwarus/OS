//Kernel

#include "../drivers/screen.h"

void main()
{	
	char* video_memory = (char*)0xb8000;
	for(int i=0; i<10; i++)
	{
		*video_memory = 'X';
		video_memory += 2;
	}

	print_char('G', 0, 0, 15);

	//clear_screen();

	//char* msg = "HELLO WORLD";
	//print(msg);

	//set_cursor(get_screen_offset(1, 1));

	return;
}
