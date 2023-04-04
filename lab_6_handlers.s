	;; UART0_handler

	;; clear interrupt
		MOV r1, #0xC000
		MOVT r1, #0x4000

		LDRB r0, [r1,#0x038]
		ORR r0, r0, #0x10 ;store bit 4 (5th bit) with 1
		STRB r0, [r1, #0x038]

	;; read character

	    CMP r0, #0x77 	; compare the read in character with ascii w
	    BEQ up

	    CMP r0, #0x61 	; compare the read in character with ascii a
	    BEQ left

	    CMP r0, #0x73 	; compare the read in character with ascii s
	    BEQ down

	    CMP r0, #0x64 	; compare the read in character with ascii d
	    BEQ right

up:
	    MOV r4, #0x2

left:
	    MOV r4, #0x1

down:
	    MOV r4, #0x3

right:
	    MOV r4, #0x0




	;;  timer handler

	;;  clear interrupt
	MOV r0, #0x0000 	; move to timer 0 address
	MOVT r0, #0x4003

	LDR r1, [r0, #0x024] 	; load contents of GPTMICR inot r1
	ORR r1, r1, #0x1 	; write a 1 to TATOCINT bit
	STR r1, [r0, #0x024] 	; store back inot GPTMICR

	LDR r6, location_ptr ;this might be needed in main routine
	LDR r4, direction_ptr ;this might need to be done in main routine ; load direction piece is going in
	MOV r0, #0x20 ; ascii space
	MOV r1, #0x2a ; ascii *

	STR r0, [r6]

	CMP r4, #2
	BEQ moveUp

	CMP r4, #1
	BEQ moveLeft

	CMP r4, #3
	BEQ moveDown

	CMP r4, #0
	BEQ moveRight

moveUp:
	sub r6, r6, #24
	B exitTimer

moveLeft:
	sub r6, r6, #1
	B exitTimer


moveDown:
	add r6, r6, #24
	B exitTimer

moveRight:
	add r6, r6, #1
	B exitTimer

exitTimer:
	STR r1, [r6]

	; you can either print string here or in lab6 routine
	MOV r0, #0xC ;clear screen
	output_character
	MOV r0, r4 ;r4 holds game board pointer
	output_string 


BX lr
	;;


	;;  sw1 handler

	;;  clear interrupt

	MOV r0, #0x0000
	MOVT r0, #0x4003 	; move the timer0 address into r0

	LDR r1, [r0, #0x028] 	; load the contents of GPTMCTL into r1
	ASR r1, r1, 1 		; divide the timer by 2 so it is twice as fast !!!this may not be right!!!
	STR r1, [r0, #0x028] 	;store back to GPTMCTL
