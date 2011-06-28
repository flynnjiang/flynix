#ifndef __IO_H_
#define __IO_H_

#define outb(value,port) \
	__asm__ __volatile__ ("out %%al, %%dx;"::"d"(port),"a"(value))

#define inb(port) ({\
	unsigned char value;\
	__asm__ __valatile__ ("in %%dx, %%al;":"=a"(value):"d"(port);\
	value;\
})


#define outw(value,port)	\
	__asm__ __volatile__ ("out %%ax, %%dx;"::"d"(port),"a"(value))


#endif /* __IO_H_ */
