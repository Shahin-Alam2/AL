.model small
.stack 100h
.data
    inmsg DB "Enter number between 0-9 : $"
    
    primee DB "Prime$"
    not_primee DB "Not Prime$"
        
    n DB ?
    flag DB 0
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
    
    cmp n, 2
    jl not_prime
    
    mov dl, 2
    repeat:
        cmp dl, n
        jge prime
        
        mov al, n
        mov ah, 0
        div dl
        cmp ah, 0
        je not_prime
        
        inc dl
        jmp repeat
    
    not_prime:
        call new_line
        lea dx, not_primee
        mov ah, 9
        int 21h
        jmp exit
        
    prime:
        call new_line
        lea dx, primee
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