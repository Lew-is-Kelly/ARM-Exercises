  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:
  
  @
  @ write your program here
  @
  @ TIP: To view memory when debugging your program you can ...
  @
  @   Add the following watch expression: (unsigned char [64]) strA
  @
  @   OR
  @
  @   Open a Memory View specifying the address 0x20000000 and length at least 11
  @   You can open a Memory View with ctrl-shift-p type view memory (cmd-shift-p on a Mac)
  @

  MOV     R2, #1              @ boolean isCap = true;
Loop:                         @
  LDRB    R0, [R1]            @ char = byte[address1];
  CMP     R0, #0              @ while (char != 0)
  BEQ     End                 @ {
  CMP     R0, #'A'            @   if (char > 'A' && char < 'Z')
  BLO     Else                @   {
  CMP     R0, #'Z'            @      
  BHI     Else                @
  CMP     R2, #1              @      if (!isCap)
  BEQ     IsCap               @      {
  ADD     R0, R0, #0x20       @         char = char + 0x20;
IsCap:                        @      }

  MOV     R2, #0              @      isCap = false;
  B       NextLoop            @

Else:                         @   }
  CMP     R0, #'a'            @   else if (char > 'a' && char < 'z')
  BLO     ElseIf              @   {
  CMP     R0, #'z'            @
  BHI     ElseIf              @
  CMP     R2, #1              @      if (isCap)
  BNE     NextLoop            @      {
  SUB     R0, R0, #0x20       @      char = char - 0x20;
  MOV     R2, #0              @      isCap = false;
  B       NextLoop            @      }
ElseIf:                       @   }
                              @   else
                              @   {
  MOV     R2, #1              @     isCap = true;
                              @   }
NextLoop:                     @
  STRB    R0, [R1]            @   byte[address1] = char;
  ADD     R1, R1, #1          @   address1 = address1 + 1;
  B     Loop                  @ }
End:

  @ End of program ... check your result

End_Main:
  BX    lr

