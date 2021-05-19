  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main


  .section  .text


  .type     Main, %function
Main:
  STMFD   SP!, {LR}

  LDR     R0, =grid1
  LDR     R1, =oneString
  BL      searchTB

  LDR     R0, =grid2
  LDR     R1, =oneString
  BL      searchTLBR

End_Main:
  LDMFD   SP!, {PC}



  .section  .rodata


@ Grid with "compute" appearing vertically starting at [2,2]
grid1:
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'c', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'o', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'm', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'p', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'u', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 't', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'e', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'

@ Grid with "compute" appearing diagonally starting at [2,2]
grid2:
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'c', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'o', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'm', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'p', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'u', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 't', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'e', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'
    .byte   'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'    


oneString:
    .asciz  "compute"



  .section  .data

@
@ you can declare space here for any data you wish to store in RAM
@

.end
