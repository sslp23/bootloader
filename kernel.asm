org 0x8600
jmp 0x0000:start

save db 0
c db 0
p1 db 0 ;vao verificar se p1==21
p2 db 0
eg db 0 ;verifica se ja acabou o jogo

sp1 db 'Player 1: ', 0, 0, 0
sp2 db 'Player 2: ', 0, 0, 0
wp2 db 'Player 2 wins!', 0, 0, 0
wp1 db 'Player 1 wins!', 0, 0, 0
e db 'Its a draw!', 0, 0, 0
rst db 'Restart? Press 1', 0, 0, 0


print_string: ;funcao print string ja usada
    lodsb       ;carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ;chegou no final? (equivalente a um \0)
    je .done
    
    mov cx, 1
    mov bl, 14
    mov ah, 09h ;printo um caracter usando 09h p sair com cor
    int 10h     ;interrupção de vídeo.

    inc dl
    mov ah, 02h ;reposiciono o cursor
    int 10h

    jmp print_string
 
    .done:
        ret


putchar: ;usado pra debugar
    cmp al, 58
    je ident
    mov cx, 1
    mov bl, 4
    mov ah, 09h
    int 10h
    bid:
    ret

ident: ;printar o 10
	sub dl, 1
	mov ah, 02h
	int 10h
	mov al, '1'
	mov cx, 1
    mov bl, 4
    mov ah, 09h
    int 10h
    inc dl ;aqqa
    mov ah, 02h
    int 10h
    mov al, '0'
    mov cx, 1
    mov bl, 4
    mov ah, 09h
    int 10h
    mov al, 58
    jmp bid

start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	xor bx, bx

	mov [c], al
    restart:
	mov ah, 0
	mov al, 12h
	int 10h ;modo de video

	mov [p1], ah
    mov [p2], ah

	xor dx, dx
    mov ah, 0xb
    mov bh, 0
    mov bl, 2
    int 10h
    mov al, [c]
    add al, al
    mov [c], al

	mov dh, 10
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, sp2
	call print_string
	mov dh, 19
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, sp1
	call print_string

	xor dx, dx
    xor cx, cx
    xor bl, bl
    xor bx, bx
    jmp tabuleiro
	jmp done

getchar: ; pego o comando
	mov ah, 0h
	int 16h
	ret

;---------------------------------------------------tabuleiro-----------------------------
tabuleiro:
	mov cx, 30
	mov dx, 340
	mov bx, dx
	add bx, 120
	call tab
	mov dx, 340
	mov cx, 130
	call tab2
	mov dx, 340
	mov cx, 230
	call tab3
	mov dx, 340
	mov cx, 330
	call tab4
	mov dx, 340
	mov cx, 430
	call tab5

	mov cx, 30
	mov dx, 30
	mov bx, dx
	add bx, 120
	call tab
	mov dx, 30
	mov cx, 130
	call tab2
	mov dx, 30
	mov cx, 230
	call tab3
	mov dx, 30
	mov cx, 330
	call tab4
	mov dx, 30
	mov cx, 430
	call tab5
	xor bx, bx
	jmp game	

tab: ;primeira carta do player1
	cmp dx, bx
	je bt1
	mov ah, 0Ch
	mov al, 14
	int 10h
	inc cx
	cmp cx, 110
	je setT
	jmp tab
	bt1:
		ret

setT: ;reseta a coordenada x da primeira carta
	mov cx, 30	
	inc dx
	jmp tab

tab2: ;primeira carta do player1
	cmp dx, bx
	je bt2
	mov ah, 0Ch
	mov al, 14
	int 10h
	inc cx
	cmp cx, 210
	je setT2
	jmp tab2
	bt2:
		ret

setT2: ;reseta a coordenada x da primeira carta
	mov cx, 130	
	inc dx
	jmp tab2

tab3: ;primeira carta do player1
	cmp dx, bx
	je bt3
	mov ah, 0Ch
	mov al, 14
	int 10h
	inc cx
	cmp cx, 310
	je setT3
	jmp tab3
	bt3:
		ret

