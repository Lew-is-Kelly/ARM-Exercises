  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language program to evaluate
  @   x^3 - 4x^2 + 3x + 8
  MOV R0, #0
  MOV R2, #0
  MOV R3, #0
  MOV R4, #0
  MOV R5, #0
  MUL R5, R1, R1 
  MUL R5, R5, R1 @x^3
  MOV R2, #4
  ADD R3, R1 @copy x to r3
  MUL R3, R3, R3 @x^2
  MUL R2, R2, R3 @4(x^2)
  SUB R2, R5, R2 @(x^3)-(4x^2)
  MOV R4, #3
  MUL R4, R4, R1 @
  ADD R2, R4, R2
  ADD R0, R2, #8
  @ End of program ... check your result

End_Main:
  BX    lr

.end
