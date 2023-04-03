.model small
.stack 100h
.data
    string db 100 dup('$')
    
    inmsg db "Enter string: $"
    outmsg db "Longest sequence in alphabetic order: $"
    
    l dw ?
    r dw ?
    fl dw ?
    fr dw ?
    prv db ?
    max_len dw 0
    flag db 0
    

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
    ;lea dx, string
    ;mov ah, 9
    ;int 21h 
    lea si, string
    mov l, si
    mov r, si
    mov fl, si
    mov fr, si
    mov cx, 1
    worker:
        mov dl, [si]
        inc si
        mov bl, [si]
        cmp bl, '$'
        je final_chk
         
        cmp bl, dl
        jge include
        jl exclude
        include:
            inc cx
            mov r, si
            jmp worker
        final_chk:
            mov flag, 1
        exclude:
             cmp cx, max_len
             jg big_found
             jle not_found
             big_found:
                mov max_len, cx
                mov ax, l
                mov fl, ax
                mov ax, r
                mov fr, ax
                mov l, si
                mov r, si
                mov cx, 1
                cmp flag, 1
                je output
                jmp worker
             not_found:
                mov l, si
                mov r, si
                mov cx, 1
                cmp flag, 1
                je output
                jmp worker
    
    output:
        lea dx, outmsg
        mov ah, 9
        int 21h
    
        mov si, fl
        print:
            mov dl, [si]
            mov ah, 2
            int 21h
            inc si
            cmp si, fr
            jg exit
            jmp print
    
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