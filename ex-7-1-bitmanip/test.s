  .syntax unified
  .cpu cortex-m4
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:

  @ Test values 1
  LDR   R1, =0x09ABCDEF
  LDR   R2, =0x09ABCDEF
  LDR   R3, =0x09ABCDEF

  bx    lr

.end