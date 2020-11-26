  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @ write your program here

  MOV     R12, #0          @ i1 = 0;
  MOV     R11, #0          @ i2 = 0;
  MOV     R0, #0           @ mode = 0;
  MOV     R10, #0          @ modeCount = 0;

While1:                    @
  CMP     R12, R2          @ while (i1 < N)
  BHS     End              @ {
  LDR     R8, [R1]         @   value1 = word[address1];
  MOV     R9, #0           @   count = 0;
  ADD     R6, R1, #4       @   address2 = address1 + 4;
  ADD     R11, R12, #1     @   i2 = i1 + 1;

While2:                    @
  CMP     R11, R2          @   while (i2 < N)
  BHS     EndWh2           @   {
  LDR     R3, [R6]         @     value2 = word[address2];
  CMP     R8, R3           @     if (value1 == value2)
  BNE     IfNotEqu         @     {
  ADD     R9, R9, #1       @       count = count + 1;

IfNotEqu:                  @     }
  ADD     R11, R11, #1     @     i2 = i2 + 1;
  ADD     R6, R6, #4       @     address2 = address2 + 4;
  B       While2           @   }

EndWh2:                    @
  CMP     R9, R10          @   if (count > modeCount)
  BLE     EndIf            @   {
  MOV     R0, R8           @     mode = value1;
  MOV     R10, R9          @     modeCount = count;
  
EndIf:                     @   }
  ADD     R12, R12, #1     @   i1 = i1 + 1;
  ADD     R1, R1, #1       @   address1 = address1 + 4
  B       While1           @ }
End:                       @

  @ End of program ... check your result

End_Main:
  BX    lr

