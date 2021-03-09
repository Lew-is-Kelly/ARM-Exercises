  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Init_Test
  .global testStr1
  .global testStr2

  .section  .text


  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}

  BL      InitRam            @ utility subroutine to initialise RAM from ROM

  LDR     R4, =testStr1      @ start address of string 1
  LDR     R5, =testStr2      @ start address of string 2

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
init_testStr1:
  .asciz  "Hello World!"
  .equ   size_testStr1, .-init_testStr1
init_testStr2:
  .asciz  "Introduction to Computing"
  .equ   size_testStr2, .-init_testStr2
init_end:


  .section  .data
data_start:
testStr1:
  .space  size_testStr1   @ enough space for the initial string 1 contents above
testStr2:
  .space  size_testStr2   @ enough space for the initial string 2 contents above

.end
