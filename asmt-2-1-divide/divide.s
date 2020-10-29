  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will divide a
  @   value, a, in R2 by another value, b, in R3.
  
  MOV     R0, #0
  MOV     R1, #0         @ Initialisation

Test:
  CMP     R2, R3          @ while (r2 >= r3)
  BHS     DivideLoop      @ {
  B       End             @ }

DivideLoop:
  SUB     R2, R2, R3      @ r2 = r2 - r3
  ADD     R0, R0, #1      @ r0 = r0 + 1
  B       Test            @ goto while

End:
  MOV     R1, R2          @ r1 = r2

  @ End of program ... check your result

End_Main:
  BX    lr

.end
