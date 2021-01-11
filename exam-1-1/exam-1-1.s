  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  

  @
  @ Write your program here
  @

  @ R0 = adrC
  @ R1 = adrA
  @ R2 = adrB
  @ R3 = elemA
  @ R4 = elemB
  @ R5 = sizeA
  @ R6 = sizeB
  @ R7 = bool
  @ R8 = countC
  @ R9 = countT
  @ R10 = adrTC 
  @ R11 = adrTA
  @ R12 = adrTB

  LDR     R5, [R1]          @ sizeA = word[adrA];
  ADD     R1, R1, #4        @ adrA = adrA + 4;
  LDR     R6, [R2]          @ sizeB = word[adrB];
  ADD     R2, R2, #4        @ adrB = adrB + 4;
  MOV     R11, R1           @ adrTA = adrA;
  MOV     R12, R2           @ adrTB = adrB;

  MOV     R8, #0            @ countC = 0;
  MOV     R9, #0            @ countT = 0;

  CMP     R5, #0            @ if(sizeA == 0)
  BNE     HasDigits         @ {
  CMP     R6, #0            @     if(sizeB == 0)
  BNE     HasDigits         @     {
  B       EndLoopB          @         continue End;
HasDigits:                  @     } 
                            @ }

  MOV     R10, R0           @ adrTC = adrC;
  ADD     R0, R0, #4        @ adrC = adrC + 4;

  STR     R9, [R10]         @ word[adrTC] = countT;
  
LoopA:                      @ while(sizeA != countT)
  LDR     R3, [R1]          @ {   elemA = word[adrA];
  CMP     R5, R9            @
  BEQ     EndLoopA          @
  MOV     R7, #0            @     boolean bool = false;
  MOV     R2, R12           @     adrB = adrTB;
  MOV     R9, #0            @     countT = 0;

LoopAB:                     @     while(sizeB != countT)
  LDR     R4, [R2]          @     {   elemB = word[adrB];
  CMP     R6, R9            @
  BEQ     EndLoopAB         @         

  CMP     R3, R4            @         if(elemA == elemB)
  BNE     EndIfSame         @         {   
  MOV     R7, #1            @             bool = true;
EndIfSame:                  @         }

  ADD     R2, R2, #4        @         adrB = adrB + 4;
  ADD     R9, R9, #1        @         countT++;
  B       LoopAB            @
EndLoopAB:                  @     }

  CMP     R7, #1            @     if(bool)
  BEQ     EndIfBool         @     {
  STR     R3, [R0]          @         word[adrC] = elemA;
  ADD     R8, R8, #1        @         countC++;
  ADD     R0, R0, #4        @         adrC = adrC + 4;
EndIfBool:                  @     }

  ADD     R1, R1, #4        @     adrA = adrA + 4;
  LDR     R9, [R10]         @     countT = word[adrTC] 
  ADD     R9, R9, #1        @     countT++;
  STR     R9, [R10]         @     word[adrTC] = countT;
  B       LoopA             @ }
EndLoopA:                   @

  MOV     R2, R12           @ adrB = adrTB;
  MOV     R1, R11           @ adrA = adrTA;
  MOV     R9, #0            @ countT = 0;
  STR     R9, [R10]         @ word[adrTC] = countT;

LoopB:                      @ while(sizeB != countT)
  LDR     R4, [R2]          @ {   elemB = word[adrB];
  CMP     R6, R9            @
  BEQ     EndLoopB          @
  MOV     R7, #0            @     bool = false;
  MOV     R1, R11           @     adrA = adrTA;
  MOV     R9, #0            @     countT = 0;

LoopBA:                     @     while(sizeA != countT)
  LDR     R3, [R1]          @     {   elemA = word[adrA];
  CMP     R5, R9            @
  BEQ     EndLoopBA         @         

  CMP     R4, R3            @         if(elemB == elemA)
  BNE     EndIfSame2        @         {   
  MOV     R7, #1            @             bool = true;
EndIfSame2:                 @         }

  ADD     R1, R1, #4        @         adrA = adrA + 4;
  ADD     R9, R9, #1        @         countT++;
  B       LoopBA            @
EndLoopBA:                  @     }

  CMP     R7, #1            @     if(bool)
  BEQ     EndIfBool2        @     {
  STR     R4, [R0]          @         word[adrC] = elemB;
  ADD     R8, R8, #1        @         countC++;
  ADD     R0, R0, #4        @         adrC = adrC + 4;
EndIfBool2:                 @     }

  ADD     R2, R2, #4        @     adrB = adrB + 4;
  LDR     R9, [R10]         @     countT = word[adrTC] 
  ADD     R9, R9, #1        @     countT++;
  STR     R9, [R10]         @     word[adrTC] = countT;
  B       LoopB             @ }
EndLoopB:                   @ End:

  MOV     R0, R10           @ adrC = adrTC;
  STR     R8, [R0]          @ word[adrC] = countC;
  


  @
  @ REMEMBER: Sets are stored in memory in the format ...
  @
  @   size, element1, element2, element3, etc.
  @
  @ where size is the number of elements in the set, element1 is
  @   the first element, element2 is the second element, etc.
  @ 


  @
  @ Debugging tips:
  @
  @ If using the View Memory window
  @   - view set A using address "&setA" and size 64
  @   - view set B using address "&setB" and size 64
  @   - view set C using address "&setC" and size 64
  @
  @ If using a Watch Expression
  @   view set A using expression "(int[16])setA"
  @   view set B using expression "(int[16])setB"
  @   view set C using expression "(int[16])setC"
  @
  @ BUT REMEMBER, the first value you see should be the size, 
  @  the second value will be the first element, etc. (see above!)

  @ End of program ... check your result

End_Main:
  BX    lr

