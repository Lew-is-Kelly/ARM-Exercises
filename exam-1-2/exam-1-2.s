  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  

  @
  @ write your program here
  @

  @ R0 = adrN
  @ R1 = adrO
  @ R2 = char
  @ R3 = space

  MOV     R3, #0            @ Boolean space = false;
  
While:                      @ while(char != 0)
  LDRB    R2, [R1]          @ {   char = byte[adrO];
  CMP     R2, #0            @
  BEQ     EndWhile          @

  CMP     R2, #0x20         @     if(char == 0x20)
  BNE     NotSpace          @     {
  MOV     R3, #1            @         space = true;
  B       EndIfStr          @         continue GoNext;
NotSpace:                   @     }

  CMP     R2, #0x41         @     if(char >= 0x41 && char <= 0x5a)
  BLO     EndIfCap          @     {   
  CMP     R2, #0x5a         @ 
  BHI     EndIfCap          @

  CMP     R3, #1            @         if(space)
  BNE     Space             @         {
  STRB    R2, [R0]          @             byte[adrN] = char;
  ADD     R0, R0, #1        @             adrN++;
  MOV     R3, #0            @             space = false;
  B       EndIfStr          @             continue GoNext;
Space:                      @         }

  ADD     R2, R2, #0x20     @         char = char + 0x30
EndIfCap:                   @     }

  CMP     R2, #0x61         @     if(char >= 0x61 && char <= 0x7a)
  BLO     EndIfStr          @     {
  CMP     R2, #0x7a         @
  BHI     EndIfStr          @

  CMP     R3, #1            @         if(space)
  BNE     Space2            @         {   
  SUB     R2, R2, #0x20     @             char = char - 0x20;
  MOV     R3, #0            @             space = false;
Space2:                     @         }

  STRB    R2, [R0]          @         byte[adrN] = char;
  ADD     R0, R0, #1        @         adrN++;
EndIfStr:                   @      }  

  ADD     R1, R1, #1        @      GoNext: adrO++;
  B       While             @
EndWhile:                   @ }

  @
  @ Debugging tips:
  @
  @ If using the View Memory window
  @   - view originalString using address "&originalString" and size 32
  @   - view newString using address "&newString" and size 32
  @
  @ If using a Watch Expression (array with ASCII character codes)
  @   view originalString using expression "(char[32])originalString"
  @   view newString using expression "(char[32])newString"
  @
  @ If using a Watch Expression (just see the string)
  @   view originalString using expression "(char*)&originalString"
  @   view newString using expression "(char*)&newString"
  @


  @ End of program ... check your result

End_Main:
  BX    lr

