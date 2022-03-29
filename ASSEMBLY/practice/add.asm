.model small
.stack 100h

.data

a db 3 ;first number
b db 5 ;second number
.code
start:
    
    mov ax, @data
    mov ds, ax
    
    mov bl, a
    mov dl, b
    add dl, bl
    add dl, 48
    
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h

end start