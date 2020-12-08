  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write a program to swap the middle two bytes of the value in
  @   R4, leaving the outer two bytes unchanged
  @
  @ For example, if R4 initially contains 0x89ABCDEF, your program
  @   should change R4 to 0x89CDABEF
  @

  @ *** your solution goes here ***

  @ End of program ... check your result

End_Main:
  BX    lr

.end