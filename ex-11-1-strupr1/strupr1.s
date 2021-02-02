  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

@
@ strupr rewritten to use Register Offset Addressing
@

Main:

  LDR     R2, =0  	        @ index = 0

whUpr:   
  LDRB    R4, [R1, R2]      @ char = byte[address + index]
  CMP     R4, #0  	        @ while ( char != 0 )
  BEQ     eWhUpr  	        @ {
  CMP     R4, #'a'          @  if (char >= 'a'
  BLO     eIfLwr  	        @      &&
  CMP     R4, #'z'          @      char <= 'z')
  BHI     eIfLwr  	        @	 {
  BIC     R4, #0x00000020   @   char = char AND NOT 0x00000020
  STRB    R4, [R1, R2]      @   byte[address + index] = char
eIfLwr:                     @	 }
  ADD     R2, R2, #1        @  index = index + 1
  B       whUpr   			    @ }
eWhUpr:                     @

End_Main:
  BX      LR

  .end