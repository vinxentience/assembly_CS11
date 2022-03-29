.model small
.stack 100h

.data
;syntax for initialization of variable
;variablename type value or default initialization
var db "Hello World$"
.code
start:
    
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    mov dx, offset var
    int 21h
    
    mov ah, 4ch
    int 21h

end start