  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language program to evaluate
  @   ax^2 + bx + c for given values of a, b, c and x
  MOV R0, #0
  MOV R5, #0
  MOV R6, #0
  MOV R5, R1
  MUL R5, R5, R5 @x^2
  MUL R5, R5, R2 @a(x^2)
  MOV R6, R1
  MUL R6, R6, R3 @b(x)
  ADD R0, R5, R6
  ADD R0, R0, R4
  @ End of program ... check your result

End_Main:
  BX    lr

.end
