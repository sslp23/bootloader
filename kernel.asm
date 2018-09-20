org 0x7e00
jmp 0x0000:start

x db 0
y db 0

putchar: ;usado pra debugar
    mov ah, 0x0e ;
	int 10h ; interrupção de vídeo
	ret
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

    xor bl, bl
    xor bx, bx
    jmp game
	jmp done

getchar: ; pego o comando
	mov ah, 0h
	int 16h
	ret

game:
	call getchar
	cmp al, 'a'; se al for igual a 'a', printar carta do player 1
	je printaCarta1
	cmp al, 's'; se al for igual a 's', o player 1 n quer mais cartas
	je p1END
	cmp al, 'q'
	je printaCarta2; carta do player2
	jmp done  


p1END:
	mov bl, 6

printaCarta1:
	inc bl
	cmp bl, 6
	jge game ;se ele ja recebeu 5 cartas, n pode mais receber carta
	mov cx, 40
	mov dx, 350 ;coordenadas da primeira carta
	cmp bl, 1 ;comparacao p ver qual carta tem q ser printada
	je pone1
	mov cx, 140
	cmp bl, 2
	je pone2
	mov cx, 240
	cmp bl, 3
	je pone3
	mov cx, 340
	cmp bl, 4
	je pone4
	mov cx, 440
	cmp bl, 5
	je pone5

pone1: ;primeira carta do player1
	cmp dx, 450
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 100
	je setN1
	jmp pone1

setN1: ;reseta a coordenada x da primeira carta
	mov cx, 40
	inc dx
	jmp pone1

pone2: ;segunda carta do player1
	cmp dx, 450
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 200
	je setN2
	jmp pone2

setN2: ;reseta a coordenada x da carta
	mov cx, 140
	inc dx
	jmp pone2

pone3: ;terceira carta do player1
	cmp dx, 450
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 300
	je setN3
	jmp pone3

setN3: ;reseta a coordenada x da carta
	mov cx, 240
	inc dx
	jmp pone3

pone4: ;quarta carta do player1
	cmp dx, 450
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 400
	je setN4
	jmp pone4

setN4: ;reseta a coordenada x da carta
	mov cx, 340
	inc dx
	jmp pone4

pone5: ;quarta carta do player1
	cmp dx, 450
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 500
	je setN5
	jmp pone5

setN5: ;reseta a coordenada x da carta
	mov cx, 440
	inc dx
	jmp pone5


done:
	jmp $