  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   searchTB
  .global   searchTLBR


@ searchTB subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchTB:

@
@ Write your searchTB subroutine here
@



@ searchTLBR subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchTLBR:

@
@ Write your searchTLBR subroutine here
@


.end