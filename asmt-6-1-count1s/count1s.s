  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  MOV     R0, #0            @ amountOfOnes = 0;
  MOV     R2, #0            @

  MOV     R4, #0            @ i = 0;
Count:                      @ while(i < 32)
  CMP     R4, #32           @ {
  BHS     EndCount          @ 

  MOVS    R1, R1, LSL #1    @     checkBit = num.MostSignificant;
  BCC     EndIf             @     if(checkBit==1) {
  ADD     R2, R2, #1        @         tempOnes++;
  B       ElseSkip          @
EndIf:                      @     } else {
  MOV     R2, #0            @     tempOnes = 0;
ElseSkip:                   @     }

  CMP     R2, R0            @     if(tempOnes>amountOfOnes)
  BLO     EndIf2            @     {
  MOV     R0, R2            @     amountOfOnes = tempOnes;
EndIf2:                     @     }

  ADD     R4, R4, #1        @     i++;
  B       Count             @
EndCount:                   @ }

End_Main:
  BX    lr

.end
