  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ Write an ARM Assembly Language Program that will compute
  @   the GCD (greatest common divisor) of two numbers in R2 and R3.
  
  @ while (a != b)
  @ {
  @   if (a > b)
  @   {
  @     a = a - b;
  @   }
  @   else
  @   {
  @     b = b - a;
  @   }
  @ }
  @ result = a;

  MOV     R0, #0
  MOV     R4, #0

WhileLoop:                  @ while
  CMP     R2, R3            @ (a != b)
  BEQ     End               @ {
  CMP     R2, R3            @ if (a > b)
  BHI     If                @ {
  B       Else              @

If:                         @
  SUB     R2, R2, R3        @ a = a - b
  B       WhileLoop         @ }
                            
Else:                       @
  SUB     R3, R3, R2        @ b = b - a
  B       WhileLoop         @ }

End:                        @
  MOV     R0, R2            @ result = a

  @ End of program ... check your result

End_Main:
  BX    lr

.end
