shell_entry:
    mov bl, 15
    call clear
    mov bx, logo
    call print
    mov bx, newline
    call print
    mov bx, newline
    call print
    mov bx, line_beginning
    call print
    call command_entry

command_entry:
    ; initialize pointer to current character in the command variable
    mov si, word command
    ; si = command pointer
    ; cx = command char counter
    ; set cx to 0
    mov cx, 0
    ; enter mainloop
    command_entry.mloop:
        ; wait for input and save it to al
        call wait_for_key
        ; see if it's a newline
        cmp al, byte 0x0d
        ;  jump to a handler method if yes
        je command_entry.handle_newline
        cmp al, byte 0x08
        je command_entry.handle_backspace
        ; print character
        mov ah, 0eh
        int 10h
        ; move character into command variable
        mov [si], al
        inc si
        ; increment char command counter
        inc cx
        ; jmp to mainloop
        jmp command_entry.mloop
    ret
    ; handler method for newline
    command_entry.handle_newline:
        ; update pointer to current character in the command variable
        mov si, word command
        ; print newline
        mov bx, newline
        call print
        ; output the command
        mov bx, command
        call print
        ; print newline
        mov bx, newline
        call print
        ; print line beginning
        mov bx, line_beginning
        call print
        ; jump to main loop
        jmp command_entry.mloop
    command_entry.handle_backspace:
        dec si
        mov [si], byte 0
        mov ah, 0eh
        int 10h
        mov al, " "
        mov ah, 0eh
        int 10h
        mov al, byte 0x08
        mov ah, 0eh
        int 10h
        jmp command_entry.mloop



; needed
line_beginning: db ">>>", 0
command: times 100 db 0