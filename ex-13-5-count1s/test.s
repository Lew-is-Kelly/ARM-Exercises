  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  LDR     R4, =0xABABABAB       @ just some value to test count1s

  LDMFD   SP!, {PC}


.end
