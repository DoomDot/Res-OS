prepare_video_mode:
    cli
    push 0x0A000
    pop es
    xor di, di
    xor ax, ax

; video mode in ax

change_video_mode:
    int 0x10
    ret