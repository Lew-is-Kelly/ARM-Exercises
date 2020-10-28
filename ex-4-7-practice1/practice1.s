  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  CMP   R1, R2      @ if (a < b)
  BHI   TooHigh     @ {
  MOV   R0, R1      @   r = a;
  B     End         @ }
TooHigh:            @ else {
  MOV   R0, R2      @   r = b;
  B     End         @ }
End:

  @ End of program ... check your result

End_Main:
  BX    lr

.end