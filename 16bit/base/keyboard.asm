; bl key to compare
compare_key:
    compare_key.mloop:
        mov ah, 00h
        int 16h
        cmp al, bl
        je compare_key.return
        jmp compare_key.mloop
    compare_key.return:
        ret


; output -> key in al
wait_for_key:
    mov ah, 00h
    int 16h
    ret
    
