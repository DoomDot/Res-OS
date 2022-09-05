[bits 16]
[org 0x7c00]

mov bp, 0x7c00
mov sp, bp

mov [bootdisk], dl

; dl = drivenumber (starts with 0)
; ch = cylinder (starts with 0)
; dh = head (starts with 0)
; cl = sector (starts with 1)
; al = number of sectors to read
; es:bx = location to load it
;   f.e. :
;     - es = 0
;     - bx = 0x7e00

mov dl, [bootdisk]
mov ch, 0
mov dh, 0
mov cl, 2
mov al, 8
mov bx, 0x7e00
call load

jmp $

%include "16bit/base/print.asm"
%include "16bit/base/keyboard.asm"
%include "boot/disk_extend/diskread.asm"

bootdisk:   db 0

times 510-($-$$) db 0
dw 0xaa55