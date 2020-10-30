  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Test by computing GCD of 45 and 27
  LDR   R2, =48
  LDR   R3, =36
  bx    lr

.end