  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Calculate n!, where n is stored in R1
  @ Store the result in R0
  MOV R0, #1
  MOV R2, R1
WhileMul:
  CMP R2, #1
  BLS EndWhMul
  MUL R0, R0, R2
  SUB R2, R2, #1
  B WhileMul
EndWhMul:
  @ End of program ... check your result

End_Main:
  BX    lr

.end