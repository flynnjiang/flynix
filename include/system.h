#ifndef __ASM_SYSTEM_H_
#define __ASM_SYSTEM_H_


#define sti() __asm__ __volatile__ ("sti":::"memory")
#define cli() __asm__ __volatile__ ("cli":::"memory")


#endif /* __ASM_SYSTEM_H_ */
