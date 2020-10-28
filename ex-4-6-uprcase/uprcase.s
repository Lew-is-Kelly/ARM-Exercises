  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Convert the character in R0 to upper case

  @ if (char >= 'a' AND char =< 'z')
  @ {
  @   char = char - 0x20
  @ }

  CMP   R0, #'a'      @ if (char >= 'a'
  BLO   EndIfLc       @   AND
  CMP   R0, #'z'      @   char <='z')
  BHI   EndIfLc       @ {
  SUB   R0, R0, #0x20 @   char = char - 0x20
EndIfLc:              @ }

  @ End of program ... check your result

End_Main:
  BX    lr

.end