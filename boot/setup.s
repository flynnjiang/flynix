;------------------------------------------
; Do things:
; 1. save BIOS data
; 2. Enter save mode
;------------------------------------------
[ORG 0]
[BITS 16]


INITSEG		EQU	0x9000
SETUPSEG	EQU	0x9020
SYSSEG		EQU	0x1000


start:
	mov	ax, SETUPSEG
	mov	ds, ax
	mov	es, ax
	cli
	mov	ss, ax
	mov	sp, 0x0fff
	sti

	; Save BIOS data to 0x90000
	mov	ax, INITSEG
	mov	ds, ax

	; Move system to 0x00000
	mov	ax, 0x1000
	mov	ds, ax
	mov	ax, 0x0000
	mov	es, ax
	xor	si, si
	xor	di, di
	mov	cx, 0x2000
	rep movsb

	cli
	mov	ax, SETUPSEG
	mov	ds, ax
	mov	es, ax

	; Load tmp GDT
	lgdt [gdt_48_tmp]

	; Load tmp IDT
	lidt [idt_48_tmp]

	; 8259A
	mov	al, 0x11
	out	0x20, al
	out	0xa0, al

	mov	al, 0x20
	out	0x21, al

	mov	al, 0x28
	out	0xa1, al

	mov	al, 0x04
	out	0x21, al

	mov	al, 0x02
	out	0xa1, al

	mov	al, 0x01
	out	0x21, al
	out	0xa1, al

	mov	al, 0xff
	out	0x21, al
	out	0xa1, al

	; A20
	call	wait_8042
	mov	al, 0xd1
	out	0x64, al

	call	wait_8042
	mov	al, 0xdf
	out	0x60, al

	call	wait_8042

	; CR3
	mov	ax, 0x0001
	lmsw	ax

	; Change to protected mode
	mov	ax, 0x10
	mov	ds, ax
	mov	es, ax
	mov	ss, ax
	mov	esp, 0xffff

	jmp	0x8:0
	jmp	$

wait_8042:
	in	al, 0x64
	test	al, 0x02
	jnz	wait_8042
	ret



gdt_tmp:
	dd	0x00000000
	dd	0x00000000

	dd	0x00000fff
	dd	0x00c09a00

	dd	0x00000fff
	dd	0x00c09200

gdt_48_tmp:
	dw	gdt_48_tmp - gdt_tmp -1
	dw	512+(gdt_tmp-$$),0x9


idt_48_tmp:
	dw	0
	dw	0,0

times 512-($-$$) db	0
