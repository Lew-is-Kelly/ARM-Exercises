  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test

  .equ    N, 2
  .equ    M, 3
  .equ    P, 3

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  LDR     R0, =matrixA      @ start address of matrixA
  LDR     R1, =matrixB      @ start address of matrixB
  LDR     R2, =matrixC      @ start address of matrixC

  LDR     R10,=N
  LDR     R11,=M
  LDR     R12,=P

  LDMFD   SP!, {PC}


  .section  .rodata

matrixA:
  .word   6, 3, 8
  .word   0, 7, 2

matrixB:
  .word   1, 2, 1
  .word   2, 1, 2
  .word   1, 2, 1

  .section  .data

matrixC:
  .space  (N*P*4)

.end
