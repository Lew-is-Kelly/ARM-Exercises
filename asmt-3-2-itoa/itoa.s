  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will convert
  @   a signed value (integer) in R3 into three ASCII characters that
  @   represent the integer as a decimal value in ASCII form, prefixed
  @   by the sign (+/-).
  @ The first character in R0 should represent the sign
  @ The second character in R1 should represent the most significaint digit
  @ The third character in R2 should represent the least significant digit
  @ Store 'N', '/', 'A' if the integer is outside the range -99 ... 0 ... 99

  CMP     R3, #0                @ if (x != 0)
  BEQ     Zero                  @ { 

  MOV     R0, #'+'              @ Initialise r0 to '+'

  CMP     R3, #0                @ if (x < 0)
  BGE     Division              @ {

Negative:                       @
  MOV     R0, #'-'              @ r0 = '-'
  RSB     R3, R3, #0            @ r3 = 0 - r3

Division:                       @ }
  MOV     R10, #10              @ Initialise r10 to #10
  UDIV    R2, R3, R10           @ r2 = x / 10
  MUL     R2, R2, R10           @ r2 *= 10
  SUB     R2, R3, R2            @ r2 = x - r2
  UDIV    R1, R3, R10           @ r1 = x / 10
  CMP     R1, #10               @ if (r1 < 10)
  BGE     NA                    @ {
  ADD     R1, R1, #0x30         @ r1 += #0x30
  ADD     R2, R2, #0x30         @ r2 += #0x30
  B       End                   @ } else {

NA:                             @
  MOV     R0, #'N'              @ r0 = N 
  MOV     R1, #'/'              @ r1 = /
  MOV     R2, #'A'              @ r2 = A
  B       End                   @ }

Zero:                           @ } else {
  MOV     R1, #0x30             @ r1 = #0x30
  MOV     R2, #0x30             @ r2 = #0x30
  MOV     R0, #0x20             @ r0 = #0x20

End:                            @ }

  @ End of program ... check your result

End_Main:
  BX    lr

.end
