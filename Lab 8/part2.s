.global _start
_start:
		PUSH {R0-R7, LR}
bsort_next:                     // Check for a sorted array
    MOV     R2,#0               // R2 = Current Element Number
    MOV     R6,#0               // R6 = Number of swaps
bsort_loop:                     // Start loop
    ADD     R3,R2,#1            // R3 = Next Element Number
    CMP     R3,R1               // Check for the end of the array
    BGE     bsort_check         // When we reach the end, check for changes
SWAP:
	LDR     R4,[R7,R2,LSL #2]   // R4 = Current Element Value
    LDR     R5,[R7,R3,LSL #2]   // R5 = Next Element Value
    CMP     R4,R5               // Compare element values
    STRGT   R5,[R7,R2,LSL #2]   // If R4 > R5, store current value at next
    STRGT   R4,[R7,R3,LSL #2]   // If R4 > R5, Store next value at current
    ADDGT   R6,R6,#1            // If R4 > R5, Increment swap counter
	MOV     R2,R3               // Advance to the next element
	ADDGT 	R0,R0,#1			// If R4 > R5, Increment swap counter in R0
	CMP		R0,#0				// Compare R0 with 0
	STRGT	R0,#1				// If R0 > 0, then store 1 in R0
	BEQ		R0,#0				// If R0 = 0, then store 0 in R0
    B       bsort_loop          // End loop
bsort_check:                    // Check for changes
    CMP     R6,#0               // Were there changes this iteration?
    SUBGT   R1,R1,#1            // Optimization: skip last value in next loop
    BGT     bsort_next          // If there were changes, do it again
bsort_done:                     // Return
    POP     {R0-R7,PC}          // Pop the registers off of the stack