  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   searchLR
  .global   uncapatalise

@ searchLR subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchLR:
  PUSH    {R4-R8, LR}       @ boolean searchLR(arrayAdr, stringAdr) {
  
  MOV     R6, #0            @   arrayColumn = 0;
  MOV     R7, #0            @   stringIndex = 0;
  MOV     R8, #0            @   arrayRow = 0;

Loop:                       @   while (stringLetter != null) {
  LDRB    R5, [R1, R7]      @     stringLetter = string[stringStart + stringIndex];
  CMP     R5, #0            @     
  BEQ     True              @                                                       // If the stringLetter is null it branches to a label that moves 1 into R0 at the end of the program.
  ADD     R9, R6, R8        @     arrayIndex + arrayColumn + arrayRow;
  CMP     R9, #144          @     if (arrayIndex > 144)
  BHI     False             @       return false;                                   // Goes to a label that moves 0 into R0 then branches to the end of the routine.
  LDRB    R4, [R0, R9]      @     arrayLetter = array[arrayStart + arrayIndex];
  ADD     R6, R6, #1        @     arrayColumn += 1;
  CMP     R6, #12           @     if (arrayColumn > 12)
  BLS     IncrementRow      @       {
  ADD     R8, R8, #12       @         arrayRow += 12;
  MOV     R6, #0            @         arrayColumn = 0;
  MOV     R7, #0            @         stringIndex = 0;
  B       Loop              @         continue;
IncrementRow:               @       }
  CMP     R4, R5            @     if (arrayLetter.equals(stringLetter))
  BNE     Loop              @     {
  ADD     R7, R7, #1        @       stringIndex += 1; }
  B       Loop              @   }

False:                      @
  MOV     R0, #0            @   return false;
  B       End               @
True:                       @   
  MOV     R0, #1            @   return true;
End:                        @

  POP     {R4-R8, PC}       @ }

.end