  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language program to evaluate
  @   x^3 - 4x^2 + 3x + 8
  MUL R5, R1, R1
  MUL R5, R5, R1
  MOV R2, #4
  ADD R3, R1
  MUL R3, R3, R3
  MUL R2, R2, R3
  SUB R2, R5, R2
  MOV R4, #3
  MUL R4, R4, R1
  ADD R2, R4, R2
  ADD R0, R2, #8
  @ End of program ... check your result

End_Main:
  BX    lr

.end
