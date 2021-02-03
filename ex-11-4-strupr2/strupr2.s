  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

@
@ strupr rewritten to use immediate post-indexed addressing
@

Main:

whUpr:   
  LDRB    R4, [R1], #1      @ char = byte[address++]
  CMP     R4, #0  	        @ while ( char != 0 )
  BEQ     eWhUpr  	        @ {
  CMP     R4, #'a'          @  if (char >= 'a'
  BLO     eIfLwr  	        @      &&
  CMP     R4, #'z'          @      char <= 'z')
  BHI     eIfLwr  	        @	 {
  BIC     R4, #0x00000020   @   char = char AND NOT 0x00000020
  STRB    R4, [R1, #-1]     @   byte[address - 1] = char
eIfLwr:                     @	 }
  B       whUpr   			    @ }
eWhUpr:                     @

End_Main:
  BX      LR

  .end