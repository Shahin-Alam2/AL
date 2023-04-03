.model small
.stack 100h
.data
    string0 db 100 dup('$')
    string1 db 100 dup('$')
    inmsg0 db "1st string: $"
    inmsg1 db "2nd string: $"
    msg0 db "Found$"
    msg1 db "Not Found$"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, inmsg0
    mov ah, 9
    int 21h
    
    lea si, string0
    input0:
        mov ah, 1
        int 21h
        cmp al, 13
        je break0
        mov [si], al
        inc si
        jmp input0
     
    break0:
        call new_line
    
    lea dx, inmsg1
    mov ah, 9
    int 21h
    
    lea si, string1
    input1:
        mov ah, 1
        int 21h
        cmp al, 13
        je break1
        mov [si], al
        inc si
        jmp input1
     
    break1:
        call new_line 
    
    lea si, string0
    outer_loop:
        lea di, string1
        push si
        
        inner_loop:
            mov dh, [si]
            mov dl, [di]
            inc si
            inc di
            cmp dl, '$'
            je found
            cmp dh, '$'
            je not_found
            cmp dh, dl
            je inner_loop
            jne update_outer_idx
        
         update_outer_idx:
            pop si
            inc si
            jmp outer_loop
           
     
     found:
         lea dx, msg0
         mov ah, 9
         int 21h
         jmp exit 
     
     not_found:
         lea dx, msg1
         mov ah, 9
         int 21h
         jmp exit 
    
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