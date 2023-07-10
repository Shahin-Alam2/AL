.MODEL SMALL

.STACK 100H

.DATA

INPUT DB 50 DUP('$') 
NEWLINE DB 0AH,0DH,'$'

.CODE

MAIN PROC  
    
    MOV AX, DATA
    MOV DS, AX
    
    MOV SI, 0
    MOV AH, 1   
      
    STRING_INPUT:
        INT 21H
        CMP AL, 0DH
        JE END_STRING_INPUT
        MOV INPUT[SI], AL
        INC SI
        JMP STRING_INPUT   
        
    END_STRING_INPUT: 
                      
    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H
               
    MOV DI, 0
    
    CASE_CHANGE:
        MOV DL, INPUT[DI]
        CMP DL, '$'
        JE END_CASE_CHANGE
        
        CMP DL, 65
        JL UPDATE      
        CMP DL, 90
        JG CHECK_LOWER
        XOR DL, 32
        JMP UPDATE
        
        CHECK_LOWER:
            CMP DL, 97
            JL UPDATE
            CMP DL, 122
            JG UPDATE
            XOR DL, 32
        
        UPDATE:
            MOV INPUT[DI], DL
            INC DI
            JMP CASE_CHANGE
            
    END_CASE_CHANGE: 
    
    LEA DX, INPUT
    MOV AH, 9
    INT 21H

END MAIN