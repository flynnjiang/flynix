SRC = kernel.c printk.c
OBJ = $(SRC:%.c=%.o)
BIN = kernel.bin

LDFLAGS += -ldriver -lklib

all: $(MAKE_DEP) $(BIN)

$(BIN): $(OBJ) 
	$(LD) -Map System.map --oformat binary -emain \
		-Ttext 0x0000 -o $@ $^ $(LDFLAGS)

$(MAKE_DEP): 
	@$(CC) $(CFLAGS) -MM *.c > $@

clean:
	-$(RM) *.o $(MAKE_DEP) $(BIN)

-include $(MAKE_DEP)
