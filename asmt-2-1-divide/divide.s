  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will divide a
  @   value, a, in R2 by another value, b, in R3.
  
  MOV     R0, #0
  MOV     R1, #0          @ Initialisation

  CMP     R3, #0          @ If (b != 0)
  BEQ     Zero            @ {

Test:
  CMP     R2, R3          @ while (a >= b)
  BHS     DivideLoop      @ {
  B       End             @

DivideLoop:
  SUB     R2, R2, R3      @ a = a - b
  ADD     R0, R0, #1      @ c = c + 1
  B       Test            @

End:                      @ }
  MOV     R1, R2          @ Remainder = a

Zero:                     @ }

  @ End of program ... check your result

End_Main:
  BX    lr

.end
