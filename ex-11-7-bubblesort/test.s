  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global testValues

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  BL      InitRam                     @ utility subroutine to initialise RAM from ROM

  LDR     R1, =testValues             @ start address of array
  LDR     R2, =(size_testValues >> 2) @ size of array

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
init_testValues:
  .word  5, 2, 7, 6, 9, 1, 8, 3, 0, 4
  .equ   size_testValues, .-init_testValues
init_end:


  .section  .data
data_start:
testValues:
  .space  size_testValues   @ enough space for the initial string contents above

.end
