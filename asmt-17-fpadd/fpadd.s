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
  PUSH    {LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

  POP     {PC}                      @ add any registers R4...R12 that you use


@
@ Copy your fp_frac, fp_exp, fp_enc subroutines from Assignment #6 here
@   and call them from fp_add above.
@


.end