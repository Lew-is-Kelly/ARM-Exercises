  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   wordsearch
  .global   searchLR
  .global   searchTB
  .global   searchTLBR


@ wordsearch subroutine
@ 
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of sequence of strings
@ Return:
@   R0: number of strings that were found
wordsearch:

@
@ Write your wordsearch subroutine here
@


@ searchLR subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchLR:

@
@ You can copy-and-paste your searchLR subroutine from Part 1 here
@



@ searchTB subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchTB:

@
@ You can copy-and-paste your searchTB subroutine from Part 2 here
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
@ You can copy-and-paste your searchTLBR subroutine from Part 2 here
@


.end