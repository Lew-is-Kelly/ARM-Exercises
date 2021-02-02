  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global testMatrix

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  BL      InitRam         @ utility subroutine to initialise RAM from ROM

  LDR     R1, =testMatrix      @ start address of array
  LDR     R2, =testMatrixSize
  LDR     R2, [R2]

  LDMFD   SP!, {PC}


@
@ Utility subroutine to initialise RAM from ROM
@
InitRam:

  STMFD   SP!, {R4-R7,LR}
  
  LDR   R4, =init_start    @ start address of initialisation data
  LDR   R5, =init_end      @ end address of initialisation data
  LDR   R6, =data_start    @ start oddress of RAM data

whInit:
  CMP   R4, R5            @ copy word-by-word from init_start
  BHS   ewhInit           @   to init_end in ROM, storing in RAM
  LDR   R7, [R4], #4      @   starting at data_start
  STR   R7, [R6], #4      @
  B     whInit            @
ewhInit:                  @

  LDMFD SP!, {R4-R7,PC}   @ return


  .section  .rodata

init_start:
init_end:

testMatrixSize:
  .word   6
testMatrix:
  .word   6, 3, 8, 2, 5, 2  @ row 0
  .word   0, 7, 2, 8, 5, 7  @ row 1
  .word   0, 0, 7, 4, 2, 6  @ row 2
  .word   0, 0, 0, 2, 9, 5  @ row 3
  .word   0, 0, 0, 0, 5, 8  @ row 4
  .word   0, 0, 0, 0, 0, 3  @ row 5

  .section  .data
data_start:

.end
