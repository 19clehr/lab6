	;; UART0_handler

	;; clear interrupt

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

	;;


	;;  sw1 handler

	;;  clear interrupt

	MOV r0, #0x0000
	MOVT r0, #0x4003 	; move the timer0 address into r0

	LDR r1, [r0, #0x028] 	; load the contents of GPTMCTL into r1
	ASR r1, r1, 1 		; divide the timer by 2 so it is twice as fast !!!this may not be right!!!
	STR r1, [r0, #0x028] 	;store back to GPTMCTL
