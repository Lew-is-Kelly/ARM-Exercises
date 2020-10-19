  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Calculate the maximum of two values a and b
  @ a is in R1, b is in R2
  CMP R1, R2
  BLT ElseMaxB
  MOV R0, R1
  B EndMax
ElseMaxB:
  MOV R0, R2
EndMax:
  @ End of program ... check your result

End_Main:
  BX    lr

.end