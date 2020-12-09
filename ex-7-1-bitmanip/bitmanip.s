  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write a program to implement all of the following operations:
  @
  @   1. Clear (i.e. change to zero) the middle two bytes of the
  @      value in R1.
  @
  @   2. Set (i.e. change to one) the four most significant bits
  @      of the value in R2.
  @
  @   3. Invert every second bit of the value in R3, starting
  @      with the least significant bit.
  @

  @ *** your solution goes here ***

  LDR     R0, =0xFF0000FF
  AND     R1, R1, R0

  ORR     R2, R2, #0xF0000000

  EOR     R3, R3, #0x55555555

  @ End of program ... check your result

End_Main:
  BX    lr

.end