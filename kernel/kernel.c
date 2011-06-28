#include "console.h"

void main(void)
{
	char buf[]="Hello, Flynix!";

	con_clear();
	printk(buf, 0xff);

	while(1);

}
