include \masm32\include\masm32rt.inc

includelib irvine32.lib
Include MACROS.inc

.data
buffer BYTE BUFFER_SIZE DUP(?)
filename    BYTE 80 DUP(0)
fileHandle  HANDLE ?


.code
start:

    
    
    ; Let user input a filename.
mWrite "Enter an input filename: "
mov edx,OFFSET filename
mov ecx,SIZEOF filename
call    ReadString

; Open the file for input.
mov edx,OFFSET filename
call    OpenInputFile
mov fileHandle,eax

exit
end start


