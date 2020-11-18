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
  LDR   R1, =values
  BX    LR

  .section  .rodata

values:
  .word  5, 10, 15, 20, 25, 30, 35, 40, 45, 50

.end