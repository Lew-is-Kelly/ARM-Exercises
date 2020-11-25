  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global stringA
  .global stringB

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set R1 to the start address of the test string
  LDR   R1, =stringA
  LDR   R2, =stringB
  BX    LR


  .section  .rodata

stringA:
  .asciz  "beets"

stringB:
  .asciz  "bests"

.end