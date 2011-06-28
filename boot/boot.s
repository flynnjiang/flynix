[BITS 16]
[ORG 0]


BOOTSEG		EQU	0x07c0
INITSEG		EQU	0x9000
SETUPSEG	EQU	0x9020
SYSSEG		EQU	0x1000

start:
	; Save device's ID
	mov	[boot_drv], dl

	; Move self to segment 0x9000
	mov	ax, BOOTSEG
	mov	ds, ax
	mov	ax, INITSEG
	mov	es, ax
	xor	si, si
	xor	di, di
	mov	cx, 0x0200
	rep movsb

	jmp	INITSEG:_start

_start:
	; Set segment registers
	mov	ax, INITSEG
	mov	ds, ax
	mov	es, ax
	cli
	mov	ss, ax
	mov	sp, 0xf000
	sti

	
	mov	si, boot_msg
	call	print_msg

	; Load setup.s to segment 0x9020
	mov	ax, 0x9020
	mov	es, ax
	mov	bx, 0x0
	call	load_setup

	; Load system to segment 0x1000
	mov	ax, 0x1000
	mov	es, ax
	mov	bx, 0x0
	call	load_system

	jmp	SETUPSEG:0x0


;-----------------------------
; Function: print_msg
;-----------------------------
print_msg:
	push	ax
	push	bx

	mov	ah, 0x0e
	mov	bx, 0x0007
_print_msg:
	lodsb
	cmp	al, 0x0
	jz	_end_print_msg

	int	0x10
	jmp	_print_msg
_end_print_msg:
	pop	bx
	pop	ax
	ret


;-----------------------------
; Function: reset disk
;-----------------------------
reset_drive:
	push	ax
	mov	ah, 0x0
	int	0x13
	pop	ax
	ret


;-----------------------------
; Function: load setup/system
;-----------------------------
load_setup:
	push	ax
	push	cx
	push	dx
	mov	ah, 0x02
	mov	al, 0x01	; sector size
	mov	ch, 0x0		; trap number
	mov	cl, 0x02	; sector number
	mov	dh, 0x0		; header number
	mov	dl, [boot_drv]	; device number
	jmp	_read_one_sector

load_system:
	push	ax
	push	cx
	push	dx
	mov	ah, 0x02
	mov	al, 0x10	; sector size
	mov	ch, 0x0		; trap number
	mov	cl, 0x03	; sector number
	mov	dh, 0x0		; header number
	mov	dl, [boot_drv]	; device number
	jmp	_read_one_sector

_read_one_sector:
	call	reset_drive

	push	ax
	mov	al, 0x01
	int	0x13
	pop	ax

	; Show the process
	mov	si, dot
	call	print_msg

	inc	cl
	dec	al
	add	bx, 0x0200

	cmp	al, 0x0
	jz	_load_finished
	jmp	_read_one_sector

_load_finished:
	pop	dx
	pop	cx
	pop	ax
	ret
	

;--------------------------------
; Data
;--------------------------------
boot_msg:	db	'Booting',0
dot:		db	'.',0

; Boot drive's ID
boot_drv:	db	0


; Fill to 512 bytes
times	510-($-$$) db 0
dw	0xaa55
