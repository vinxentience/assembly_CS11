.model small
.stack 100h

.data
    file_name db 'C:\Users\DEPED-TAGUM\Desktop\readme.txt'
    msg db 'Welcome to Tutorials Point'
    len equ  $-msg

    msg_done db 'Written to file', 0xa
    len_done equ $-msg_done
.code
start:
  MOV AX, @DATA
  MOV DS, AX
  
  ;create the file
   mov  eax, 8
   mov  ebx, file_name
   mov  ecx, 0777        ;read, write and execute by all
   int  21H    
   
   mov [fd_out], eax

    ; write into the file
   mov  edx,len          ;number of bytes
   mov  ecx, msg         ;message to write
   mov  ebx, [fd_out]    ;file descriptor 
   mov  eax,4            ;system call number (sys_write)
   int  21H             ;call kernel
   
    ; close the file
   mov eax, 6
   mov ebx, [fd_out]
    
   ; write the message indicating end of file write
   mov eax, 4
   mov ebx, 1
   mov ecx, msg_done
   mov edx, len_done
   int  21H
    
   ;open the file for reading
   mov eax, 5
   mov ebx, file_name
   mov ecx, 0             ;for read only access
   mov edx, 0777          ;read, write and execute by all
   int  21H
    
   mov  [fd_in], eax
    
   ;read from file
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, info
   mov edx, 26
   int 21H
    
   ; close the file
   mov eax, 6
   mov ebx, [fd_in]
   int  21H    
    
   ; print the info 
   mov eax, 4
   mov ebx, 1
   mov ecx, info
   mov edx, 26
   int 21H
       
   mov  eax,1             ;system call number (sys_exit)
   int  21H ;call kernel
   
end start