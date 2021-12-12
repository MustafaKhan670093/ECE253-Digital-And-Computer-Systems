.text

.global _start
_start:
		LDR r0,=TEST_NUM //load myArray start address
		//LDR r1, [r0] //set address of RO and put it in R1

		MOV r8, #0 //r1 = loop counter
		MOV r2, #0 //r2 = # of bytes into array to current element
		MOV r7, #0 //r3 = total sum
	
LOOP:	LDR r4, [r0, r2] //r4 = element at address r0+ r2
		//LDR r1, [r0]
		//if next value is greater than 0
		CMP r4, #0 //if r4 - 0 < 0 will only be true when r4 is -1
		
		blt END;
		
		ADD r7, r7, r4 //total += current value
		//go to next step
		ADD r8, r8, #1 //add one to counter
		ADD r2, r2, #4 //increments by 4 because that's how memory works 
		
		
		b LOOP

END:  B END


.end
	