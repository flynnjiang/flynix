all: boot.bin setup.bin

boot.bin:boot.s
	nasm -fbin -o $@ $^

setup.bin:setup.s
	nasm -fbin -o $@ $^

clean:
	rm *.bin
