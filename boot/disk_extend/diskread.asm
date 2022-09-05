; dl = drivenumber (starts with 0)
; ch = cylinder (starts with 0)
; dh = head (starts with 0)
; cl = sector (starts with 1)
; al = number of sectors to read
; es:bx = location to load it
;   f.e. :
;     - es = 0
;     - bx = 0x7e00


load:
    clc
    push ax
    mov ah, 2
    int 13h
    jc diskerror
    pop ax
    jmp bx

diskerror:
    ;mov bx, diskerrorstring
    ;call print
    mov bx, diskerrorstring
    call print
    cli
    hlt

diskerrorstring:    db "An error occurred while starting the OS:", 0x0a, 0x0d, "    Diskerrorcode: 0x01", 0