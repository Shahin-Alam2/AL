.MODEL SMALL

.STACK 100H

.DATA   

NEWLINE DB 0AH,0DH,'$' 
INPUT DB 50 DUP('$') 

.CODE

MAIN PROC

    MOV AX, DATA
    MOV DS, AX        
        
    MOV SI, 0 
    MOV AH, 1   
                      
    START_INPUT:
        INT 21H
        CMP AL, 0DH
        JE END_INPUT
        MOV INPUT[SI], AL
        INC SI
        JMP START_INPUT
    
    END_INPUT:   
    
    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H
    
    MOV SI, 0
    
    LOOP1:
        MOV DI, SI
        
        MOV AH, INPUT[SI]
        CMP AH, '$'
        JE END_LOOP1
        
        LOOP2:
            INC DI
            CMP INPUT[DI], '$'
            JE END_LOOP2
            CMP AH, INPUT[DI]
            JG SWAP 
            JMP LOOP2
        
        SWAP:
            MOV AL, AH
            MOV AH, INPUT[DI]
            MOV INPUT[SI], AH
            MOV INPUT[DI], AL
            JMP LOOP2
        
        END_LOOP2:
            INC SI
            JMP LOOP1        
            
    END_LOOP1:  
    
    MOV AH, 9
    LEA DX, INPUT
    INT 21H       
        
END MAIN