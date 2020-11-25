  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global setA
  .global setB
  .global setC
  .global sizeA
  .global sizeB
  .global sizeC


  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set R1 to the start address of the test string
  LDR   R0, =setC
  LDR   R1, =setA   @ address of set A
  LDR   R2, =setB   @ address of set B
  LDR   R3, =sizeA  
  LDR   R3, [R3]    @ number of elements in set A
  LDR   R4, =sizeB
  LDR   R4, [R4]    @ number of elements in set B
  BX    LR


  .section  .rodata

sizeA:
  .word  10
setA:
  .word  299, 6, 342, 12, 0, -100, 22, 88, -5, 50

sizeB:
  .word  6
setB:
  .word  342, -5, 6, 81, -200, 7


  .section  .data

sizeC:
  .space    4
setC:
  .space    256

.end