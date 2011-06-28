#include "kernel.h"
#include "console.h"

void main(void)
{
	con_clear();

	printk("Hello, %s", "Flynix!");

	while(1);

}
