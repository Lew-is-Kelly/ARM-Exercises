  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   wordsearch
  .global   searchLR
  .global   searchTB
  .global   searchTLBR


@ wordsearch subroutine
@ 
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of sequence of strings
@ Return:
@   R0: number of strings that were found
wordsearch:
  PUSH    {R4-R8, LR}       @ wordsearch(arrayAdr, stringAdr) {

  MOV     R4, #0            @   stringAmount = 0;
  MOV     R6, #0            @   stringIndex = 0;

WordLoop:                   @   while (string[stringAdr + stingIndex] != 0 & string[stringAdr + stringIndex + 1] != 0) {
  LDRB    R5, [R1, R6]      @     stringLetter = string[stringAdr + stringIndex]
  CMP     R5, #0            @     if (stringLetter == 0)
  BNE     OneNull           @     {
  ADD     R6, R6, #1        @       stringIndex++;
  LDRB    R5, [R1, R6]      @       stringLetter = string[stringAdr + stringIndex];
  CMP     R5, #0            @       if (stringLetter == 0)
  BEQ     TwoNull           @         { break; }
OneNull:                    @     }
  MOV     R7, R0            @     temp1 = arrayAdr;
  MOV     R8, R1            @     temp2 = stringAdr;
  ADD     R1, R6, R8        @     stringAdr = stringIndex + stringAdr;
  BL      searchLR          @     searchLR(arrayAdr, stringAdr);
  CMP     R0, #1            @     if (searchLR(arrayAdr, stringAdr))
  BNE     NoLR              @     {
  ADD     R4, R4, #1        @       stringAmount++;
NoLR:                       @     }
  MOV     R0, R7            @     arrayAdr = temp1;
  MOV     R1, R8            @     stringAdr = temp2;

  MOV     R7, R0            @     temp1 = arrayAdr;
  MOV     R8, R1            @     temp2 = stringAdr;
  ADD     R1, R6, R8        @     stringAdr = stringIndex + stringAdr;
  BL      searchTB          @     searchTB(arrayAdr, stringAdr);
  CMP     R0, #1            @     if (searchTB(arrayAdr, stringAdr))
  BNE     NoTB              @     {
  ADD     R4, R4, #1        @       stringAmount++;
NoTB:                       @     }
  MOV     R0, R7            @     arrayAdr = temp1;
  MOV     R1, R8            @     stringAdr = temp2;

  MOV     R7, R0            @     temp1 = arrayAdr;
  MOV     R8, R1            @     temp2 = stringAdr;
  ADD     R1, R6, R8        @     stringAdr = stringIndex + stringAdr;
  BL      searchTLBR        @     searchTLBR(arrayAdr, stringAdr);
  CMP     R0, #1            @     if (searchTLBR(arrayAdr, stringAdr))
  BNE     NoTLBR            @     {
  ADD     R4, R4, #1        @       stringAmount++;
NoTLBR:                     @     }
  MOV     R0, R7            @     arrayAdr = temp1;
  MOV     R1, R8            @     stringAdr = temp2;

ZeroLoop:                   @     while (stringLetter != 0)
  CMP     R5, #0            @     {
  BEQ     BackToWordLoop    @       
  ADD     R6, R6, #1        @       stringIndex++;
  LDRB    R5, [R1, R6]      @       stringLetter = string[stringAdr + stringIndex];
  B       ZeroLoop          @

BackToWordLoop:             @     }
  ADD     R6, R6, #1        @     stringIndex++;
  B       WordLoop          @   }

TwoNull:                    @
  MOV     R0, R4            @   return stringAmount;

  POP     {R4-R8, PC}       @ }


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
  CMP     R9, #144          @     if (arrayIndex >= 144)
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



@ searchTB subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchTB:
  PUSH    {R4-R9, LR}       @ boolean seacrhTB(arrayAdr, stringAdr) {

  MOV     R6, #0            @   arrayColumn = 0;
  MOV     R7, #0            @   stringIndex = 0;
  MOV     R8, #0            @   arrayRow = 0;

  LDRB    R5, [R1]          @     stringLetter = string[stringStart];

LoopTB:                     @   while (arrayIndex < 144) {
  CMP     R9, #144          @
  BHS     FalseTB           @                                                       // Goes to a label that moves 0 into R0 then branches to the end of the routine.
  ADD     R9, R6, R8        @     arrayIndex + arrayColumn + arrayRow;
  LDRB    R4, [R0, R9]      @     arrayLetter = array[arrayStart + arrayIndex];
  ADD     R6, R6, #1        @     arrayColumn += 1;
  CMP     R6, #12           @     if (arrayColumn >= 12)
  BLO     IncrementRowTB    @      {
  ADD     R8, R8, #12       @         arrayRow += 12;
  MOV     R6, #0            @         arrayColumn = 0;
  B       LoopTB            @         continue;
IncrementRowTB:             @      }

  CMP     R4, R5            @     if (arrayLetter.equals(stringLetter))
  BNE     LoopTB            @     {
  MOV     R11, R0           @       temp1 = arrayAdr;
  MOV     R10, R1           @       temp2 = stringadr
  ADD     R2, R6, R8        @       arrayIndex = arrayColumn + arrayRow;    
  BL      countDown         @       countDown(arrayAdr, stringAdr, arrayIndex);
  LDRB    R1, [R10, R0]     @       stringLetter = string[temp2 + countdown(arrayAdr, stringAdr, arrayIndex)];
  CMP     R1, #0            @       if (stringLetter == null)
  BEQ     TrueTB            @         { reutrn true; }                            // Branches to a label that moves 1 into R0 at the end of the program.
  MOV     R0, R11           @       arrayAdr = temp1;
  MOV     R1, R10           @       stringAdr = temp2;
                            @     }
  B       LoopTB            @   }

FalseTB:                    @
  MOV     R0, #0            @   return false;
  B       EndTB             @
TrueTB:                     @   
  MOV     R0, #1            @   return true;
EndTB:                      @

  POP     {R4-R9, PC}       @ }

