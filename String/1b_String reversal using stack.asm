.model small
.stack 100h
.data
       input_msg  db "input :$"
       output_msg db "output:$"

.code
main proc
                 mov  ax, @data
                 mov  ds, ax
      
      
                 lea  dx, input_msg
                 mov  ah,9
                 int  21h
  
                 mov  ax, '$'
                 push ax
       ;loop input
       repeat:   
                 mov  ah, 1
                 int  21h
                 cmp  al, 13
                 je   now_check
        
                 push ax
                 jmp  repeat
   
       now_check:
       ;new line
                 call new_line
      
                 lea  dx, output_msg
                 mov  ah,9
                 int  21h
  
       ;loop reverse output
       output:   
                 pop  dx
                 cmp  dx, '$'
                 je   stop
                 mov  ah, 2
                 int  21h
        
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
