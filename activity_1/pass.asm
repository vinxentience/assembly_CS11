.model small
.stack 100h
.data
    PASSWORD DB 'password'
    LEN EQU ($-PASSWORD)
    message DB '============ Enter password ============', 0ah, '$'
    correct DB 'Correct password  $'
    incorrect DB 'Incorrect password $'
    INST DB 10 DUP(0)
.code
start:
        ;this points to the .data segment in order to access the global variables declared
        MOV AX, @data
        MOV DS,AX
        
        ;setting background color
        mov ah, 09h
        mov cx, 1000h
        mov al, 20h
        mov bl, 67h  ; This is (6) Yellow & (7) White.
        int 10h
        
        ;setting cursor position (Centering the message)
        mov ah,02h  
        mov dh,10    ;row 
        mov dl,20     ;column
        int 10h
        
        ;prompting a message
        LEA DX, message ;asks user to enter password / uses load effective address to access the variable message
        MOV AH,09H
        INT 21H
        MOV SI,00
        
        ;setting cursor position (Centering the asterisk)
        mov ah,02h  
        mov dh,11    ;row 
        mov dl,35     ;column
        int 10h
        
    UP1:
        MOV AH,08H
        INT 21H
        CMP AL,0DH
        JE DOWN ;jump to down label if equal
        MOV [INST+SI],AL
        MOV DL,'*' ;returns character as *
        MOV AH,02H
        INT 21H
        INC SI
        JMP UP1 ;jump to up1 label         
    DOWN:
        MOV BX,00
        MOV CX,LEN
    CHECK:
        MOV AL,[INST+BX]
        MOV DL,[PASSWORD+BX]
        CMP AL, DL 
        
        JNE FAIL ;if string is not equal then go to fail label
        
        INC BX
        LOOP CHECK ;if password is incorrect loop back to check label
        
        ;setting cursor position (Centering the correct message)
        mov ah,02h  
        mov dh,12    ;row 
        mov dl,31     ;column
        int 10h
        
        LEA DX, correct ;displays correct message
        MOV AH,09H
        INT 21H
        JMP FINISH ;if password is correct jump to finish label
    FAIL:
        
        LEA DX, incorrect
        MOV AH,09H
        INT 21H
        
        MOV ax, 3 ;Clear screen
        INT 10h

        JMP start ;jump back to start to input again

    FINISH:
        mov ah, 4ch ;exit program
        int 21h
END start
END