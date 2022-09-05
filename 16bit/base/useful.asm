; dh = x
; dl = y
set_cursor_pos:
    mov ah, 2
    mov bh, 0 ; page
    int 0x10
    ret

; bl = colour
clear:
    mov dl, 0
    mov dh, 0
    call set_cursor_pos
    mov ah, 09h
    mov cx, 3000
    mov al, 20h
    int 0x10
    ret

logo: db " ____              ___  ____", 0x0a, 0x0d, "|  _ \ ___  ___   / _ \/ ___|", 0x0a, 0x0d, "| |_) / _ \/ __| | | | \___ \", 0x0a, 0x0d, "|  _ <  __/\__ \ | |_| |___) |", 0x0a, 0x0d, "|_| \_\___||___/  \___/|____/", 0