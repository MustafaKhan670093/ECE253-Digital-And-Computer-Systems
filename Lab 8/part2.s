.text
.global _start
.global SWAP

_start: LDR R12, =LIST // load list array
        MOV R10, R12
	LDR R11, [R12] //  
  
TRACKER:    
	MOV R12, R10 
        SUB R11, #1 
        CMP R11, #0 
        MOV R7, R11
        BNE FOR

END:    
	B END
    
FOR:    MOV R2, #0
        MOV R1, #0
        MOV R0, #0
        ADD R12, #4 // Shift to next number in array
        ADD R0, R0, R12
        CMP R7, #0 // If loop length is 0, perform no swaps
        SUB R7, #1 
        BEQ TRACKER
        BL SWAP 
        B FOR    

SWAP:    
	LDR R1, [R0] 
        LDR R2, [R0, #4] 
        CMP R1, R2  
        STRGT R2, [R0]   
        STRGT R1, [R0, #4] 
        MOVLE R0, #0
        MOVGT R0, #1 
        MOV R1, #0
        MOV R2, #0
        MOV PC, LR
