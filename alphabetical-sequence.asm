.MODEL SMALL

.STACK 100H

.DATA   

NEWLINE DB 0AH,0DH,'$' 
INPUT DB 50 DUP('$') 
MAX DW 0   
INDEX DW 0

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
    
    MOV SI, 0
    MOV CX, 1     
           
    CHECK:
        MOV AL, INPUT[SI]
        MOV AH, INPUT[SI+1]
        CMP AH, '$'
        JE EXIT_CHECK
        INC AL
        CMP AL, AH
        JNE CHECK_MAX 
        INC CX
        INC SI 
        JMP CHECK
        
        CHECK_MAX:
            CMP CX, MAX
            JG UPDATE   
            INC SI
            MOV CX, 1
            JMP CHECK
            
            UPDATE:
                MOV MAX, CX
                MOV BX, SI
                SUB BX, CX
                MOV INDEX, BX  
                JMP CHECK_MAX
                
    EXIT_CHECK:
    
    CMP CX, MAX
    JG LAST_UPDATE 
    JMP EXIT
    
    LAST_UPDATE:
        MOV MAX, CX
        MOV BX, SI
        SUB BX, CX
        MOV INDEX, BX  
     
    EXIT:   
        MOV AH, 9
        LEA DX, NEWLINE
        INT 21H
        
        MOV DX, MAX 
        ADD DL, 48
        MOV AH, 2
        INT 21H   
        
        MOV AH, 9
        LEA DX, NEWLINE
        INT 21H
        
        MOV SI, INDEX 
        INC SI
        MOV CX, MAX         
        MOV AH, 2       
        
        SEQ_OUTPUT:  
            MOV DL, INPUT[SI]
            INT 21H
            INC SI
            LOOP SEQ_OUTPUT
        
END MAIN     