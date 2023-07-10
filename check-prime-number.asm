.MODEL SMALL

.STACK 100H

.DATA
 
PRIME_MSG DB 0AH,0DH,'PRIME','$'   
NOT_PRIME_MSG DB 0AH,0DH,'NOT PRIME','$' 

.CODE

MAIN PROC  
    
    MOV AX, DATA
    MOV DS, AX
      
    MOV AH, 1
    INT 21H      
    SUB AL, '0'  
    MOV AH, 0
    MOV CX, AX
    MOV BL, AL
    DEC BL
    
    CHECK_PRIME: 
        CMP BL, 1
        JLE EXIT_CHECK_PRIME:
        DIV BL
        CMP AH, 0
        JE PRINT_NOT_PRIME 
        MOV AX, CX
        DEC BL
        JMP CHECK_PRIME 
        
    EXIT_CHECK_PRIME:    
           
    MOV AH, 9
    LEA DX, PRIME_MSG
    INT 21H
    JMP EXIT
        
    PRINT_NOT_PRIME:
        MOV AH, 9
        LEA DX, NOT_PRIME_MSG
        INT 21H    

    EXIT:
             
END MAIN 