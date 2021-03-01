  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @
  @ You can use either
  @
  @   The System stack (R13/SP) with PUSH and POP operations
  @
  @   or
  @
  @   A user stack (R12 has been initialised for this purpose)
  @

  MOV     R7, #10         @ ten = 10;
  MOV     R10, #0x30      @ hex30 = 0x30;
  MOV     R11, #1         @ one = 1;
  SUB     R1, R1, R11     @ addr -= one;

While:                    @ for (addr = addr; elem != null; addr++) {
  ADD     R1, R1, #1      @
  LDRB    R2, [R1]        @   elem = array[addr];
  CMP     R2, #0          @
  BEQ     End             @

  CMP     R2, ' '         @   if (elem == ' ') {
  BNE     NotSpace        @
  B       Continue        @     continue;
NotSpace:                 @   } 

  CMP     R2, '*'         @   else if (elem == '*') {
  BNE     NotTimes        @

  POP     {R4}            @     op2 = STACK.pop();
  POP     {R3}            @     op1 = STACK.pop();
  MUL     R2, R3, R4      @     elem = op1 * op2;
  PUSH    {R2}            @     STACK.push(elem);
  B       Continue        @     continue;
NotTimes:                 @   }

  CMP     R2, '+'         @   else if (elem == '+') {
  BNE     NotPlus         @   

  POP     {R4}            @     op2 = STACK.pop();
  POP     {R3}            @     op1 = STACK.pop();
  ADD     R2, R3, R4      @     elem = op1 + op2;
  PUSH    {R2}            @     STACK.push(elem);
  B       Continue        @     continue;
NotPlus:                  @   }

  CMP     R2, '-'         @   else if (elem == '-') {
  BNE     NotMinus        @

  POP     {R4}            @     op2 = STACK.pop();
  POP     {R3}            @     op1 = STACK.pop();
  SUB     R2, R3, R4      @     elem = op1 - op2;
  PUSH    {R2}            @     STACK.push(elem);
  B       Continue        @     continue;
NotMinus:                 @   }

  CMP     R2, '0'         @   else if (elem >= '0' && elem <= '9') {
  BLT     Continue        @     
  CMP     R2, '9'         @
  BHI     Continue        @

  SUB     R2, R2, R10     @     elem -= 0x30;
  MOV     R5, R1          @     tempAddr = addr;

MoreDigits:               @     while (tempElem >= '0' && tempElem <= '9') {
  ADD     R5, R5, #1      @       tempAddr++;
  LDRB    R6, [R5]        @       tempElem = array[tempAddr];
  CMP     R6, '0'         @
  BLT     EndMoreDigits   @
  CMP     R6, '9'         @
  BHI     EndMoreDigits   @
  SUB     R6, R6, R10     @       tempElem -= 0x30;
  MUL     R2, R2, R7      @       elem *= 10;
  ADD     R2, R2, R6      @       elem += tempElem;
  MOV     R1, R5          @       addr = tempAddr
  B       MoreDigits      @
EndMoreDigits:            @     }

  PUSH    {R2}            @     STACK.push(elem);

Continue:                 @   }
  B       While           @ }

End:                      @
  POP     {R0}            @ answer = STACK.pop()

End_Main:
  BX    lr

