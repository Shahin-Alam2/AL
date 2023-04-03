.model small
.stack 100h
.data
    string db 100 dup('$')
    
    inmsg DB "(single decimal digits from 0 to 9): $"
    msg db "Sorted Ascending:  $"
    msg1 db "Sorted Descending: $"
    
    n dw ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, inmsg
    mov ah, 9
    int 21h
    
    mov si, 0
    input:
        mov ah, 1
        int 21h
        cmp al, 13
        je break
        mov string[si], al
        inc si
        jmp input
     
    break:
    call new_line
    mov n, si
    sub n, 1
    
    mov cx, n
    outter:
        mov si, 0
        mov di, 1
        inner:
            mov al, string[si]
            cmp al, string[di]
            jl skip
            
            xchg al, string[di]
            mov string[si], al
            
            skip:
                cmp di, n
                je end_inner
                inc di
                inc si
                jmp inner
            end_inner:
                loop outter
        
        
                       
    
    end:
       lea dx, msg
       mov ah, 9
       int 21h
       lea dx, string
       mov ah, 9
       int 21h
       call new_line
       
       lea dx, msg1
       mov ah, 9
       int 21h 
       
       mov si, n
       mov cx, si
       inc cx
       output:
            mov dl, string[si]
            mov ah, 2
            int 21h
            dec si
            loop output    
       
    exit:
        mov ah, 4ch
        int 21h
    main endp

new_line proc
	 mov  ah, 2
	 mov  dl, 10
	 int  21h
	 mov  dl, 13
	 int  21h
	 ret
new_line endp

end main