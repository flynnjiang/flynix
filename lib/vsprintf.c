#include "stdarg.h"

int vsnprintf(void *buf, size_t size, const char *fmt, va_list args)
{
	int is_parsing = 0;
	int len = 0;
	char *s = (char *)buf;
	char c;
	char *p = NULL;

	if (NULL == s || NULL == fmt)
		return -1;

	while ((c = *fmt++) != '\0' && len < size-1) {
		if (1 == is_parsing) {
			switch (c) {
			case 'c':
				s[len++] = va_args(args, char);
				break;
			case 's':
				p = va_args(args, char *);
				while (*p != '\0' && len < size-1) {
					s[len++] = *p++;
				}
				break;
			case 'd':
				va_args(args, int);
				break;
			default:
				break;
			}

			is_parsing = 0;

		} else {
			switch (c) {
			case '%':
				is_parsing = 1;
				break;
			default:
				s[len++] = c;
			}
		}
	}


	s[len] = '\0';

	return 0;
}
