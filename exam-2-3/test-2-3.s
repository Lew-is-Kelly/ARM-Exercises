  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main


  .section  .text


  .type     Main, %function
Main:
  STMFD   SP!, {LR}

  LDR     R0, =grid
  LDR     R1, =searchStrings
  BL      wordsearch

End_Main:
  LDMFD   SP!, {PC}



  .section  .rodata


@ Grid containing "program", "compute" and "build" but not "code"
grid:
    .byte   'p', 'r', 'o', 'g', 'r', 'a', 'm', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'c', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'o', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'm', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'p', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'b', 'u', 'i', 'l', 'd', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 't', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'e', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'


searchStrings:
    .asciz  "program"
    .asciz  "compute"
    .asciz  "code"
    .asciz  "build"
    .byte   0



  .section  .data

@
@ you can declare space here for any data you wish to store in RAM
@

.end
