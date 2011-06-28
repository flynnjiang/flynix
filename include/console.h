#ifndef __CONSOLE_H_
#define __CONSOLE_H_

#define SCREEN_COL	80
#define SCREEN_ROW	25

#define CHAR_MEM_SIZE	2
#define LINE_MEM_SIZE	(SCREEN_COL * CHAR_MEM_SIZE)

#define VIDEO_MEM_BASE	0xb8000
#define VIDEO_MEM_SIZE	(SCREEN_COL * SCREEN_ROW * CHAR_MEM_SIZE)


void con_write(const char *msg, int attr);
void con_clear();



#endif /* __CONSOLE_H_ */

