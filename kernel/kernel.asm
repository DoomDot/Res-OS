[bits 16]
[org 0x7e00]


mov bx, loadsuccess
call print
call shell_entry
; call prepare_video_mode
; mov ax, 13h
; call change_video_mode
; call epilepsy


jmp $

%include "16bit/base/useful.asm"
%include "16bit/base/print.asm"
%include "kernel/video_mode/video_mode.asm"
%include "kernel/drawing/draw.asm"
%include "kernel/drawing/images.asm"
%include "16bit/errors/res.asm"
%include "16bit/base/keyboard.asm"
%include "kernel/shell/shell.asm"

loadsuccess:    db "Successfully claimed 4096 bytes of data.", 0

times 4096-($-$$) db 0
