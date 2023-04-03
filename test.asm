;Finding largest value of the array
;input: 451829346
;output: 9



.MODEL SMALL
.STACK 100H

.DATA
    inpmsg DB "Enter the array elements (single decimal digits from 0 to 9) : $"
    outmsg DB "The largest value is : $"
    
    arr DB 100 DUP ("$")
    large DB 0
    
.CODE

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,inpmsg
    MOV AH,09H
    INT 21H
    
    
    ;INPUT:
    ;    MOV AH,1
    ;    INT 21H
        
    ;    CMP AL,0DH
     ;   JE END_INPUT
        
     ;   CMP AL,large
     ;   JG UPDATE
     ;   JMP INPUT
        
     ;   UPDATE:
     ;       MOV large,AL
     ;       JMP INPUT
    ;END_INPUT:
    
    ;This part of the code is not needed.
    ;There is a problem in this part of code so I commented it,will try to fix it later.Also without this part program is perfectly working.
    
    MOV SI,0
    INPUT:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE END_INPUT
        MOV arr[SI],AL
        INC SI
        JMP INPUT   
    END_INPUT:
    
    CALL NEW_LINE
    MOV SI,0
    
    
    
    
    OUTPUT: 
        MOV AL,arr[SI]
        CMP AL,'$'
        JE END_OUTPUT 
        
        ;CMP large, Al
        CMP AL, large
        
        JG UPDATE
        INC SI
        JMP OUTPUT
        
        UPDATE:
            MOV large,AL
            INC SI
            JMP OUTPUT
        
    END_OUTPUT:                 
    
    CALL NEW_LINE 
    
    LEA DX,outmsg
    MOV AH,09H
    INT 21H
     
    MOV DL,large
    MOV AH,2
    INT 21H
    
    EXIT:
        MOV AX,4CH
        INT 21H

MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN

    