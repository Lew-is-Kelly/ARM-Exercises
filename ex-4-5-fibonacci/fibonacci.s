  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Calculate Fibonacci number Fn, where n is stored in R1
  @ Store the result in R0

  CMP   R1, #0
  BNE   ElseIf
  MOV   R0, #0
  B     EndIf
ElseIf:
  CMP   R1, #1
  BNE   ElseFib
  MOV   R0, #1
  B     EndIf
ElseFib:
  MOV   R4, #0      @ F_0 = 0
  MOV   R5, #1      @ F_1 = 1
  MOV   R0, #1      @ F_2 = 1
  MOV   R6, #2      @ curr = 2 (because F_n is currently F_2)
WhileFib:
  CMP   R6, R1      @ while (curr < n)
  BHS   EndWhFib    @ {
  MOV   R4, R5      @ F_(n-2) = F_(n-1)
  MOV   R5, R0      @ F_(n-1) = F_(n)
  ADD   R6, R6, #1  @ F_n = F_(n-1) + F_(n-2)
  ADD   R0, R5, R4  @ curr = curr + 1
  B     WhileFib    @ }
EndWhFib:
EndIf:

  @ End of program ... check your result

End_Main:
  BX    lr

.end