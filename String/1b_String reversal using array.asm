.model small
.stack 100h
.data
       array      db 100 dup('$')
       len        dw 0
       input_msg  db "input :$"
       output_msg db "output:$"

.code
main proc
                mov  ax, @data
                mov  ds, ax
      
      
                lea  dx, input_msg
                mov  ah,9
                int  21h
         
       ;loop input
                mov  si, offset array
                inc  si
       repeat:  
                mov  ah, 1
                int  21h
                cmp  al, 13
                je   break
         
                mov  array[si], al
                inc  si
                inc  len
                jmp  repeat
  
       break:   
       ;new line
                call new_line
      
                lea  dx, output_msg
                mov  ah,9
                int  21h
       ;loop reverse output
                mov  si, offset array
                add  si, len
       output:  
                mov  dl, [si]
                cmp  dl, '$'
                je   stop
         
                mov  ah, 2
                int  21h
        
                dec  si
                jmp  output

       stop:    
                mov  ah, 4ch
                int  21h

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
