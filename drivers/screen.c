#include "screen.h"

void print(char* message)
{
	print_at(message, -1, -1);
}

void print_at(char* message, int column, int row)
{
	if(column >= 0 && row >= 0)
	{
		set_cursor(get_screen_offset(column, row));
	}

	int i = 0;
	while(message[i] != 0)
	{
		print_char(message[i++], column, row, WHITE_ON_BLACK);
	}	
}

void clear_screen()
{
	int row = 0;
	int col = 0;

	for(row = 0; row < MAX_ROWS; row++)
	{
		for(col = 0; col < MAX_COLS; col++)
		{
			print_char(' ', col, row, WHITE_ON_BLACK);
		}
	}

	set_cursor(get_screen_offset(0, 0));
}

void print_char(char character, int column, int row, char attribute_byte)
{
	int* vidmem;
	vidmem = (int*) VIDEO_ADDRESS;	

	//*vidmem = 'G';
	//*(vidmem + 1) = 'R';
	//*(vidmem + 2) = 'r';
	
	if(!attribute_byte)
	{
		attribute_byte = WHITE_ON_BLACK;
	}
	
	int offset = 0;
	
	if(column >= 0 && row >= 0)
	{
		offset = get_screen_offset(column, row);		
	}
	else
	{
		offset = get_cursor();
	}
	
	offset = 0;
	vidmem += offset;
	*vidmem = 'T';	

	if(character == '\n')
	{
		int rows = offset / (2 * MAX_COLS);
		offset = get_screen_offset(79, rows);
	}
	else
	{
		vidmem[offset] = character;
		vidmem[offset + 1] = attribute_byte;
	}

	//Update offset for next character
	offset += 2;

	//offset = handle_scrolling(offset);
	set_cursor(offset);
}

int get_cursor()
{
	port_byte_out(REG_SCREEN_CTRL, 14);
	int offset = port_byte_in(REG_SCREEN_DATA) << 8;
	port_byte_out(REG_SCREEN_CTRL, 15);
	offset += port_byte_in(REG_SCREEN_DATA);

	return offset * 2;	
}

void set_cursor(int offset)
{
	offset /= 2;
	
	port_byte_out(REG_SCREEN_CTRL, 14);
	port_byte_out(REG_SCREEN_DATA, (unsigned char) (offset >> 8));
	port_byte_out(REG_SCREEN_CTRL, 15);
	port_byte_out(REG_SCREEN_DATA, (unsigned char) offset);
}

int get_screen_offset(int column, int row)
{
	int offset = (row * MAX_COLS) + column;

	if(offset != 0)
	{
		offset *= 2;
	}

	return offset;
}

void handle_scrolling(int offset)
{

}
