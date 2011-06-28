###########################
# Configuration
###########################
ROOT_PATH=$(PWD)
MAKE_DEP=make_depends~

INC_PATHS=include
LIB_PATHS=lib driver
SUB_DIRS = lib driver kernel

RM=rm
AR=ar
CC=gcc
LD=ld

CFLAGS = -Wall $(addprefix -I$(ROOT_PATH)/, $(INC_PATHS))
LDFLAGS = $(addprefix -L$(ROOT_PATH)/, $(LIB_PATHS))

export


###########################
# Target
###########################
all: modules image

modules:
	for i in $(SUB_DIRS); \
		do $(MAKE) -C $$i; \
	done;

image: boot/boot.bin boot/setup.bin kernel/kernel.bin
	cat boot/boot.bin boot/setup.bin kernel/kernel.bin \
		> image/floppy.img

startup:
	(cd tools; sh start.sh)

clean:
	for i in $(SUB_DIRS); \
		do $(MAKE) -C $$i clean; \
	done;

	$(RM) image/floppy.img
