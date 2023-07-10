.MODEL SMALL

.STACK 100H

.DATA
 
NEWLINE DB 0AH,0DH,'$'

.CODE

MAIN PROC  
    
    MOV AX, DATA
    MOV DS, AX
      
    MOV AH, 1
    INT 21H      
    SUB AL, '0'     
    MOV BL, 0   
     
    SUM:
        ADD BL, AL
        DEC AL 
        CMP AL, 0
        JG SUM
    
    MOV AH, 9    
    LEA DX, NEWLINE
    INT 21H
    
    ADD BL, '0'
    MOV DL, BL
    MOV AH, 2
    INT 21H

END MAIN    