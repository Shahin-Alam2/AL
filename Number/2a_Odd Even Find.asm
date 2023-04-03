.model small
.stack 100h
.data
    inmsg DB "Enter number between 0-9 : $"
    
    odd DB "ODD$"
    even DB "EVEN$"
        
    n DB ?
    dv DB 2
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, inmsg
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h 
    sub al, 48
    
    div dv
    cmp ah, 0
    jz evenn
    
    call new_line
    lea dx, odd
    jmp print
    
    evenn:
        call new_line
        lea dx, even
        jmp print
    
    print:   
    mov ah, 9
    int 21h
    
    exit:
        mov ah, 4ch
        int 21h
    
new_line proc
	 mov  ah, 2
	 mov  dl, 10
	 int  21h
	 mov  dl, 13
	 int  21h
	 ret
new_line endp

end main