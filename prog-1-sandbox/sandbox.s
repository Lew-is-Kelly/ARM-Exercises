  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  MOV     R0, #0

  LDRB    R2, [R1]
  CMP     R2, #97
  BLO     EndIf
  CMP     R2, #122
  BHI     EndIf
  

End_Main:
  BX    lr

  .end