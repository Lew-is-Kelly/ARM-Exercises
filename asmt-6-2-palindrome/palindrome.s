  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  MOV     R0, #0            @ boolean isPal=false;

  MOV     R3, R1            @ addrT = addr1

  MOV     R4, #0            @ length=0;
Counter:                    @ Count: while(char!=0)
  LDRB    R2, [R1]          @ {   char = byte[addr1]
  CMP     R2, #0            @
  BEQ     EndCounter        @

  CMP     R2, #0x20         @     if(char>=' ' && char<='/')
  BLO     EndPuncIf1        @     {
  CMP     R2, #0x2f         @
  BHI     EndPuncIf1        @
  ADD     R1, R1, #1        @         addr1++;
  B       Counter           @         continue Count;
EndPuncIf1:                 @     }

  CMP     R2, #0x3a         @     if(char>=':' && char<='@')
  BLO     EndPuncIf2        @     {
  CMP     R2, #0x40         @
  BHI     EndPuncIf2        @
  ADD     R1, R1, #1        @         addr1++;
  B       Counter           @         continue Count;
EndPuncIf2:                 @     }

  CMP     R2, #0x5b         @     if(char>='[' && char<='`')
  BLO     EndPuncIf3        @     {
  CMP     R2, #0x60         @
  BHI     EndPuncIf3        @
  ADD     R1, R1, #1        @         addr1++;
  B       Counter           @         continue Count;
EndPuncIf3:                 @     }

  CMP     R2, #0x7b         @     if(char>='{' && char<='~')
  BLO     EndPuncIf4        @     {
  CMP     R2, #0x7e         @
  BHI     EndPuncIf4        @
  ADD     R1, R1, #1        @         addr1++;
  B       Counter           @         continue Count;
EndPuncIf4:                 @     }

  ADD     R4, R4, #1        @     length++;
  ADD     R1, R1, #1        @     addr1++;
  B       Counter           @     }
EndCounter:                 @

  SUB     R1, R1, #1        @ addr1--;

  MOV     R5, #0            @ count=0;
While:                      @ WhileLoop: while(addr1!=addrT)
  LDRB    R2, [R1]          @ {   char = byte[addrT]
  LDRB    R6, [R3]          @     char2 = byte[addr1]
  CMP     R1, R3            @ 
  BEQ     EndWhile          @
  CMP     R2, #0            @
  BEQ     EndWhile          @

  CMP     R2, #0x41         @     if(char>='A' && char<='Z')
  BLO     EndCapIf          @     {
  CMP     R2, #0x5a         @
  BHI     EndCapIf          @
  ADD     R2, R2, #32       @         char+=32;
EndCapIf:                   @      }

  CMP     R6, #0x41         @     if(char2>='A' && char2<='Z')
  BLO     EndCapIf2         @     {
  CMP     R6, #0x5a         @
  BHI     EndCapIf2         @
  ADD     R6, R6, #32       @         char+=32;
EndCapIf2:                  @      }

  CMP     R2, #0x20         @     if(char>=' ' && char<='/')
  BLO     EndPuncIf9        @     {
  CMP     R2, #0x2f         @
  BHI     EndPuncIf9        @
  SUB     R1, R1, #1        @         addr1--;
  B       While             @         continue WhileLoop;
EndPuncIf9:                 @     }

  CMP     R2, #0x3a         @     if(char>=':' && char<='@')
  BLO     EndPuncIf10       @     {
  CMP     R2, #0x40         @
  BHI     EndPuncIf10       @
  SUB     R1, R1, #1        @         addr1--;
  B       While             @         continue WhileLoop;
EndPuncIf10:                @     }

  CMP     R2, #0x5b         @     if(char>='[' && char<='`')
  BLO     EndPuncIf11       @     {
  CMP     R2, #0x60         @
  BHI     EndPuncIf11       @
  SUB     R1, R1, #1        @         addr1--;
  B       While             @         continue WhileLoop;
EndPuncIf11:                 @     }

  CMP     R2, #0x7b         @     if(char>='{' && char<='~')
  BLO     EndPuncIf12       @     {
  CMP     R2, #0x7e         @
  BHI     EndPuncIf12       @
  SUB     R1, R1, #1        @         addr1--;
  B       While             @         continue WhileLoop;
EndPuncIf12:                @     }

  CMP     R6, #0x20         @     if(char2>=' ' && char2<='/')
  BLO     EndPuncIf5        @     {
  CMP     R6, #0x2f         @
  BHI     EndPuncIf5        @
  ADD     R3, R3, #1        @         addrT++;
  B       While             @         continue WhileLoop;             
EndPuncIf5:                 @     }

  CMP     R6, #0x3a         @     if(char2>=':' && char2<='@')
  BLO     EndPuncIf6        @     {
  CMP     R6, #0x40         @
  BHI     EndPuncIf6        @
  ADD     R3, R3, #1        @         addrT++;
  B       While             @         continue WhileLoop;    
EndPuncIf6:                 @     }

  CMP     R6, #0x5b         @     if(char2>='[' && char2<='`')
  BLO     EndPuncIf7        @     {
  CMP     R6, #0x60         @
  BHI     EndPuncIf7        @
  ADD     R3, R3, #1        @         addrT++;
  B       While             @         continue WhileLoop;    
EndPuncIf7:                 @     }

  CMP     R6, #0x7b         @     if(char2>='{' && char2<='~')
  BLO     EndPuncIf8        @     {
  CMP     R6, #0x7e         @
  BHI     EndPuncIf8        @
  ADD     R3, R3, #1        @         addrT++;
  B       While             @         continue WhileLoop;    
EndPuncIf8:                 @     }

  CMP     R2, R6            @     if(char==char2)
  BNE     EndIf             @     {
  ADD     R5, R5, #1        @         count++;
EndIf:                      @     }

  ADD     R3, R3, #1        @     addrT++;
  SUB     R1, R1, #1        @     addr1--;
  B       While             @ 
EndWhile:                   @ }

  CMP     R2, R6            @ if(char==char2)
  BNE     EndIfFinal        @ {
  MOV     R12, #2           @     two=2;
  MUL     R5, R5, R12       @     count*=two;
  ADD     R5, R5, #1        @     count++;
EndIfFinal:                 @ }

  CMP     R5, R4            @ if(count==length)
  BNE     EndFinal          @ {
  MOV     R0, #1            @     isPal=true;
EndFinal:                   @ }

End_Main:
  BX    lr

