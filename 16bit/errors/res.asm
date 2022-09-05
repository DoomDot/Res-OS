global error

res_back:
    mov dl, 0
    mov dh, 0
    call set_cursor_pos
    mov ah, 09h
    mov cx, 3000
    mov al, 20h
    mov bl, 71
    int 0x10
    ret


res:
    push dx
    push cx
    push bx
    push ax
    call res_back
    mov bx, emoticon
    call print
    jmp res.test_cause

    res.errc:
        mov bx, newline
        call print
        mov bx, emoticon_2
        call print
        jmp res.mloop

    res.test_cause:
        mov al, [error]
        cmp al, byte 0
        je  res.perror0
        cmp al, byte 1
        je res.perror1
        jmp res.perror255
    
    res.mloop:
        mov ah, 00h
        int 0x16
        cmp al, 'a'
        je res.r_dump_test
        cmp al, 'b'
        je res.reboot
        cmp al, 'c'
        je res.east_egg
        jmp res.mloop
    
    res.r_dump_test:
        cmp [r_dumped], byte 0
        je res.r_dump
        jmp res.mloop

    res.r_dump:
        ; formatting 1
        mov bx, newline
        call print
        ; ah
        mov bx, rdump_ah
        call print
        pop ax
        mov dl, ah
        call print_byte_num
        mov bx, newline
        call print
        ; al
        mov bx, rdump_al
        call print
        mov dl, al
        call print_byte_num
        mov bx, newline
        call print
        ; bh
        mov bx, rdump_bh
        call print
        pop ax
        mov dl, ah
        call print_byte_num
        mov bx, newline
        call print
        ; bl
        mov bx, rdump_bl
        call print
        mov dl, al
        call print_byte_num
        mov bx, newline
        call print
        ; ch
        mov bx, rdump_ch
        call print
        pop ax
        mov dl, ah
        call print_byte_num
        mov bx, newline
        call print
        ; cl
        mov bx, rdump_cl
        call print
        mov dl, al
        call print_byte_num
        mov bx, newline
        call print
        ; dh
        mov bx, rdump_dh
        call print
        pop ax
        mov dl, ah
        call print_byte_num
        mov bx, newline
        call print
        ; dl
        mov bx, rdump_dl
        call print
        mov dl, al
        call print_byte_num
        ; formatting stuff 2
        mov bx, newline
        call print
        ; loop to mloop
        mov bx, emoticon_3
        call print
        mov [r_dumped], byte 1
        jmp res.mloop
    
    res.reboot:
        int 19h
    
    res.east_egg:
        mov [error], byte 1
        call res
    
    res.perror0:
        mov bx, errorcode0
        call print
        jmp res.errc

    res.perror1:
        mov bx, errorcode1
        call print
        jmp res.errc
        
    res.perror255:
        mov bx, errorcode255
        call print
        jmp res.errc
        


; emoticons
emoticon:   db " ____              ___  ____", 0x0a, 0x0d, "|  _ \ ___  ___   / _ \/ ___|", 0x0a, 0x0d, "| |_) / _ \/ __| | | | \___ \", 0x0a, 0x0d, "|  _ <  __/\__ \ | |_| |___) |", 0x0a, 0x0d, "|_| \_\___||___/  \___/|____/", 0x0a, 0x0a, 0x0d, "Res OS encountered a problem has stopped itself to protect this PC, ", 0x0a, 0x0d, "your files and itself!!!", 0x0a, 0x0a, 0x0d, "Errorcode: ", 0
emoticon_2: db 0x0a, 0x0d, "press 'a' to make a reg dump...", 0x0a, 0x0d, "press 'b' to reboot...", 0x0a, 0x0d, "press 'c' to destroy your computer...", 0
emoticon_3: db 0x0a, 0x0d, "press 'b' to reboot...", 0x0a, 0x0d, "press 'c' to destroy your computer...", 0

; strings for dumpimg
rdump_ah:   db "ah = ", 0
rdump_al:   db "al = ", 0
rdump_bh:   db "bh = ", 0
rdump_bl:   db "bl = ", 0
rdump_ch:   db "ch = ", 0
rdump_cl:   db "cl = ", 0
rdump_dh:   db "dh = ", 0
rdump_dl:   db "dl = ", 0

; useful
newline:    db 0x0a, 0x0d, 0

; errorcodes
errorcode0: db "bad_read", 0
errorcode1: db "user_stupidity", 0
errorcode255:   db "unspecified_error", 0

; needed
error:  db 255
r_dumped:   db 0