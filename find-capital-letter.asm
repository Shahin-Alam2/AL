.MODEL SMALL

.STACK 100H

.DATA
 
NEWLINE DB 0AH,0DH,'$'
NOT_FOUND DB 'NO CAPITAL$'  
SMALL DB 'Z'
BIG DB 'A'
FLAG DB 0

.CODE

MAIN PROC 

    MOV AX, DATA
    MOV DS, AX
    
    MOV AH, 1
      
    STRING_INPUT:
        INT 21H
        CMP AL, 0DH
        JE END_STRING_INPUT
        CMP AL, 65
        JGE CHECK_CAPITAL
        JMP STRING_INPUT 
        
        CHECK_CAPITAL:
            CMP AL, 90
            JG STRING_INPUT 
            MOV FLAG, 1
            CMP AL, SMALL
            JL UPDATE_SMALL
            CMP AL, BIG
            JG UPDATE_BIG
            JMP STRING_INPUT
            
            UPDATE_SMALL:
                MOV SMALL, AL
                JMP CHECK_CAPITAL
                
            UPDATE_BIG:
                MOV BIG, AL
                JMP STRING_INPUT
                         
    END_STRING_INPUT:
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    CMP FLAG, 0
    JE OUTPUT_NOT_FOUND
    
    MOV DL, SMALL
    MOV AH, 2
    INT 21H
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    MOV DL, BIG
    MOV AH, 2
    INT 21H 
    
    JMP EXIT
                      
    OUTPUT_NOT_FOUND:
        LEA DX, NOT_FOUND
        MOV AH, 9
        INT 21H
    
    EXIT:    

END MAIN