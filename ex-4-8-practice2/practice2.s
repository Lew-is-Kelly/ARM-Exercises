  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  MOV   R0, #0
  CMP   R1, #10       @ if (v < 10)
  BHS   If1           @ {
  MOV   R0, #1        @ 	a = 1;
  B     End           @ }
If1:
  CMP   R1, #100      @ else if (v < 100) 
  BHS   IfElse1       @ {
  MOV   R0, #10       @ 	a = 10;
  B     End           @ }
IfElse1:
  CMP   R1, #1000     @ else if (v < 1000)
  BHS   IfElse2       @ {
  MOV   R0, #100      @ 	a = 100;
  B     End           @ }
IfElse2:              @ else {
  MOV   R0, #0        @ 	a = 0;
  B     End           @ }  
End:

  @ End of program ... check your result

End_Main:
  BX    lr

.end