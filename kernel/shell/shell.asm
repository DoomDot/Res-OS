shell_entry:
    mov bl, 31
    call clear
    mov bx, logo
    call print
    mov bx, newline
    call print
    mov bx, newline
    call print
    mov bx, line_beginning
    call print

command_entry:
    


; needed
line_beginning: db ">>>", 0
command: times 100 db 0