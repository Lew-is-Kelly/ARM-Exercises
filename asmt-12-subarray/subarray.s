  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

 @ R12 = Current element of arrayB (elemB) 
 @ R11 = Current element of arrayA (elemA)
 @ R10 = noCheckLimit
 @ R9  = isSubArr
 @ R8  = index
 @ R7  = colB
 @ R6  = rowB
 @ R5  = colA
 @ R4  = rowA
 @ R3  = Dimension of arrayB (maxB)
 @ R2  = Start addr of arrayB (addrB)
 @ R1  = Dimension of arrayA (maxA)
 @ R0  = Start addr of arrayA (addrA)

  SUB     R10, R1, R3               @ int noCheckLimit = maxA - maxB;
  MOV     R9, #0                    @ boolean isSubArr = false;

  MOV     R4, #0                    @
ForOne:                             @ for (int rowA = 0; isSubArr == false && rowA <= noCheckLimit; rowA++) {
  CMP     R9, #1                    @
  BEQ     EndForOne                 @
  CMP     R4, R10                   @
  BHI     EndForOne                 @


  MOV     R5, #0                    @
ForTwo:                             @   for (int colA = 0; isSubArr == false && colA <= noCheckLim; colA++) {
  CMP     R9, #1                    @
  BEQ     EndForTwo                 @
  CMP     R5, R10                   @
  BHI     EndForTwo                 @

  MOV     R9, #1                    @     isSubArr = true;

  MOV     R6, #0                    @
ForThree:                           @     for (int rowB = 0; isSubArr == true && rowB < maxB; rowB++) {
  CMP     R9, #0                    @
  BEQ     EndForThree               @
  CMP     R6, R3                    @
  BHS     EndForThree               @

  MOV     R7, #0                    @
ForFour:                            @       for (int colB = 0; isSubArr == true && colB < maxB; colB++) {
  CMP     R9, #0                    @
  BEQ     EndForFour                @
  CMP     R7, R3                    @
  BHS     EndForFour                @

  MOV     R8, #0                    @         int index = 0;

  ADD     R8, R4, R6                @         index = rowA + rowB;
  MUL     R8, R8, R1                @         index *= maxA;
  ADD     R10, R7, R5               @         int temp = colB + colA;
  ADD     R8, R8, R10               @         index += temp;
  LDR     R11, [R0, R8, LSL#2]      @         elemA = arrayA[addrA + (index * 4)];

  MUL     R8, R6, R3                @         index = rowB * maxB;
  ADD     R8, R7                    @         index += colB;
  LDR     R12, [R2, R8, LSL#2]      @         elemB = arrayB[addrB + (index * 4)];

  SUB     R10, R1, R3               @         noCheckLimit = maxA - maxB;

  CMP     R11, R12                  @         if (elemA != elemB) {
  BEQ     SkipIf                    @
  MOV     R9, #0                    @           isSubArr = false;
SkipIf:                             @         }

  ADD     R7, R7, #1                @
  B       ForFour                   @
EndForFour:                         @       }

  ADD     R6, R6, #1                @
  B       ForThree                  @
EndForThree:                        @     }

  ADD     R5, R5, #1                @
  B       ForTwo                    @
EndForTwo:                          @   }

  ADD     R4, R4, #1                @
  B       ForOne                    @
EndForOne:                          @ }

  MOV     R0, R9                    @ boolean done = isSubArr;
  
End_Main:
  BX    lr

