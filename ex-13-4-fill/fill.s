  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main


Main:

  MOV     R0, R4            @ address parameter
  MOV     R1, #64           @ fill 64 words
  LDR     R2, =12345678     @ fill with value 12345678

  BL      fill

End_Main:
  BX      LR


@ fill subroutine
@ Fills a contiguous sequence of words in memory with the same value
@
@ Parameters:
@       R0: address – address of first word to be filled
@       R1: length – number of words to be filled
@       R2: value – value to store in each word

fill:
  PUSH    {R4,LR}
  MOV     R4, #0                  @ count = 0;
whFill:
  CMP     R4, R1                  @ while (count < length)
  BHS     eWhFill                 @ {
  STR     R2, [R0, R4, LSL #2]    @   word[address+(count*4)] = value;
  ADD     R4, #1                  @   count = count + 1;
  B       whFill                  @ }
eWhFill:                          @
  POP     {R4,PC}

  .end