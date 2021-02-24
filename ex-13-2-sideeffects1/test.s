  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  LDR     R1, =10
  LDR     R2, =20
  LDR     R3, =30
  LDR     R4, =40

  LDMFD   SP!, {PC}

.end
