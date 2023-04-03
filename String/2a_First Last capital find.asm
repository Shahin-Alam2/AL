.model small
.stack 100h
.data
	string        db 100 dup('$')
	inmsg db "Enter string: $"
	first_capital db 'Z'
	last_capital  db 'A'
	msg1          db "No Capitals$"
	msg2          db "First Capital: $"
	msg3          db "Last Capital: $"
	flag          db 0
 
.code
main proc
	             mov  ax, @data
	             mov  ds, ax
	             
	             lea dx, inmsg
                 mov ah, 9
                 int 21h
    
	             mov  si, offset string
	Repeat:      
	             mov  ah, 1
	             int  21h
	             cmp  al, 13
	             je   break
	             mov  string[si], al
	             inc  si
	             jmp  Repeat
    	
    
	;mov dl, first_capital
	;int 21h
    
	break:   
	             call new_line
	             mov  si, offset string
	Repeat1:     
	             mov  bl, [si]
	             cmp  bl, '$'
	             je   last_verdict
	             inc  si
   	 
	             cmp  bl, 'A'
	             jge  inner
	             jmp  Repeat1
	    inner:       
	             cmp  bl, 'Z'
	             jle  found
	             jmp  Repeat1
	        found:       
	             cmp  bl, first_capital
	             jl   do
	             jmp  once
	            do:          
	                mov  first_capital, bl
	                mov  flag, 1
	            once:        
	                cmp  bl, last_capital
	                jg   do1
	                jmp  Repeat1
	                    do1:         
	                        mov  last_capital, bl
	                        mov  flag, 1
	                        jmp  Repeat1
    
	last_verdict:
	             cmp  flag, 1
	             je   valid_output
	             jne  no_output
	valid_output:
	             lea  dx, msg2
	             mov  ah, 9
	             int  21h
	             mov  ah, 2
	             mov  dl, first_capital
	             int  21h
    
	             call new_line
    
	             lea  dx, msg3
	             mov  ah, 9
	             int  21h
	             mov  ah, 2
	             mov  dl, last_capital
	             int  21h
	             jmp  stop
   	 
	no_output:   
	             lea  dx, msg1
	             mov  ah, 9
	             int  21h
	             jmp  stop
    
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
