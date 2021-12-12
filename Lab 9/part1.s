.data
// constants
PATTERN:
	.word 0x202, 0x102, 0x084, 0x048, 0x030, 0x048, 0x084, 0x102 // hex representation of the leds in binary For instance the first case would be 1000000001

TIME:
	.word 50000000 // Timer is 2Mhz, so we take one quarter of that to get 0.25s

.text
.global _start
_start:
	LDR R0, =0xFF200000 // RED LEDS address base thing
	LDR R1, =0xFFFEC600 // timer address base thing
	LDR R5, =0xFF200050	// KEY address base thing
	LDR R7, =PATTERN // In our case it's a sweeping pattern
	
	LDR R3, =TIME 
	LDR R3, [R3] // intiialize timer to 0.25s
	STR R3, [R1] // Load timer value 
	
	MOV R3, #0x3 // Enable, Autoreload
	STR R3, [R1,#8] // Load timer config
	
	MOV R9, #0 // Pointer for pattern
	MOV R10, #0 // Previous value of KEY3
	
LOOP: // main entry point of program
	LDR R2, [R7, R9]
	STR R2, [R0] // load pattern
	
WAIT: // check first for keypresses
	LDR R6, [R5] // check KEY 3
	LSR R6, #3 // shift 3 bits right, to get a raw value
	
	CMP R6, R10
	MOV R10, R6 // insert new value for KEY
	BEQ WAITMORE // go next if KEY 3 is still same
	
	CMP R6, #0 // check if KEY 3 has been released after being pressed
	BEQ KEY // if so, we shall branch to key limbo    
	
WAITMORE: // wait a bit more for the timer
	LDR R4, [R1,#12] // check f bit
	CMP R4, #0 // check if timer has hit zero (R4 = 1)
	BEQ WAIT // if it's zero (not done), we need to keep waiting a bit
	
// Now we will change the pattern
	
	STR R4, [R1, #12] // reload counter
	
	ADD R9, R9, #4 // increment pointer
	
	CMP R9, #32 // check that we don't overflow our pointer
	
	BLT LOOP // go load next value
	
	MOV R9, #0 // reload pointer
	B LOOP // go load next value
	
KEY:
	LDR R6, [R5] // check KEY
	LSR R6, #3 // shift 3 bits right, to get a raw value
	
	CMP R6, R10
	MOV R10, R6 // insert new value for KEY
	BEQ KEY // go back if KEY 3 is still same
	
	CMP R6, #0 // check if KEY 3 has been un-depressed after being pressed
	BNE KEY // go back if R6 is not un-depressed
	
	// reconfigure timer
	LDR R3, =TIME 
	LDR R3, [R3] // timer init value to 0.25 seconds
	STR R3, [R1] // Load timer value
	MOV R3, #1
	STR R3, [R1, #12] // reload counter
	
	B WAITMORE