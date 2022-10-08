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
    mov [command_char_pointer], word command
    ; enter mainloop
    command_entry.mloop:
        ; wait for input and save it to al
        call wait_for_key
        ; see if it's a newline
        cmp al, byte 0x0d
        ;  jump to a handler method if yes
        je command_entry.handle_newline
        ; print character
        mov ah, 0eh
        int 10h
        ; move character into command variable
        mov [command_char_pointer], al
        inc word [command_char_pointer]
        ; jmp to mainloop
        jmp command_entry.mloop
    ret
    ; handler method for newline
    command_entry.handle_newline:
        mov bx, newline
        call print
        mov bx, command
        call print
        mov bx, newline
        call print
        mov bx, line_beginning
        call print
        jmp command_entry.mloop



; needed
line_beginning: db ">>>", 0
command: times 100 db 0
command_char_pointer:   dw 0