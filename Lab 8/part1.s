.text
.global ONES 
ONES:
	LDR R2,=TEST_NUM //load the data word into R2
	LDR R1,[R2]
	MOV R5,#0 //R0 will hold the result
LOOP: CMP R1,#0 //loop until the data contains no more 1s
	BEQ END
	LSR R2,R1,#1 //perform SHIFT, followed by AND
	AND R1,R1,R2
	ADD R5,#1 //count the string lengths so far
	B LOOP
END: B END



