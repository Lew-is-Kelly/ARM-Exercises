  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

@
@ sum rewritten to use Register Offset Addressing
@

Main:

  LDR     R0, =0          @ sum = 0
  LDR     R4, =0          @ count = 0
  LDR     R5, =0          @ offset = 0

whSum:
  CMP     R4, #10         @ while (count < 10)
  BHS     eWhSum          @ {
  LDR     R6, [R1, R5]    @  num = word[address + offset]
  ADD     R0, R0, R6      @  sum = sum + num
  ADD     R5, R5, #4      @  offset = offset + 4
  ADD     R4, R4, #1      @  count = count + 1
  B       whSum           @ }
eWhSum:                   @

End_Main:
  BX      LR

  .end