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

MOV R2, #2
MOV R3, #3
MOV R4, #5
MOV R5, #7
MOV R6, #11
MOV R11, #4

MOV   R7, R1
MOV   R8, R1
MOV   R9, R1
MOV   R10, R1
MOV   R12, R1

  CMP R1, #1
  BEQ Finished
  CMP R1, #2
  BEQ EndProg
  

 End1:
 CMP      R1, R2          @ ( IF R1 >= R2)
 BLO      Endloop         @ { 
 SUB      R1, R1, R2      @ R1 = R1 - R2
 B        End1            @ }


End2:
 CMP      R7, R3          @ ( IF R7 >= R3)
 BLO      Endloop1        @ { 
 SUB      R7, R7, R3      @ R7 = R7 - R3
 B        End2            @ }

 End6:
 CMP      R11, R12          @ ( IF R7 >= R3)
 BLO      Endloop5        @ { 
 SUB      R7, R7, R3      @ R7 = R7 - R3
 B        End6            @ }

End3:
 CMP      R8, R4          @ ( IF R8 >= R4)
 BLO     Endloop2        @ { 
 SUB      R8, R8, R4      @ R8 = R8 - R4
 B        End3            @ }

 End4:
 CMP      R9, R5          @ ( IF R9 >= R5)
 BLO      Endloop3        @ { 
 SUB      R9, R9, R5      @ R9 = R9 - R5
 B        End4            @ }

 End5:
 CMP      R10, R6          @ ( IF R10 >= R6)
 BLO     Endloop4         @ { 
 SUB      R10, R10, R6     @ R10 = R10 - R6
 B        End5             @ }


Endloop:
CMP R1, #0                 @(IF R1 > 0)
BHI End2                   @  {
MOV R0, #0                 @ R0 = 0
B   Finished               @ {

Endloop1:               
CMP R7, #0                 @(IF R7 > 0)
BHI End3                   @  {
MOV R0, #0                 @ R0 = 0                   
B   Finished               @ {

Endloop2:               
CMP R8, #0                 @(IF R8 > 0)
BHI End4                   @  { 
MOV R0, #0                 @ R0 = 0 
B   Finished               @ {

Endloop3:               
CMP R9, #0                 @(IF R9 > 0)
BHI End5                   @  { 
MOV R0, #0                 @ R0 = 0 
B   Finished               @ {

Endloop4:               
CMP R10, #0                 @(IF R10 > 0)
BHI End6                   @  { 
MOV R0, #0                 @ R0 = 0 
B   Finished               @ {


Endloop5:                           
CMP R11, #0               @(IF R11 > 0)
BHI EndProg               @  {
MOV R0, #0                @ R0 = 0
EndProg:                  @}
MOV R0, #1                @ R0 = 1
Finished:                 @ }



  @ *** your solution goes here ***


  @ End of program ... check your result

End_Main:
  BX    lr

.end
