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

  MOV   R3, R4, LSR #8    @ 0x0089ABCD
  MOV   R2, R4, LSL #8    @ 0xABCDEF00
  LDR   R1, =0x0000FF00
  LDR   R0, =0x00FF0000
  AND   R3, R1, R3        @ 0x0000AB00  
  AND   R2, R0, R2        @ 0x00CD0000
  EOR   R3, R2, R3        @ 0x00CDAB00
  LDR   R1, =0xFF0000FF
  AND   R4, R4, R1        @ 0x890000EF
  EOR   R4, R4, R3        @ 0x89CDABEF

End_Main:
  BX    lr

.end