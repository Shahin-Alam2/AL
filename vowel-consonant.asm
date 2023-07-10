.MODEL SMALL

.STACK 100H

.DATA   

NEWLINE DB 0AH,0DH,'$'  
VOWELS DB 'AaEeIiOoUu$'
VOWEL DB 48
CONSONENT DB 48
DIGIT DB 48
SPACE DB 48
SPACE_MSG DB 'SPACE: $'  
DIGIT_MSG DB 'DIGIT: $'  
VOWEL_MSG DB 'VOWEL: $'
CONSONENT_MSG DB 'CONSONENT: $'

.CODE

MAIN PROC

    MOV AX, DATA
    MOV DS, AX
    
    MOV AH, 1
    
    START_INPUT:
        INT 21H
        CMP AL, 0DH
        JE END_INPUT
        CMP AL, ' '
        JE COUNT_SPACE 
        CMP AL, '9'
        JLE CHECK_DIGIT 
        MOV SI, 0
        MOV CX, 10  
        
        CHECK_VOWEL:
            CMP AL, VOWELS[SI]
            JE COUNT_VOWEL
            INC SI 
            LOOP CHECK_VOWEL
            
        JMP COUNT_CONSONENT
        
        COUNT_SPACE:
            ADD SPACE, 1
            JMP START_INPUT 
            
        CHECK_DIGIT:
            CMP AL, '1'
            JGE COUNT_DIGIT
            JMP START_INPUT    
        
        COUNT_DIGIT:
            ADD DIGIT, 1
            JMP START_INPUT 
        
        COUNT_VOWEL:
            ADD VOWEL, 1
            JMP START_INPUT 
        
        COUNT_CONSONENT:
            ADD CONSONENT, 1
            JMP START_INPUT  
    
    END_INPUT:
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    LEA DX, SPACE_MSG
    MOV AH, 9
    INT 21H 
    
    MOV DL, SPACE
    MOV AH, 2 
    INT 21H 
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    LEA DX, DIGIT_MSG
    MOV AH, 9
    INT 21H 
    
    MOV DL, DIGIT
    MOV AH, 2 
    INT 21H
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    LEA DX, VOWEL_MSG
    MOV AH, 9
    INT 21H 
    
    MOV DL, VOWEL
    MOV AH, 2 
    INT 21H
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    LEA DX, CONSONENT_MSG
    MOV AH, 9
    INT 21H 
    
    MOV DL, CONSONENT
    MOV AH, 2 
    INT 21H    
          
END MAIN              