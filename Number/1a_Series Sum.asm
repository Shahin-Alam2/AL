.model small
.stack 100h
.data
    inmsg DB "Enter number between 1-3 : $"
    outmsg DB "Summation: $"   
    
    n DB ?
    d DB 2
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
    
    mov n, al
    inc n
    mul n
    div d
    mov n, al
    
    call new_line
    
    lea dx, outmsg
    mov ah, 9
    int 21h
    mov dl, n 
    add dl, 48
    mov ah, 2
    int 21h
    
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