#ifndef _STDDEF_H
#define _STDDEF_H


#ifndef _SIZE_T
#define _SIZE_T
typedef unsigned int size_t;
#endif

#undef NULL
#define NULL ((void *)0)

#endif /* _STDDEF_H */
