#include "stdlib.h"
#include "console.h"

static char printk_buf[512];

int printk(const char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
	va_end(args);

	con_write(printk_buf, 0x0b);

	return 0;
}
