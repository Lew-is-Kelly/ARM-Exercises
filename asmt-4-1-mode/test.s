  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global values

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set R1 to the start address of values in memory
  LDR   R1, =sequence
  LDR   R2, =8
  BX    LR

  .section  .rodata

sequence:
  .word  5, 3, 7, 5, 3, 5, 1, 9

.end