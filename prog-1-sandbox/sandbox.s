  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

 
@   CMP   R1, #'0'          @ if (ch >= '0' && ch <= '9')
@   BLO   ElseIfAF          @ {
@   CMP   R1, #'9'          @
@   BHI   ElseIfAF          @

@   SUB   R0, R1, #'0'      @   value = value - '0'

@   B     EndIfHex          @ }

@   ElseIfAF:
@   CMP   R1, #'A'          @ else if (ch >= 'A' && ch <= 'F')
@   BLO   ElseNotHex        @ {
@   CMP   R1, #'F'          @
@   BHI   ElseNotHex        @

@   SUB   R0, R1, #('A'-10) @ value = ch - 'A' + 10

@   B     EndIfHex          @ }

@ ElseNotHex:

@   MOV   R0, #0xFFFFFFFF   
  
@ EndIfHex:

/*
 for (i = 0; i< 10; i = i + 1)
 {
   y = y + (i * i)
 }
*/

@   MOV   R0, #0
@ Fori:
@   CMP   R0, #10
@   BHS   EndFori

@   MUL   R2, R0, R0
@   ADD   R1, R1, R2

@   ADD   R0, R0, #1
@   B     Fori
@ EndFori:


/*
 while (a+b < 100)
 {
     a = a + 1
     b = b + 10
 }
*/

@ While:
@   ADD   R7, R4, R5
@   CMP   R7, #100
@   BHS   EndWhile

@   ADD   R4, R4, #1
@   ADD   R5, R5, #10

@   B     While
@ EndWhile:

/*
h = 0 ;
whil e ( h < 2 4 )
{
m = 0 ;
whil e (m < 6 0 )
{
t = ( h ∗ 6 0 ) + m;
m = m + 1
}
h = h + 1 ;
}
*/

@   MOV   R3, #0
@   LDR   R6, =60
@ WhileH:
@   CMP   R3, #24
@   BHS   EndWhileH

@   MOV   R4, #0
@ WhileM:
@   CMP   R4, #60
@   BHS   EndWhileM

@   MUL   R5, R3, R6
@   ADD   R5, R5, R4

@   ADD   R4, R4, #1
@   B WhileM
@ EndWhileM:

@   ADD  R3, R3, #1
@   B    WhileH     
@ EndWhileH:



@   CMP     R1, #12
@   BEQ     L1
@   CMP     R1, #15
@   BEQ     L1
@   CMP     R1, #60
@   BNE     L2
@ L1:
@   MUL     R0, R0, R1
@ L2:







End_Main:
  BX    lr

  .end