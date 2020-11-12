  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global strA

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Set R1 to the start address of the test string
  LDR   R1, =strA
  BX    LR


  .section  .rodata

strA:
  .asciz  "Hello World"  

.end