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

  MOV     R3, #0            @ length = 0;

  CMP     R1, #0            @ if (numInMem != 0)
  BNE     NotZero           @ {
  MOV     R2, #'0'          @   
  STRB    R2, [R0]          @   num = 0;
  B       End               @ }
NotZero:                    @ else
                            @ {
  MOV     R2, #'+'          @   sign = ("-");
  CMP     R1, #0            @   if (numInMem < 0)
  BGT     Posi              @   {
  MOV     R2, #'-'          @     sign = ("+");
  RSB     R1, R1, #0        @     numInMem = 0 - numInMem;
Posi:                       @   }
  STRB    R2, [R0]          @   num = sign;

  MOV     R10, #10          @   devisor = 10;
  MOV     R11, #10          @   numberTen = 10;

  MOV     R2, R1            @   currNum = numInMem;
Length:                     @   length = 0;
  CMP     R2, #0            @   while (currNum != 0)
  BEQ     EndLength         @    { 
  ADD     R3, R3, #1        @     length = length + 1;
  UDIV    R2, R2, R10       @     currNum = currNum / devisor;
  B       Length            @    }
EndLength:                  @

  ADD     R0, R0, R3        @    address = address + length

DivLoop:                    @    while (length > 0)
  CMP     R3, #0            @    {
  BLE     End               @
  MOV     R4, R1            @      temp = numInMem;
  UDIV    R2, R4, R10       @      remainder = temp / divisor;
  MUL     R4, R2, R10       @      temp = remainder * divisor;
  SUB     R2, R1, R4        @      remainder = numInMem - temp;
  ADD     R2, #0x30         @      remainder = "numInMem";
  STRB    R2, [R0]          @      num = num + reminder;
  SUB     R0, R0, #1        @      address = address - 1;
  SUB     R3, R3, #1        @      length = length - 1;
  UDIV    R1, R1, R10       @      numInMem = numInMem / divisor;
  B       DivLoop           @    }
End:                        @ }

  @ End of program ... check your result

End_Main:
  BX    lr

