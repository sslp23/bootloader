org 0x7e00
jmp 0x0000:start

save db 0

putchar: ;usado pra debugar
    ;mov ah, 0x0e ;
	;int 10h ; interrupção de vídeo
	;ret
   	;mov dh, 5
    ;mov dl, 0
    ;mov ah, 02h
    ;int 10h
    mov cx, 1
    mov bl, 4
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
	je printaCarta2; se al for igual a 'q', printar cartas do player 2
	cmp al, 'w'
	je p2END
	jmp done  

;---------------------------------------- P1 -----------------------------------------------------------

p1END:
	mov bl, 6
	jmp game

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
	je p1val1
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

p1val1: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 22
	mov dl, 11
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov al, '9' ;CRIAR FUNCAO DE RANDOM P COLOCAR NUMEROS RANDOMICOS AQ
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 6
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	jmp game

pone2: ;segunda carta do player1
	cmp dx, 450
	je p1val2
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

p1val2: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 22
	mov dl, 23
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov al, '9'
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 18
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	jmp game

pone3: ;terceira carta do player1
	cmp dx, 450
	je p1val3
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

p1val3: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 22
	mov dl, 36
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov al, '9'
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 31
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	jmp game

pone4: ;quarta carta do player1
	cmp dx, 450
	je p1val4
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

p1val4: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 22
	mov dl, 48
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov al, '9'
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 43
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	jmp game

pone5: ;quinta carta do player1
	cmp dx, 450
	je p1val5
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

p1val5: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 22
	mov dl, 61
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov al, '9'
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 56
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	jmp game


;-----------------------------------------------------END P1----------------------------------------------------

p2END:
	mov bh, 6
	jmp game

printaCarta2:
	inc bh
	cmp bh, 6
	jge game
	mov cx, 40
	mov dx, 40
	cmp bh, 1
	je ptwo1
	mov cx, 140
	cmp bh, 2
	je ptwo2
	mov cx, 240
	cmp bh, 3
	je ptwo3
	mov cx, 340
	cmp bh, 4
	je ptwo4
	mov cx, 440
	cmp bh, 5
	je ptwo5

ptwo1: ;primeira carta do player2
	cmp dx, 140
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 100
	je setC1
	jmp ptwo1

setC1: ;reseta a coordenada x da carta
	mov cx, 40
	inc dx
	jmp ptwo1

ptwo2: ;segunda carta do player2
	cmp dx, 140
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 200
	je setC2
	jmp ptwo2

setC2: ;reseta a coordenada x da carta
	mov cx, 140
	inc dx
	jmp ptwo2

ptwo3: ;terceira carta do player2
	cmp dx, 140
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 300
	je setC3
	jmp ptwo3

setC3: ;reseta a coordenada x da carta
	mov cx, 240
	inc dx
	jmp ptwo3

ptwo4: ;quarta carta do player2
	cmp dx, 140
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 400
	je setC4
	jmp ptwo4

setC4: ;reseta a coordenada x da carta
	mov cx, 340
	inc dx
	jmp ptwo4

ptwo5: ;quinta carta do player2
	cmp dx, 140
	je game
	mov ah, 0Ch
	mov al, 15
	int 10h
	inc cx
	cmp cx, 500
	je setC5
	jmp ptwo5

setC5: ;reseta a coordenada x da carta
	mov cx, 440
	inc dx
	jmp ptwo5

done:
	jmp $