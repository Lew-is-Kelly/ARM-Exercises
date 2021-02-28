  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main


Main:

  MOV     R0, R4            @ value parameter

  BL      count1s

End_Main:
  BX      LR


@ count1s subroutine
@ Counts the number of set bits (1s) in a word
@ Parameters:
@   R0: wordval – word in which 1s will be counted
@ Return:
@   R0: count of set bits (1s) in wordval
count1s:
  PUSH    {R4, LR}        @ save registers
  MOV     R4, R0          @ copy wordval parameter to local variable
  MOV     R0, #0          @ count = 0;
whCount1s:
  CMP     R4, #0          @ while (wordval != 0)
  BEQ     eWhCount1s      @ {
  MOVS    R4, R4, LSR #1  @  wordval = wordval >> 1; (update carry)
  ADC     R0, R0, #0      @  count = count + 0 + carry;
  B       whCount1s       @ }
eWhCount1s:
  POP     {R4, PC}        @ restore registers

  .end