@ countDown subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@   R2: arrayIndex
@ Return:
@   R0: count of the amount of characters in the string, which can be added to the address to return null
countDown:                  @
  PUSH    {R4-R6, LR}       @ countDown(arrayAdr, stringAdr, arrayIndex) {

  MOV     R6, #0            @   StringIndex = 0;

  ADD     R2, R2, #11       @   arrayIndex += 11;

WhLoop:
  CMP     R2, #144          @   while (arrayIndex < 144)
  BHS     EndWh             @   {
  ADD     R6, R6, #1        @     stringIndex++;
  LDRB    R4, [R0, R2]      @     arrayLetter = array[arrayAdr + arrayIndex];
  LDRB    R5, [R1, R6]      @     stringLetter = string[stringAdr + stringIndex];
  CMP     R5, R4            @     if (!stringLetter.equals(arrayLetter))
  BNE     EndWh             @     { break; }
  ADD     R2, R2, #12       @     arrayIndex += 12;
  B       WhLoop            @   }

EndWh:                      @
  MOV     R0, R6            @   return stringIndex;

  POP     {R4-R6, PC}       @ }



@ searchTLBR subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@ Return:
@   R0: 0 if the string was not found, 1 if it was found
searchTLBR:
  PUSH    {R4-R9, LR}       @ boolean seacrhTB(arrayAdr, stringAdr) {

  MOV     R6, #0            @   arrayColumn = 0;
  MOV     R7, #0            @   stringIndex = 0;
  MOV     R8, #0            @   arrayRow = 0;
  MOV     R9, #0            @   arrayIndex = 0;

  LDRB    R5, [R1]          @     stringLetter = string[stringStart];

LoopTLBR:                   @   while (arrayIndex < 144) {
  CMP     R9, #144          @
  BHS     FalseTLBR         @                                                       // Goes to a label that moves 0 into R0 then branches to the end of the routine.
  ADD     R9, R6, R8        @     arrayIndex + arrayColumn + arrayRow;
  LDRB    R4, [R0, R9]      @     arrayLetter = array[arrayStart + arrayIndex];
  ADD     R6, R6, #1        @     arrayColumn += 1;
  CMP     R6, #12           @     if (arrayColumn >= 12)
  BLO     IncrementRowTLBR  @      {
  ADD     R8, R8, #12       @         arrayRow += 12;
  MOV     R6, #0            @         arrayColumn = 0;
  B       LoopTLBR          @         continue;
IncrementRowTLBR:           @      }

  CMP     R4, R5            @     if (arrayLetter.equals(stringLetter))
  BNE     LoopTLBR          @     {
  MOV     R9, R0            @       temp1 = arrayAdr;
  MOV     R10, R1           @       temp2 = stringadr
  ADD     R2, R6, R8        @       arrayIndex = arrayColumn + arrayRow;    
  BL      countDownPlusOne  @       countDown(arrayAdr, stringAdr, arrayIndex);
  LDRB    R1, [R10, R0]     @       stringLetter = string[temp2 + countdown(arrayAdr, stringAdr, arrayIndex)];
  CMP     R1, #0            @       if (stringLetter == null)
  BEQ     TrueTLBR          @         { reutrn true; }                            // Branches to a label that moves 1 into R0 at the end of the program.
  MOV     R0, R9            @       arrayAdr = temp1;
  MOV     R1, R10           @       stringAdr = temp2;
                            @     }
  B       LoopTLBR          @   }

FalseTLBR:                  @
  MOV     R0, #0            @   return false;
  B       EndTLBR           @
TrueTLBR:                   @   
  MOV     R0, #1            @   return true;
EndTLBR:                    @

  POP     {R4-R9, PC}       @ }

@ countDownPlusOne subroutine
@
@ Parameters:
@   R0: start address of 2D array
@   R1: start address of string
@   R2: arrayIndex
@ Return:
@   R0: count of the amount of characters in the string, which can be added to the address to return null
countDownPlusOne:           @
  PUSH    {R4-R6, LR}       @ countDown(arrayAdr, stringAdr, arrayIndex) {

  MOV     R6, #0            @   StringIndex = 0;

  ADD     R2, R2, #12       @   arrayIndex += 12;

WhLoopPlusOne:
  CMP     R2, #144          @   while (arrayIndex < 144)
  BHS     EndWhPlusOne      @   {
  ADD     R6, R6, #1        @     stringIndex++;
  LDRB    R4, [R0, R2]      @     arrayLetter = array[arrayAdr + arrayIndex];
  LDRB    R5, [R1, R6]      @     stringLetter = string[stringAdr + stringIndex];
  CMP     R5, R4            @     if (!stringLetter.equals(arrayLetter))
  BNE     EndWhPlusOne      @     { break; }
  ADD     R2, R2, #13       @     arrayIndex += 12;
  B       WhLoopPlusOne     @   }

EndWhPlusOne:               @
  MOV     R0, R6            @   return stringIndex;

  POP     {R4-R6, PC}       @ }


.end