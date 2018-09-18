org 0x7e00
jmp 0x0000:start


putchar: ;usado pra debugar
    mov dh, 5
    mov dl, 0
    mov ah, 02h
    int 10h
    mov al, 'x'
    mov cx, 3
    mov bl, 6
    mov ah, 09h
    int 10h
    ret

start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	mov ah, 0
	mov al, 12h
	int 10h ;modo de video

	xor dx, dx
    mov ah, 0xb
    mov bh, 0
    mov bl, 2
    int 10h

	call printaPixel
	jmp done

printaPixel:
	cmp dx, 15
	je bac
	mov ah, 0Ch
	mov al, 6
	int 10h
	inc cx
	cmp cx, 20
	je setN
	jmp printaPixel
	bac:
		ret

setN:
	xor cx, cx
	inc dx
	jmp printaPixel

done:
	jmp $