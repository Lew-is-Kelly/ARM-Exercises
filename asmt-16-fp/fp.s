  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   fp_exp
  .global   fp_frac
  .global   fp_enc



@ fp_exp subroutine
@ Obtain the exponent of an IEEE-754 (single precision) number as a signed
@   integer (2's complement)
@
@ Parameters:
@   R0: IEEE-754 number
@
@ Return:
@   R0: exponent (signed integer using 2's complement)
fp_exp:
  PUSH    {LR}                  @ add any registers R4...R12 that you use

                                    @ fp_exp(number) {
  LSL     R0, #1                    @   exp = exp << 1;
  LSR     R0, #24                   @   exp = exp >>> 24;
  SUB     R0, R0, #127              @   exp = exp - 127;
                                    @ }

  POP     {PC}                      @ add any registers R4...R12 that you use



@ fp_frac subroutine
@ Obtain the fraction of an IEEE-754 (single precision) number.
@
@ The returned fraction will include the 'hidden' bit to the left
@   of the radix point (at bit 23). The radix point should be considered to be
@   between bits 22 and 23.
@
@ The returned fraction will be in 2's complement form, reflecting the sign
@   (sign bit) of the original IEEE-754 number.
@
@ Parameters:
@   R0: IEEE-754 number
@
@ Return:
@   R0: fraction (signed fraction, including the 'hidden' bit, in 2's
@         complement form)
fp_frac:
  PUSH    {R4, LR}                  @ add any registers R4...R12 that you use

                                    @ fp_frac(number) {
  MOV     R4, R0                    @   sign = number;
  LSR     R4, #31                   @   sign = sign >>> 31;

  LDR     R1, =0x007fffff           @   mask = 0x007fffff;
  AND     R0, R1                    @   number = number && mask;
  ORR     R0, #0x00800000           @   number = number | 0x00800000

  CMP     R4, #1                    @   if (sign == 1)
  BNE     Positive                  @   {
  NEG     R0, R0                    @     number *= -1;
Positive:                           @   }
                                    @ }

  POP     {R4, PC}                  @ add any registers R4...R12 that you use



@ fp_enc subroutine
@ Encode an IEEE-754 (single precision) floating point number given the
@   fraction (in 2's complement form) and the exponent (also in 2's
@   complement form).
@
@ Fractions that are not normalised will be normalised by the subroutine,
@   with a corresponding adjustment made to the exponent.
@
@ Parameters:
@   R0: fraction (in 2's complement form)
@   R1: exponent (in 2's complement form)
@
@ Return:
@   R0: IEEE-754 single precision floating point number
fp_enc:
  PUSH    {R4 - R6, LR}             @ add any registers R4...R12 that you use

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

  CMP     R5, #8                    @   if (fraction < 8)
  BHS     NoShiftLeft               @   {
  RSB     R5, R5, #8                @     count = 8 - count;
  LSR     R0, R0, R5                @     fraction = fraction >>> count;
  ADD     R1, R1, R5                @     exponent += count;
NoShiftLeft:                        @   }

  CMP     R5, #8                    @   if (fraction > 8)
  BLS     NoShiftRight              @   {
  SUB     R5, R5, #8                @     count -= 8;
  LSL     R0, R0, R5                @     fraction = fractions << count;
  SUB     R1, R1, R5                @     exponent -= count;
NoShiftRight:                       @   }

  AND     R0, R0, #0xff7fffff       @   fraction = fraction && 0xff7fffff;

  LSL     R1, R1, #23               @   exponent = exponent << 23;

  ORR     R0, R0, R1                @   fraction = fraction | exponent;
  ORR     R0, R0, R4                @   return fraction | sign;
                                    @ }

  POP     {R4 - R6, PC}             @ add any registers R4...R12 that you use


.end