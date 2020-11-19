  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  MOV     R0, #0

While:
  LDRB    R2, [R1]
  CMP     R2, #0
  BEQ     EndWh
  ADD     R0, R0, #1
  ADD     R1, R1, #1
  B       While
EndWh:

End_Main:
  BX    lr

