  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main
  .global Init_Test
  .global origArray
  .global newArray


  .section  .text

Main:
  STMFD   SP!, {LR}

  @
  @ Test each of the subroutines
  @

  @ Test get9x9 by getting array[6][7]
  LDR     R0, =origArray
  LDR     R1, =6
  LDR     R2, =7
  BL      get9x9
  @ R0 should be 20

  @ Test set9x9 by setting array[6][7] to 10 ...
  LDR     R0, =origArray
  LDR     R1, =6
  LDR     R2, =7
  LDR     R3, =10
  BL      get9x9
  @ array[6][7] should be 10

  @ Test average9x9 by getting the average
  @ around array[4][3] at a radius of 2
  LDR     R0, =origArray
  LDR     R1, =4
  LDR     R2, =3
  LDR     R3, =2
  BL      average9x9
  @ R0 should be 11

  @ Test blur9x9
  LDR     R0, =origArray
  LDR     R1, =newArray
  LDR     R2, =2
  BL      blur9x9

End_Main:
  LDMFD   SP!, {PC}


  .type     Init_Test, %function
Init_Test:
  BX      LR

  .section  .rodata

origArray:
  .word  10, 10, 10, 10, 10, 10, 10, 10, 10
  .word  10, 10, 10, 10, 10, 10, 10, 10, 10
  .word  10, 12, 12, 12, 12, 12, 10, 10, 10
  .word  10, 12, 10, 10, 10, 12, 10, 10, 10
  .word  10, 12, 10,  3, 10, 12, 10, 10, 10
  .word  10, 12, 10, 10, 10, 12, 10, 10, 10
  .word  10, 12, 12, 12, 12, 12, 10, 10, 10
  .word  10, 10, 10, 10, 10, 10, 20, 10, 10
  .word  10, 10, 10, 10, 10, 10, 10, 10, 10
  .equ   size_origArray, .-origArray


  .section  .data
newArray:
  .space  size_origArray  @ enough space for a copy of origArray above


.end
