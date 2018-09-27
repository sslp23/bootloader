org 0x7e00
jmp 0x0000:start


l dw 'XXXX The Black Jack Game  XXXX', 0, 0, 0
s dw '     XXXX   Are you ready?     XXXX', 0, 0, 0

w dw '1. Play', 0, 0, 0
r dw '2. Instructions', 0, 0, 0

;instrucoes
;instrucoes
i1 dw 'PLAYER 1:  ', 0, 0, 0
i2 dw 'Hit: PRESS A  ', 0, 0, 0
i3 dw 'Stand: PRESS S ', 0, 0, 0
i4 dw 'PLAYER 2:  ', 0, 0, 0
i6 dw 'Stand: PRESS W', 0, 0, 0
i5 dw 'Hit: PRESS Q', 0, 0, 0
i7 dw  '   PRESS 1 TO START A NEW GAME  ', 0, 0, 0
i8 dw '         INSTRUCTIONS   ',0, 0, 0


save db 0


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

    mov ah, 86h
    int 15h

    jmp print_string
 
    .done:
        ret


    plinha: ;pular uma linha
    inc dh
    xor dl, dl
    mov ah, 02h
    int 10h
    ret


    start:
		xor ax, ax
		mov ds, ax
		mov es, ax
		mov ah, 0
		mov bh, 13h
		int 10h

		mov ah, 0xb
		mov bh, 0
		mov bl, 0
		int 10h 

		
		mov ah, 02h
		mov bh, 0
		mov dh, 12
		mov dl, 5
		int 10h

		mov si, l ;comeco a printar as 4 strings
		call print_string
		call plinha
		mov si, s
		call print_string
		call plinha

		call plinha
		call plinha

		mov si, w
		call print_string
		call plinha

		mov si, r
		call print_string
		call plinha
	

		jmp opcao 

opcao:
	call getchar
	cmp al, '1'
	je jogo
	cmp al, '2'
	je instructions
	jmp opcao


getchar: ; pego o comando
	mov ah, 0h
	int 16h
	ret

instructions:
	call limpatela
	mov dh, 0
	mov dl, 5
	mov ah, 02h
	int 10h
	mov si, i8
	call ps
	
	mov dh, 2
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, i1
	call ps
	mov dh, 3
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, i2
	call ps
	mov dh, 4
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, i3
	call ps
	

	mov dh, 14
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, i4
	call ps
	mov dh, 15
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, i5
	call ps
	mov dh, 16
	mov dl, 0
	mov ah, 02h
	int 10h
	mov si, i6
	call ps
	
	ints:
	mov dh, 20
	mov dl, 3
	mov ah, 02h
	int 10h
	mov si, i7
	call ps
	
	
	call getchar
	cmp al, '1'
	je jogo
	
	mov al, 0
    mov cx, 10
    mov dx, 10
    mov ah, 86h
    int 15h

    mov dh, 20
    mov dl, 3
    mov ah, 02h
    int 10h
	mov al, 48
	mov bl, 0
	mov cx, 1000
	mov ah, 09h
	int 10h

	mov al, 0
    mov cx, 10
    mov dx, 10
    mov ah, 86h
    int 15h

	jmp ints

ps: ;funcao print string ja usada
    lodsb       ;carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ;chegou no final? (equivalente a um \0)
    je done1
    
    mov cx, 1
    mov bl, 14
    mov ah, 09h ;printo um caracter usando 09h p sair com cor
    int 10h     ;interrupção de vídeo.

    inc dl
    mov ah, 02h ;reposiciono o cursor
    int 10h

    jmp ps
 
    done1:
        ret

limpatela:
    mov dh, 0
    mov dl, 0
    mov ah, 02h ; posiciono o cursor no topo
    int 10h
    apagalinha:
        mov al, 48
        mov bl, 0
        mov cx, 1000
        mov ah, 09h
        int 10h ;printo 1000 chars brancos
        inc dh
        mov ah, 02h
        int 10h ;reposiciono o cursor em uma linha abaixo
        cmp dh, 1000
        je clean
        jmp apagalinha
    clean:
        ret

jogo:
;Setando a posição do disco onde kernel.asm foi armazenado(ES:BX = [0x500:0x0])
	mov ax,0x860		;0x50<<1 + 0 = 0x500
	mov es,ax
	xor bx,bx		;Zerando o offset

;Setando a posição da Ram onde o jogo será lido
	mov ah, 0x02	;comando de ler setor do disco
	mov al,8		;quantidade de blocos ocupados por jogo
	mov dl,0		;drive floppy

;Usaremos as seguintes posições na memoria:
	mov ch,0		;trilha 0
	mov cl,7		;setor 2
	mov dh,0		;cabeca 0
	int 13h
	jc jogo	;em caso de erro, tenta de novo

break:	
	jmp 0x8600 		;Pula para a posição carregada

done:
	jmp $
