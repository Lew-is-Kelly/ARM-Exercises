  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @ Debugging tip:
  @ Use the watch expression ...
  @
  @   (signed int [64]) setC
  @
  @ ... to view your intersection set as your program creates it
  @ in memory.

  @ sizeA = R3
  @ sizeB = R4
  @ adrA = R1
  @ adrB = R2
  @ iA = R8
  @ iB = R7
  @ elemA = R5
  @ elemB = R6
  @ adrTmp = R10

  MOV     R8, #0            @ iA = 0;
                            @ 
WhileA:                     @ while (iA < sizeA)
  CMP     R8, R3            @ {
  BGE     EndWhA            @  
  LDR     R5, [R1]          @     elemA = word[AdrA];
  MOV     R10, R2           @     adrTmp = adrB;
  MOV     R7, #0            @     iB = 0;
                            @
WhileB:                     @     while (iB < sizeB)
  CMP     R7, R4            @     {
  BGE     EndWhB            @     
  LDR     R6, [R10]         @         elemB = word[adrTmp];
                            @
  CMP     R5, R6            @         if (elemA == elemB)
  BNE     EndIf             @         {
  STR     R5, [R0]          @             word[adrC] = elemA;
  ADD     R0, R0, #4        @             adrC = adrC + 4;
EndIf:                      @         }
                            @
  ADD     R10, R10, #4      @         adrTmp = adrTmp + 4;
  ADD     R7, R7, #1        @         iB = iB + 1;
  B       WhileB            @     }
EndWhB:                     @
                            @
  ADD     R1, R1, #4        @     adrA = adrA = 4;
  ADD     R8, R8, #1        @     iA = iA + 1;
  B       WhileA            @ }
EndWhA:                     @

  @ End of program ... check your result

End_Main:
  BX    lr

