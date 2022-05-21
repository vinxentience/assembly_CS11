include \masm32\include\masm32rt.inc

.data
w32fd WIN32_FIND_DATA<>
file_handle HANDLE ?
line_break db 13,10,0
file_ext db "*.*"

title_message db 13, 10, "==== TEXT VIEWER APPLICATION ====", 0
option1 db 13, 10, "[1] Read File", 0
option1_value db "1", 0
option2 db 13, 10, "[2] Write File", 0
option2_value db "2", 0
option3 db 13, 10, "[3] Exit", 0
option3_value db "3", 0

input_prompt db 13, 10, "Input option: ", 0
string db 13, 10, 50 dup(?)


filename db 256 dup(?)
file_contents db 256 dup(?)
butes_read db ?

.code

start:

    push offset filename
    push 1
    call GetCL

    push offset title_message
    call StdOut
    push offset option1
    call StdOut
    push offset option2
    call StdOut
    push offset option3
    call StdOut
    
    create_file:
    push 0
    push FILE_ATTRIBUTE_NORMAL
    push OPEN_EXISTING
    push 0
    push 0
    push FILE_READ_DATA
    push offset filename
    call CreateFileA
    mov file_handle, eax
    
read_file:
    push 0
    push offset butes_read
    push 256
    push offset file_contents
    push file_handle
    call ReadFile

    invoke StdOut, offset file_contents
    
close_file_handle:
    push file_handle
    call CloseHandle

exit
end start
    