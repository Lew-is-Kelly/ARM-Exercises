  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @ R0 = boolean isAnagram
  @ R1 = addrA
  @ R2 = addrB
  @ R3 = elemA
  @ R4 = elemB
  @ R5 = lengthA
  @ R6 = lengthB
  @ R7 = iC
  @ R8 = 1
  @ R9 =          -Not used
  @ R10 =         -Not used
  @ R11 = addrT2
  @ R12 = addrT

  MOV     R0, #0            @ boolean isAnagram = false;

  MOV     R12, R1           @ addrT=addrA;
  MOV     R11, R2           @ addrT2=addrB;

Counter:                    @ while (elemA!=0)
  LDRB    R3, [R12]         @ {   elemA=[addrT];
  CMP     R3, #0            @
  BEQ     EndCount1         @
  CMP     R3, #91           @     if(elemA<91)
  BHI     Cap1              @     {
  ADD     R3, R3, #32       @         elemA+=32;
  STRB    R3, [R12]         @         [addrT]=elemA;
Cap1:                       @     }
  ADD     R5, R5, #1        @     lengthA+=1;
  ADD     R12, R12, #1      @     addrT+=1;
  B       Counter           @ }
EndCount1:                  @ while (elemB!=0)
  LDRB    R4, [R11]         @ {   elemB=[addrT2]
  CMP     R4, #0            @
  BEQ     EndCount2         @
  CMP     R4, #91           @     if(elemB<91)
  BHI     Cap2              @     {
  ADD     R4, R4, #32       @         elemB+=32;
  STRB    R4, [R11]         @         [addrT2]=elemB;
Cap2:                       @     }
  ADD     R6, R6, #1        @     lengthB+=1;
  ADD     R11, R11, #1      @     addrT2+=1;
  B       EndCount1         @ }
EndCount2:                  @

  MOV     R7, #0            @ int iC=0;
  MOV     R8, #1            @ 1=1;            

  CMP     R5, R6            @ if(lenghtA==lenghtB)
  BNE     End               @ {

While1:                     @     while(elemA!=0)         
  LDRB    R3, [R1]          @     {   elemA=[addrA];
  CMP     R3, #0            @
  BEQ     EndWh1            @
  MOV     R12, R2           @         addrT=addrB;

While2:                     @         while(elemB!=0)
  LDRB    R4, [R12]         @         {   elemB=[addrT];
  CMP     R4, #0            @
  BEQ     EndWh2            @
  CMP     R3, R4            @             if(elemA==elemB)
  BNE     EndIf             @             {
  ADD     R7, R7, #1        @                 iC+=1;
  STRB    R8, [R12]         @                 [addrT]=1;
  B       EndWh2            @
EndIf:                      @             } else
  ADD     R12, R12, #1      @             {   addrT+=1;
  B       While2            @             }
EndWh2:                     @         

  ADD     R1, R1, #1        @         addrA+=1;
  B       While1            @     }
EndWh1:                     @

  CMP     R7, R5            @     if(iC==lengthA)
  BNE     End               @     {
  MOV     R0, #1            @         isAnagram=true;
                            @     }
End:                        @ }

  @ End of program ... check your result

End_Main:
  BX    lr

