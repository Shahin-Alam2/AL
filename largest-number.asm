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
    
    FIND_LARGE:
        MOV BL, INPUT[SI]   
        CMP BL, '$'
        JE END_FIND_LARGE:
        INC SI
        CMP BL, INPUT[0]
        JG UPDATE  
        JMP FIND_LARGE
        
        UPDATE:
            MOV INPUT[0], BL
            JMP FIND_LARGE      
            
    END_FIND_LARGE:  
    
    MOV AH, 2
    MOV DL, INPUT[0]
    INT 21H     
        
END MAIN       