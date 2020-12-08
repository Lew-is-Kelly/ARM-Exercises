  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:

  @ Test value
  LDR   R1, =14
  LDR   R2, =21


  bx    lr

.end