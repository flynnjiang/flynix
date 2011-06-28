#include "console.h"

int printk(const char *str)
{
	con_write(str, 0x0b);

	return 0;
}
