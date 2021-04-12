  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   fp_add

@ fp_add subroutine
@ Add two IEEE-754 floating point numbers
@
@ Paramaters:
@   R0: a - first number
@   R1: b - second number
@
@ Return:
@   R0: result - a+b
@
fp_add:
  PUSH    {R7-R12, LR}            @ add any registers R4...R12 that you use
                                    @R0 = a
                                    @R1 = b
                                    @R2 = 
                                    @R3 = 
                                    @R4 = 
                                    @R5 =
                                    @R6 =
                                    @R7 = firstFraction
                                    @R8 = secondFreaction
                                    @R9 = firstExponent
                                    @R10= secondExponent
                                    @R11= firstNumber
                                    @R12= secondNumber

                                    @ fp_add(a, b) {
  MOV     R11, R0                   @   firstNumber = a;
  MOV     R12, R1                   @   secondNumber = b;
  BL      fp_exp                    @   a = fp_exp(a);
  MOV     R9, R0                    @   firstExponent = a;
  MOV     R0, R12                   @   a = secondNumber;
  BL      fp_exp                    @   a = fp_exp(a);
  MOV     R10, R0                   @   secondExponent = a;       //gets exponents

  MOV     R0, R11                   @   a = firstNumber;
  BL      fp_frac                   @   a = fp_frac(a);
  MOV     R7, R0                    @   firstFraction = a;
  MOV     R0, R12                   @   a = secondNumber;
  BL      fp_frac                   @   a = fp_frac(a);
  MOV     R8, R0                    @   secondFraction = a;       //gets fractions

  CMP     R9, R10                   @   if (firsExponent > secondExp)
  BLE     SecondBigger              @   {
  SUB     R1, R9, R10               @     b = firstExponent - secondExponent;
  ASR     R8, R8, R1                @     firstFraction >>> b;
  MOV     R1, R9                    @     b = firstEcponent;
  B       ExpOver                   @   
SecondBigger:                       @   } else

  CMP     R9, R10                   @   if (firstExponent != secondExponent)
  BEQ     Equal                     @   {
  SUB     R1, R10, R9               @     b = secondExponent - firstExponent;
  ASR     R7, R7, R1                @     secondFraction >>> b;
  MOV     R1, R10                   @     b = secondExponent;
  B       ExpOver                   @   } else

Equal:                              @   {
  MOV     R1, R9                    @     b = firstExponent;
ExpOver:                            @   }

  ADD     R0, R7, R8                @   a = firstFraction + secondFraction;
  BL      fp_enc                    @   return fp_enc(a, b);
                                    @ }

  POP     {R7-R12, PC}            @ add any registers R4...R12 that you use

fp_exp:
  PUSH    {LR}                    @ add any registers R4...R12 that you use

                                    @ fp_exp(number) {
  LSL     R0, #1                    @   exp << 1;
  LSR     R0, #24                   @   exp >>> 24;
  SUB     R0, R0, #127              @   exp = exp - 127;
                                    @ }

  POP     {PC}                    @ add any registers R4...R12 that you use

fp_frac:
  PUSH    {R4, LR}                @ add any registers R4...R12 that you use

                                    @ fp_frac(number) {
  MOV     R4, R0                    @   sign = number;
  LSR     R4, #31                   @   sign >>> 31;

  LDR     R1, =0x007fffff           @   mask = 0x007fffff;
  AND     R0, R1                    @   number = number && mask;
  ORR     R0, #0x00800000           @   number = number | 0x00800000

  CMP     R4, #1                    @   if (sign == 1)
  BNE     Positive                  @   {
  NEG     R0, R0                    @     number *= -1;
Positive:                           @   }
                                    @ }

  POP     {R4, PC}                @ add any registers R4...R12 that you use

fp_enc:
  PUSH    {R4 - R6, LR}           @ add any registers R4...R12 that you use

                                    @ fp_enc(fraction, exponent) {
  MOV     R4, #0                    @   sign = 0;  

  CMP     R0, #0                    @   if (fraction < 0)
  BGE     Plus                      @   {

  MOV     R4, #0x80000000           @     sign = 1;
  NEG     R0, R0                    @     fraction *= -1;
Plus:                               @   }

  ADD     R1, R1, #127              @   exponent += 127;

  MOV     R6, R0                    @   tempFrac = fraction;
  MOV     R5, #0                    @   count = 0;
Loop:                               @   while (mostSignificantBit != 1)
  LSLS    R6, #1                    @   {
  BCS     EndLoop                   @
  ADD     R5, R5, #1                @     count++;
  B       Loop                      @
EndLoop:                            @   }

  CMP     R5, #8                    @   if (count < 8)
  BHS     NoShiftLeft               @   {
  RSB     R5, R5, #8                @     count = 8 - count;
  LSR     R0, R0, R5                @     fraction >>> count;
  ADD     R1, R1, R5                @     exponent += count;
NoShiftLeft:                        @   }

  CMP     R5, #8                    @   if (count > 8)
  BLS     NoShiftRight              @   {
  SUB     R5, R5, #8                @     count -= 8;
  LSL     R0, R0, R5                @     fraction << count;
  SUB     R1, R1, R5                @     exponent -= count;
NoShiftRight:                       @   }

  AND     R0, R0, #0xff7fffff       @   fraction = fraction && 0xff7fffff;

  LSL     R1, R1, #23               @   exponent << 23;

  ORR     R0, R0, R1                @   fraction = fraction | exponent;
  ORR     R0, R0, R4                @   return fraction | sign;
                                    @ }

  POP     {R4 - R6, PC}           @ add any registers R4...R12 that you use

.end