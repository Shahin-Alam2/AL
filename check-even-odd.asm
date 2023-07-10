.MODEL SMALL

.STACK 100H

.DATA
 
EVEN_MSG DB 0AH,0DH,'EVEN','$'   
ODD_MSG DB 0AH,0DH,'ODD','$'

.CODE

MAIN PROC  
    
    MOV AX, DATA
    MOV DS, AX
      
    MOV AH, 1
    INT 21H      
    SUB AL, '0'      
    AND AL, 00000001B
    CMP AL, 0
    JE PRINT_EVEN
    JMP PRINT_ODD
    
    PRINT_EVEN:
        LEA DX, EVEN_MSG 
        MOV AH, 9
        INT 21H
        JMP EXIT
        
    PRINT_ODD:    
        LEA DX, ODD_MSG
        MOV AH, 9
        INT 21H

    EXIT:
             
END MAIN   