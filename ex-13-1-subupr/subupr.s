  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main


Main:

  @
  @ Program to convert two strings to UPPERCASE
  @ Assume the first string starts at the address in R1
  @ Assume the second string starts at the address in R2
  @

  MOV     R0, R1      @ copy address of first string into R0
  BL      upr         @ invoke upr subroutine

  MOV     R0, R2      @ copy address of second string into R0
  BL      upr         @ invoke upr subroutine (again)

End_Main:
  BX      LR


@
@ upr subroutine
@ Converts a NULL-terminated string to upper case
@
@ Parameters:
@   R0:  string start address
@
upr:
whUpr:   
  LDRB    R4, [R0], #1      @ char = byte[address++]
  CMP     R4, #0  	        @ while ( char != 0 )
  BEQ     eWhUpr  	        @ {
  CMP     R4, #'a'          @  if (char >= 'a'
  BLO     eIfLwr  	        @      &&
  CMP     R4, #'z'          @      char <= 'z')
  BHI     eIfLwr  	        @	 {
  BIC     R4, #0x00000020   @   char = char AND NOT 0x00000020
  STRB    R4, [R0, #-1]     @   byte[address - 1] = char
eIfLwr:                     @	 }
  B       whUpr   			    @ }
eWhUpr:                     @

  BX      LR

  .end