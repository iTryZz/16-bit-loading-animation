; This is literal garbage, but hey, it looks nice, so why not?

; [ org 0x7c00 ]
; mov si, string
; call animate

print_animation:
    pusha
    string_loop:
        mov al, [ si ]
        cmp al, 0 ; Check for EOF/NULL Terminator
        jne print_char
        popa
        ret
    print_char_animation:
        mov ah, 0x0e
        int 0x10
        add si, 1
        jmp string_loop


animate:
    call no_cursor
    call print
    mov ah, 0x0e
    mov al, '|'
    int 0x10
    hlt ; Delay the ammount of time it takes to print a character so that the stuff isn't spammed
    call clear
    call forward_slash
    jmp animate ; This is the while True loop in this case

forward_slash:
    call no_cursor
    call print
    mov ah, 0x0e
    hlt
    ; hlt
    mov al, '/'
    int 0x10
    call clear
    call dash
    ret

dash:
    call no_cursor
    call print
    mov ah, 0x0e
    hlt
    ; hlt
    mov al, '-'
    int 0x10
    call clear
    call back_slash
    ret

back_slash:
    call no_cursor
    call print
    mov ah, 0x0e
    ; hlt
    hlt
    mov al, '\'
    int 0x10
    call clear
    ret

clear:
    call no_cursor
    pusha
    hlt
    hlt
    hlt
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    popa
    ret

; Completly hide the cursor for a smooth animation
no_cursor:
    pusha
    mov ah, 0x01
    mov ch, 0x3f
    int 0x10
    popa
    ret

string: db "Booting into BreezeOS...", 0

times 510-($-$$) db 0
dw 0xaa55
