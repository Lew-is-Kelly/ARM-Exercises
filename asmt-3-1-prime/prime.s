  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @
  @ Write an ARM Assembly Language Program that will determine
  @   whether the unsigned number in R1 is a prime number
  @
  @ Output:
  @   R0: 1 if the number in R1 is prime
  @       0 if the number in R1 is not prime
  @

  MOV     R3, #0        @ r3=0
  MOV     R4, #0        @ r4=0
  MOV     R2, #2        @ r2=2
                        @
  CMP     R1, #2        @ if (r1>2)
  BLO     NotPrime      @ {
  CMP     R1, #2        @   if(r1==2)
  BEQ     Prime         @   { r0=1 }
  UDIV    R4, R1, R2    @   r4=r1/r2
                        @
Division:               @   while (r2<=r4)
  UDIV    R3, R1, R2    @   { r3=r1/r2
  MUL     R3, R3, R2    @     r3=r3*r2
  SUB     R3, R3, R1    @     r3=r3-r1
  CMP     R3, #0        @     if (r3==0)
  BEQ     NotPrime      @     {
  CMP     R2, R4        @       r0=0
  BHI     Prime         @     }
  ADD     R2, R2, #1    @     if (r2>r4)
  B       Division      @     {
                        @       r0=1
Prime:                  @     }
  MOV     R0, #1        @     r2=r2+1
  B       End           @   }
                        @
NotPrime:               @
  MOV     R0, #0        @
End:


  @ End of program ... check your result

End_Main:
  BX    lr

.end
