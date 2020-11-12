  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
                      @ address initialised in test.s
  LDRB  R2, [R1]      @ ch = byte[address];
While:                @
  CMP   R2, #0        @ while (ch != 0)
  BEQ   EndWhile      @ {
  CMP   R2, #'a'      @   if (ch >= 'a' && ch <= 'z')
  BLO   EndIfLwr      @   {
  CMP   R2, #'z'      @
  BHI   EndIfLwr      @
  SUB   R2, R2, #0x20 @     ch = ch - 0x20;
  STRB  R2, [R1]      @     byte[address] = ch;
EndIfLwr:             @   }
  ADD   R1, R1, #1    @   address = address + 1;
  LDRB  R2, [R1]      @   ch = byte[address];
  B     While         @ }
EndWhile:

  @ End of program ... check your result

End_Main:
  BX    lr

