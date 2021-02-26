  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global testMem

  .equ    size_testMem,0x400  @ 1KiB

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  LDR     R4, =testMem       @ just some address in memory that we can fill

  LDMFD   SP!, {PC}


  .section  .data
data_start:
testMem:
  .space  size_testMem    @ memory to test fill

.end
