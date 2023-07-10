.MODEL SMALL

.STACK 100H

.DATA

NEWLINE DB 0AH,0DH,'$'

.CODE

MAIN PROC   
    
    MOV AX, DATA
    MOV DS, AX
    
    MOV CX, 0
    MOV AH, 1
    
    START_INPUT: 
        INT 21H
        CMP AL, 0DH
        JE END_INPUT
        PUSH AX
        INC CX
        JMP START_INPUT   
        
    END_INPUT:
        
    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H
    
    JCXZ EXIT
     
    MOV AH, 2
    
    OUTPUT:
         POP DX
         INT 21H
         LOOP OUTPUT
    
    EXIT:
        
END MAIN