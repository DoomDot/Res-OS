; string in bx

print:
    push ax
    mov ah, 0eh
    print.mloop:
        mov al, [bx]
        int 0x10
        inc bx
        cmp [bx], byte 0
        je print.return
        jmp print.mloop
    print.return:
        pop ax
        ret


; byte in dl
print_byte_num:
    push ax
    push bx
    push cx
    push dx

    mov ah, 0x00
    mov al, dl
    mov bl, 100d
    div bl
    mov dl, ah
    mov ah, 0x0e
    add al, '0'
    int 0x10

    mov ah, 0x00
    mov al, dl
    mov bl, 10d
    div bl
    mov dl, ah
    mov ah, 0x0e
    add al, '0'
    int 0x10

    mov ah, 0x00
    mov al, dl
    mov bl, 1d
    div bl
    mov ah, 0x0e
    add al, '0'
    int 0x10

    pop dx
    pop cx
    pop bx
    pop ax
    ret