SRC = console.c
OBJ = $(SRC:%.c=%.o)
LIB = libdriver.a

all: $(MAKE_DEP) $(LIB)

$(LIB): $(OBJ)
	$(AR) rcs $(LIB) $^

$(MAKE_DEP): 
	@$(CC) $(CFLAGS) -MM *.c > $@

clean:
	-$(RM) *.o $(LIB) $(MAKE_DEP)

-include $(MAKE_DEP)
