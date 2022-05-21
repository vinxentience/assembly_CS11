include \masm32\include\masm32rt.inc

.data

file_handle HANDLE ?

title_message db 13, 10, "==== TEXT VIEWER APPLICATION ====", 0
option1 db 13, 10, "[1] Read File", 0
option1_value db "1", 0
option2 db 13, 10, "[2] Write File", 0
option2_value db "2", 0
option3 db 13, 10, "[3] Delete File", 0
option3_value db "3", 0
option4 db 13, 10, "[4] Exit", 0
option4_value db "4", 0

input_prompt db 13, 10, "Input option: ", 0
string db 13, 10, 50 dup(?)


filename db 256 dup(?)
file_contents db 13,10, 256 dup(?)
butes_read db ?

input_prompt_text db 13, 10, "Input data to write: ", 0
write_to_file_buffer db 256 dup(?)

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
    push offset option4
    call StdOut

    push offset input_prompt
    call StdOut
    push 50
    push offset string
    call StdIn

    mov al, string
    
    cmp al, option1_value
    je call_read
    
    cmp al, option2_value

    
    je call_write
    
    cmp al, option3_value
    je call_delete
    
    cmp al, option4_value
    je call_exit

call_read:
    call READING
    jmp start
    
call_write:

    call WRITING
    jmp start

call_delete:
    call DELETING
    jmp finish

call_exit:
    jmp finish

exit

READING PROC
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
RET
READING ENDP

DELETING PROC

delete_file:
    push offset filename
    call DeleteFileA
    
RET
DELETING ENDP

WRITING PROC

    push offset input_prompt_text
    call StdOut
    push 50
    push offset write_to_file_buffer
    call StdIn
    
create_file:
    push 0
    push FILE_ATTRIBUTE_NORMAL
    push OPEN_EXISTING
    push 0
    push 0
    push FILE_SHARE_WRITE
    push offset filename
    call CreateFileA
    mov file_handle, eax

set_file_pointer:
    push FILE_END
    push 0
    push 0
    push file_handle
    call SetFilePointer

write_txt_file:
    push offset write_to_file_buffer
    call lstrlen

    push 0
    push 0
    push eax
    push offset write_to_file_buffer
    push file_handle
    call WriteFile

close_file_handle:
    push file_handle
    call CloseHandle
        
RET
WRITING ENDP

finish:
    end start
    