setT3: ;reseta a coordenada x da primeira carta
	mov cx, 230	
	inc dx
	jmp tab3

tab4: ;primeira carta do player1
	cmp dx, bx
	je bt4
	mov ah, 0Ch
	mov al, 14
	int 10h
	inc cx
	cmp cx, 410
	je setT4
	jmp tab4
	bt4:
		ret

setT4: ;reseta a coordenada x da primeira carta
	mov cx, 330	
	inc dx
	jmp tab4

tab5: ;primeira carta do player1
	cmp dx, bx
	je bt5
	mov ah, 0Ch
	mov al, 14
	int 10h
	inc cx
	cmp cx, 510
	je setT5
	jmp tab5
	bt5:
		ret

setT5: ;reseta a coordenada x da primeira carta
	mov cx, 430	
	inc dx
	jmp tab5
;----------------------------------------------------------------------------------------------------
scoreUpdateP1:;printa o score do P1
	mov cx, 1
	mov [save], bl
	mov dh, 19
    mov dl, 10
    mov ah, 02h
    int 10h;posicionando o cursor
    
    xor ax, ax
    mov al, [p1]
    mov cl, 10
    div cl ;divindo al
    mov cx, 1

    mov [eg], ah
    mov bl, 14
    add al, 48
   	mov ah, 09h
   	int 10h ;printando

   	mov al, [eg]
   	inc dl
   	mov ah, 02h
   	int 10h;reposicionando o cursor
   	mov cx, 1

   	mov bl, 14
   	add al, 48
   	mov ah, 09h
   	int 10h ;printando
   	mov bl, [save]
   	ret

scoreUpdateP2:;printa o score do P2
	mov cx, 1
	mov [save], bl
	mov dh, 10
    mov dl, 10
    mov ah, 02h
    int 10h;posicionando o cursor
    
    xor ax, ax
    mov al, [p2]
    mov cl, 10
    div cl ;divindo al
    mov cx, 1

    mov [eg], ah
    mov bl, 14
    add al, 48
   	mov ah, 09h
   	int 10h ;printando

   	mov al, [eg]
   	inc dl
   	mov ah, 02h
   	int 10h;reposicionando o cursor
   	mov cx, 1

   	mov bl, 14
   	add al, 48
   	mov ah, 09h
   	int 10h ;printando
   	mov bl, [save]
   	ret

game:
	call scoreUpdateP1
	call scoreUpdateP2
	xor cl, cl
	add cl, bl
	add cl, bh
	cmp cl, 12
	je endgame
	call getchar
	mov cl, 10
	add cl, bl
	add cl, al
	add cl, dl
	mov cl, [c]
	add cl, al
	mov [c], cl
	cmp al, 'a'; se al for igual a 'a', printar carta do player 1
	je printaCarta1
	cmp al, 's'; se al for igual a 's', o player 1 n quer mais cartas
	je p1END
	cmp al, 'q'
	je printaCarta2; se al for igual a 'q', printar cartas do player 2
	cmp al, 'w'
	je p2END
	jmp game 


as:
	mov al, 'A'
	jmp bval

king:
	mov al, 'K'
	jmp bval

queen:
	mov al, 'Q'
	jmp bval

jack: 
	mov al, 'J'
	jmp bval

getval: ; "random"
	mov al, [c]
	rand:
		inc al
		cmp cl, al
		je rand
	mov cl, 13
	div cl
	div cl
	mov al, ah
	add al, 1
	cmp bl, 0
	je addp1
	cmp bl, 1
	je addp2
	badd:
	add al, 48
	cmp al, 49
	je as
	cmp al, 59
	je jack
	cmp al, 60
	je queen
	cmp al, 61
	je king
	bval:
	ret

addp1:
	mov cl, [p1]
	add cl, al
	mov [p1], cl
	jmp badd

