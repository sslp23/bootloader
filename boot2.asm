org 0x500
jmp 0x0000:start
l db 'Loading structures for the kernel...', 0, 0, 0
s db 'Setting up protected mode...', 0, 0, 0
m db 'Loading kernel in memory...', 0, 0, 0
r db 'Running kernel...', 0, 0, 0

print_string: ;funcao print string ja usada
    lodsb       ;carrega uma letra de si em al e passa para o próximo caractere
    cmp al, 0   ;chegou no final? (equivalente a um \0)
    je .done
    
    mov cx, 1
    mov bl, 4
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

putchar: ;usado pra debugar
    mov dh, 5
    mov dl, 0
    mov ah, 02h
    int 10h
    mov al, 'x'
    mov cx, 3
    mov bl, 4
    mov ah, 09h
    int 10h
    ret

limpatela:
    mov dh, 0
    mov dl, 0
    mov ah, 02h ; posiciono o cursor no topo
    int 10h
    apagalinha:
        mov al, 48
        mov bl, 2
        mov cx, 1000
        mov ah, 09h
        int 10h ;printo 1000 chars brancos
        inc dh
        mov ah, 02h
        int 10h ;reposiciono o cursor em uma linha abaixo
        cmp dh, 5
        je clean
        jmp apagalinha
    clean:
        ret


start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ah, 0
    mov bh, 13h
    int 10h

    xor dx, dx
    mov ah, 0xb
    mov bh, 0
    mov bl, 2
    int 10h

    mov si, l ;comeco a printar as 4 strings
    call print_string
    call plinha
    mov si, s
    call print_string
    call plinha
    mov si, m
    call print_string
    call plinha
    mov si, r
    call print_string

    mov al, 0
    mov cx, 10
    mov dx, 10
    mov ah, 86h
    int 15h

    call limpatela ;limpo a tela para ir para o kernel

    mov ax, 0x7e0 ;0x7e0<<1 = 0x7e00 (início de kernel.asm)
    mov es, ax
    xor bx, bx    ;posição es<<1+bx

    jmp reset

reset:
    mov ah, 00h ;reseta o controlador de disco
    mov dl, 0   ;floppy disk
    int 13h

    jc reset    ;se o acesso falhar, tenta novamente

    jmp load

load:
    mov ah, 02h ;lê um setor do disco
    mov al, 20  ;quantidade de setores ocupados pelo kernel
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 3
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load     ;se o acesso falhar, tenta novamente

    jmp 0x7e00  ;pula para o setor de endereco 0x7e00 (start do boot2)