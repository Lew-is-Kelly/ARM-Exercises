  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Test with a=6, b=8
  MOV   R1, #7
  MOV   R2, #7
  bx    lr

.end