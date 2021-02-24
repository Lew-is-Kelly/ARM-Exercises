  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global Main

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  LDR     R0, =3             @ x
  LDR     R1, =9             @ n

  LDMFD   SP!, {PC}

Main:

  BL      power

End_Main:

  BX      LR

.end
