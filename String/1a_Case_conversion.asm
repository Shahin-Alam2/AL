.model small
.stack 100h
.data
    
        array      db 100 dup('$')
        input_msg  db "input  :$"
        output_msg db "output:$"
.code

main proc
     
                 mov  ax, @data
                 mov  ds, ax
     
        ;input msg print
                 lea  dx, input_msg
                 mov  ah, 9
                 int  21h
     
        ;taking input via loop
                 mov  si, offset array
        input:   
                 mov  ah, 1
                 int  21h
                 cmp  al, 13
                 je   break
                 mov  array[si], al
                 inc  si
                 jmp  input
        
        break:   
        ;new line
                 call new_line
      
        ;output msg print
                 lea  dx, output_msg
                 mov  ah, 9
                 int  21h
        ;output processing [65-90..A-Z][97-122..a-z]
                 mov  cx, 5
                 mov  si, offset array
        output:  
                 mov  bl, [si]
                 cmp  bl, '$'
                 je   stop
                 cmp  bl, 41h
        ;check if greater than or equal to 65
                 jge  inner
                 jmp  print
        inner:   
                 cmp  bl, 7ah
        ;check if less than or equal to 122
                 jle  convert
                 jmp  print
        convert: 
                 cmp  bl, 5ah
        ;check if less than or equal to 90
                 jle  tolower
                 cmp  bl, 61h
        ;check if greater than or equal to 97
                 jge  toupper
                 jmp  print
        tolower: 
                 add  bl, 20h
                 jmp  print
        toupper: 
                 sub  bl, 20h
                 jmp  print
                    
        print:   
                 mov  dl, bl
                 mov  ah, 2
                 int  21h
                 inc  si
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



