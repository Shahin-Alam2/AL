.model small
.stack 100h
.data
    string db 100 dup('$')
    
    inmsg db "Enter string: $"
    msg0 db "Spaces:$"
    msg1 db "Vowels:$"
    msg2 db "Consonants:$"
    msg3 db "Numbers:$"
    
    space_cnt db '0'
    vowel_cnt db '0'
    number_cnt db '0'
    consonants_cnt db '0'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, inmsg
    mov ah, 9
    int 21h
    
    lea si, string
    input:
        mov ah, 1
        int 21h
        cmp al, 13
        je break
        mov [si], al
        inc si
        jmp input
     
    break:
    call new_line
    
    lea si, string
    repeat:
        mov dl, [si]
        cmp dl, '$'
        je end
        
        inc si
        
        cmp dl, ' '
        je space
        
        cmp dl, 'a'
        je vowel
        cmp dl, 'e'
        je vowel
        cmp dl, 'i'
        je vowel
        cmp dl, 'o'
        je vowel
        cmp dl, 'u'
        je vowel
        
        cmp dl, 'a'
        jge again
        
        cmp dl, '0'
        jge next
        
        
        next:
           cmp dl, '9'
           jle number
         
        again:
           cmp dl, 'z'
           jle consonants
        
        jmp repeat
         
        space:
            inc space_cnt
            jmp repeat
        vowel:
            inc vowel_cnt
            jmp repeat
        number:
            inc number_cnt
            jmp repeat
        consonants:
            inc consonants_cnt
            jmp repeat
                       
    
    end:
       lea dx, msg0
       mov ah, 9
       int 21h
       mov ah, 2
       mov dl, space_cnt
       int 21h
       call new_line
       
       lea dx, msg1
       mov ah, 9
       int 21h
       mov ah, 2
       mov dl, vowel_cnt
       int 21h
       call new_line
       
       lea dx, msg2
       mov ah, 9
       int 21h
       mov ah, 2
       mov dl, consonants_cnt
       int 21h
       call new_line
       
       lea dx, msg3
       mov ah, 9
       int 21h
       mov ah, 2
       mov dl, number_cnt
       int 21h 
       call new_line
       
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