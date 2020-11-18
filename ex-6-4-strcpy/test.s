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

  LDR   R1, =stringA
  LDR   R0, =stringB
  BX    LR


  .section  .rodata

stringA:
  .asciz  "Hello World!"


  .section  .data

stringB:
  .space  256

.end