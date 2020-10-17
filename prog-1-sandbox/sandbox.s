  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write your program here

  @2x^2+6xy+3y^2
  MOV R3, #2 
  MUL R5, R1, R1
  MUL R5, R5, R3
  MOV R4, #6
  MUL R6, R4, R1
  MUL R6, R6, R2
  MOV R8, #3
  MUL R9, R2, R2
  MUL R9, R9, R8
  ADD R0, R9, R6
  ADD R0, R0, R5

  @ End of program ... check your result

End_Main:
  BX    lr

  .end