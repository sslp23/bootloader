org 0x7e00
jmp 0x0000:start


l dw '    XXXX The Black Jack Game  XXXX', 0, 0, 0
s dw '    XXXX   Are you ready?     XXXX', 0, 0, 0

w dw '1. Play', 0, 0, 0
r dw '2. Instructions', 0, 0, 0


save db 0


print_string: ;funcao print string ja usada
    lodsb       ;carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ;chegou no final? (equivalente a um \0)
    je .done
    
    mov cx, 1
    mov bl, 7
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

		call plinha
		call plinha
		call plinha
		call plinha
		call plinha
		call plinha
		call plinha    
		call plinha
		call plinha
		call plinha

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
	

		mov al, 0
		mov cx, 100
		mov dx, 100
		mov ah, 86h
		int 15h

		jmp jogo

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