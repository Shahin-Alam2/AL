.MODEL SMALL

.STACK 100H

.DATA   

NEWLINE DB 0AH,0DH,'$' 
TEXT DB 'HELLO WORLD$'
PATTERN DB 'RLD$'  
FOUND DB 'SUBSTRING FOUND$'
NOT_FOUND DB 'SUBSTRING NOT FOUND$'

.CODE

MAIN PROC

    MOV AX, DATA
    MOV DS, AX        
        
    MOV SI, 0 
                      
    CHECK:
        MOV DI, 0
        
        MATCH:
            CMP PATTERN[DI], '$'
            JE FOUND_MSG
            MOV BX, SI
            ADD BX, DI   
            CMP TEXT[BX], '$'
            JE NOT_FOUND_MSG 
            MOV CL, PATTERN[DI]   
            INC DI
            CMP CL, TEXT[BX] 
            JE MATCH
            INC SI
            JMP CHECK 
            
    FOUND_MSG:
        LEA DX, FOUND
        MOV AH, 9
        INT 21H
        JMP EXIT
        
    NOT_FOUND_MSG:
        LEA DX, NOT_FOUND
        MOV AH, 9
        INT 21H
        JMP EXIT
        
    EXIT: 
        
END MAIN