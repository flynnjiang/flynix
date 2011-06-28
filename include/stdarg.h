#ifndef _STDARG_H
#define _STDARG_H

#include "stddef.h"

typedef char *va_list;

#define _rounded_size(type) \
	((sizeof(type) + sizeof(int) - 1) / sizeof(int) * sizeof(int))

#define va_start(ap, last) \
		(ap = (char *)(&last) + _rounded_size(last))

#define va_args(ap, type) \
		(ap = (void *)((char *)ap + _rounded_size(type)), \
		 *(type *)((char *)ap - _rounded_size(type)))

#define va_end(ap)


#endif /* _STDARG_H */
