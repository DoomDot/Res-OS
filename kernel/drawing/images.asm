full_screen_palet:
    mov cx, 0
    mov dx, 0
    mov al, 0x00
    mov bh, 0x0
    full_screen_palet.mloop:
        call draw_pixel
        inc cx
        mov dx, 1
        inc al
        jmp full_screen_palet.mloop

bsod:
    mov cx, 0
    mov dx, 0
    mov al, 0x20
    mov bh, 0x0
    bsod.mloop:
        call draw_pixel
        inc cx
        jmp bsod.mloop

epilepsy:
    mov cx, 0
    mov dx, 0
    mov al, 0x20
    mov bh, 0x0
    epilepsy.mloop:
        call draw_pixel
        inc cx
        cmp cx, word 0xfa00
        je epilepsy.c_color
        jmp epilepsy.mloop
    epilepsy.c_color:
        inc al
        jmp epilepsy.mloop