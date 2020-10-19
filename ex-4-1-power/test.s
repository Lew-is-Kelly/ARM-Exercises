  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Test with x=3, y=4
  MOV   R1, #2
  MOV   R2, #10
  bx    lr

.end