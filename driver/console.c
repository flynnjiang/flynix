#include "console.h"
#include "io.h"
#include "system.h"


/* Cursor's postion */
static unsigned int cur_x = 0, cur_y = 0;

static char *vm_base = (char *)VIDEO_MEM_BASE;

/* MC6845's address register's port, size:16bits */
static unsigned short mc6845_addr_port = 0x3d4;
/* MC6945's data registers' port, size:16bits */
static unsigned short mc6845_data_port = 0x3d5;



static void set_cursor(void)
{
	/* Current postion of cursor, size:16bits */
	unsigned short cur_pos = cur_x + SCREEN_COL * cur_y;

	cli();

	/* Write postion's high bits */
	outb(14, mc6845_addr_port);
	outb((cur_pos>>8) & 0xff, mc6845_data_port);

	/* Write postion's low bits */
	outb(15, mc6845_addr_port);
	outb((cur_pos & 0xff), mc6845_data_port);

	sti();
}



void con_write(const char *msg, int attr)
{
	char c;
	unsigned int vm_offset = cur_x * CHAR_MEM_SIZE \
				 	+ cur_y * LINE_MEM_SIZE;	

	while ((c = *msg++) != '\0') {
		switch (c) {
		case '\n':
			cur_x = 0;
			cur_y++;
			vm_offset += LINE_MEM_SIZE \
					- (vm_offset % LINE_MEM_SIZE);
			break;
		case '\b':
			cur_x--;
			vm_offset -= CHAR_MEM_SIZE;
			break;
		default:
			*(vm_base + vm_offset) = c;
			*(vm_base + vm_offset + 1) = attr;
			cur_x++;
			vm_offset += CHAR_MEM_SIZE;
		}

		if (vm_offset >= VIDEO_MEM_SIZE) {
			vm_offset = vm_offset % VIDEO_MEM_SIZE;
			cur_x = 0;
			cur_y = 0;
		}
	}

	set_cursor();
}

void con_clear(void)
{
	int i;

	for (i = 0; i < VIDEO_MEM_SIZE; i+=2)
		*(vm_base + i) = ' ';

	cur_x = 0;
	cur_y = 0;
}

void scroll_up(int lines)
{
}

void scroll_down(int lines)
{
}

