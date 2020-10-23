  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will convert
  @    a sequence of four ASCII characters, each representing a
  @    decimal digit, into tje to the value represented by the
  @    sequence.
  
  @ e.g. '2', '0', '3', '4' (or 0x32, 0x30, 0x33, 0x34) to 2034 (0x7F2)

  MOV R0, #0
  MOV R5, #0
  MOV R6, #0
  MOV R7, #0
  MOV R8, #0
  SUB R1, #0x30
  SUB R2, #0x30
  SUB R3, #0x30
  SUB R4, #0x30
  MOV R8, #0x3e8
  MOV R7, #0x64
  MOV R6, #0xa
  MUL R4, R4, R8
  MUL R3, R3, R7
  MUL R2, R2, R6
  ADD R0, R1, R2
  ADD R0, R0, R3
  ADD R0, R0, R4


  @ End of program ... check your result

End_Main:
  BX    lr

.end
