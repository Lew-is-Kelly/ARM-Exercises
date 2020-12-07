  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  @

 @ R1 = addrA
 @ R2 = addrB
 @ R3 = elemA
 @ R4 = elemB
 @ R5 = sizeA
 @ R6 = sizeB
 @ R7 = i1
 @ R8 = i2
 @ R9 = sizeC
 @ R10 = addrT
 @ R11 = addrT2
 @ R12 = addrT3

 LDR     R5, [R1]            @ sizeA = word[addrA];
 ADD     R1, R1, #4          @ addrA += 4;              @gets sizeA
 LDR     R6, [R2]            @ sizeB = word[addrB];
 ADD     R2, R2, #4          @ addrB += 4;              @gets sizeB

 MOV     R12, R0             @ addrT3 = addrC;
 ADD     R0, R0, #4          @ addrC = addrC + 4;       @puts addrC into a temporary address

 MOV     R10, R1             @ addrT = addrA;           @making a temporary address for addrA

 MOV     R7, #0              @ i1 = 0;

 MOV     R9, R5              @ sizeC = sizeA;           @makes the size of C the same as A so I dont have to count it.

Copy:                        @ while(i1<sizeA)          @copies A to C
 LDR     R3, [R10]           @ { elemA = word[addrT];
 CMP     R7, R5              @
 BGE     EndCpy              @
 STR     R3, [R0]            @    word[addrC] = elemA;
 ADD     R10, R10, #4        @    addrT = addrT + 4;
 ADD     R0, R0, #4          @    addrC = addrC + 4;
 ADD     R7, R7, #1          @    i1 = i1 + 1;
 B       Copy                @
EndCpy:                      @ }

 MOV     R8, #0              @ i2 = 0;

While1:                      @ while(i2<sizeB)
 CMP     R8, R6              @ {
 BGT     EndWh1              @
 LDR     R4, [R2]            @     elemB = word[addrB];
 MOV     R7, #0              @     i1 = 0;
 MOV     R11, R1             @     addrT2 = addrA;

While2:                      @     while(i1<sizeA)
 CMP     R7, R5              @     {
 BGT     EndWh2              @
 LDR     R3, [R11]           @         elemA = word[addrT2];
 CMP     R3, R4              @         if(elemA==elemB)
 BNE     EndIf               @         {
 MOV     R7, R5              @             i1 = sizeA;
 B       Eq                  @
EndIf:                       @         }
                             @         else
                             @         {
 ADD     R11, R11, #4        @         addrT2 = addrT2 + 4;
 ADD     R7, R7, #1          @         i1 = i1 + 1;
 B       While2              @         }
EndWh2:                      @     }

 STR     R4, [R0]            @     word[addrC] = elemB;
 ADD     R0, R0, #4          @     addrC = addrC + 4;
 ADD     R9, R9, #1          @     sizeC = sizeC + 1;
Eq:                          @
 ADD     R2, R2, #4          @     addrB = addrB + 4;
 ADD     R8, R8, #1          @     i2 = i2 + 1;
 B       While1              @
EndWh1:                      @ }

 STR     R9, [R12]           @ word[addrT3] = sizeC;

  @ End of program ... check your result

End_Main:
  BX    lr

