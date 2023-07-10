.MODEL SMALL

.STACK 100H

.DATA
 
NEWLINE DB 0AH,0DH,'$'

.CODE

MAIN PROC  
    
    MOV AX, DATA
    MOV DS, AX
                                             
    MOV AH, 1
    INT 21H
    SUB AL, '0'      
    MOV BL, AL
              
    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H  
    
    MOV AL, 1 
     
    FACTORIAL:
        CMP BL, 0
        JE OUTPUT 
        MUL BL
        DEC BL
        JMP FACTORIAL
    
    OUTPUT: 
        ADD AL, '0'
        MOV DL, AL
        MOV AH, 2
        INT 21H

END MAIN  