addp2:
	mov cl, [p2]
	add cl, al
	mov [p2], cl
	jmp badd

;---------------------------------------- P1 -----------------------------------------------------------

p1END:
	mov bl, 6  
	jmp game

printaCarta1:
	cmp bl, 5
	jge game ;se ele ja recebeu 5 cartas, n pode mais receber carta
	inc bl
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
	mov bl, 0
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 6
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p1]
	cmp al, 21
	jge p1END
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
	mov bl, 0
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 18
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p1]
	cmp al, 21
	jge p1END
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
	mov bl, 0
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 31
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p1]
	cmp al, 21
	jge p1END
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
	mov bl, 0
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 43
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p1]
	cmp al, 21
	jge p1END
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
	mov bl, 0
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 27
	mov dl, 56
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p1]
	cmp al, 21
	jge p1END
	jmp p2END


;-----------------------------------------------------END P1----------------------------------------------------

p2END:
	mov bh, 6
	jmp game

printaCarta2:
	cmp bh, 5
	jge game
	inc bh
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
	je p2val1
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

p2val1: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 3
	mov dl, 11
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov bl, 1
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 7
	mov dl, 6
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p2]
	cmp al, 21
	jge p2END
	jmp game

ptwo2: ;segunda carta do player2
	cmp dx, 140
	je p2val2
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

p2val2: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 3
	mov dl, 23
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov bl, 1
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 7
	mov dl, 18
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p2]
	cmp al, 21
	jge p2END
	jmp game

ptwo3: ;terceira carta do player2
	cmp dx, 140
	je p2val3
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

p2val3: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 3
	mov dl, 36
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov bl, 1
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 7
	mov dl, 31
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p2]
	cmp al, 21
	jge p2END
	jmp game

ptwo4: ;quarta carta do player2
	cmp dx, 140
	je p2val4
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

p2val4: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 3
	mov dl, 48
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov bl, 1
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 7
	mov dl, 43
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p2]
	cmp al, 21
	jge p2END
	jmp game

ptwo5: ;quinta carta do player2
	cmp dx, 140
	je p2val5
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

p2val5: ;valor da carta
	;call putchar
	xor dx, dx
	mov dh, 3
	mov dl, 61
	mov ah, 02h
	int 10h ;setando o cursor

	mov [save], bl ;salvando o valor de bl
	mov bl, 1
	call getval
    call putchar ;printa primeiro numero

	xor dx, dx
	mov dh, 7
	mov dl, 56
	mov ah, 02h
	int 10h

	call putchar ;segunda carta
	mov bl, [save]
	mov al, [p2]
	cmp al, 21
	jge p2END
	jmp p2END

;-------------------------------------------------END P2------------------------------------------

reset:
	mov dh, 29
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, rst
	call print_string
	call getchar
	cmp al, '1'
	je restart
	jmp reset

p1WIN:
	mov dh, 15
	mov dl, 32
	mov ah, 02h
	int 10h
	mov si, wp1
	call print_string
	jmp reset

p2WIN:
	mov dh, 15
	mov dl, 32
	mov ah, 02h
	int 10h
	mov si, wp2
	call print_string
	jmp reset

draw:
	mov dh, 15
	mov dl, 34
	mov ah, 02h
	int 10h
	mov si, e
	call print_string
	jmp reset

mod1:
	mov cl, 21
	sub al, cl
	mov [p1], al
	jmp back1

mod2:
	mov cl, 21
	sub al, cl
	mov [p2], al
	jmp back2

endgame:
	mov al, [p1]
	cmp al, 21
	jg mod1
	mov cl, 21
	sub cl, al
	mov [p1], cl
	back1:
	mov al, [p2]
	cmp al, 21
	jg mod2
	mov cl, 21
	sub cl, al
	mov [p2], cl
	back2:
	mov al, [p2]
	mov ah, [p1]
	cmp al, ah
	jg p1WIN
	jl p2WIN
	je draw
	jmp done

done:
	jmp $
