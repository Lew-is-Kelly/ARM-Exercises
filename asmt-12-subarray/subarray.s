  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

@ R12 = Current element of arrayB (elemB) 
@ R11 = Current element of arrayA (elemA)
@ R10 = noCheckLimit
@ R9  = indexB
@ R8  = indexA
@ R7  = colIndexB
@ R6  = rowIndexB
@ R5  = colIndexA
@ R4  = rowIndexA
@ R3  = Dimension of arrayB (maxB)
@ R2  = Start addr of arrayB (addrB)
@ R1  = Dimension of arrayA (maxA)
@ R0  = Start addr of arrayA (addrA)

  SUB     R10, R1, R3               @ noCheckLimit = maxA - maxB;
  MUL     R9, R6, R3                @ indexB = rowIndexB * maxB;
  ADD     R9, R9, R7                @ indexB = indexB + colIndexB;
  LDR     R12, [R2, R9, LSL #2]     @ elemB = word[addrB + (indexB * 4)];
WhB:                                @ while(colIndexB <= noCheckLimit) {
  CMP     R6, R10                   @ 
  BHS     EndWhB                    @

End_Main:
  BX    lr

