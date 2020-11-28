  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @
  
While:
  LDRB    R3, [R1]
  LDRB    R4, [R2]
  CMP     R3, #0
  BEQ     EndWh
  CMP     R3, R4
  BNE     EndWh
  ADD     R1, R1, #1
  ADD     R2, R2, #1
  B       While
EndWh:

  CMP     R3, R4
  BNE     EndIf
  MOV     R0, #0
  B       End
EndIf:

  CMP     R3, R4
  BLS     EndElse
  MOV     R0, #1
  B       End
EndElse:

  MOV     R0, #-1

End:

  @ End of program ... check your result

End_Main:
  BX    lr

