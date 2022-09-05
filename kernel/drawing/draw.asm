; x coordinate in cx
; y coordinate in dx
; color in al
; page number in bh

draw_pixel:
    mov ah, 0x0c
    int 0x10
    ret