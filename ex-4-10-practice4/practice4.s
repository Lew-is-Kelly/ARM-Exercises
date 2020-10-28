  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (ch >= 'A' && ch <= 'Z') {
  @ 	ch = ch + 0x20;
  @ }

  CMP     R0, #'A'
  BHS     LowerCaseA
  B       End 
LowerCaseA:
  CMP     R0, #'Z'
  BLS     LowerCaseZ
  B       End
LowerCaseZ:
  ADD     R0, #0x20
  B       End

End:

  @ End of program ... check your result

End_Main:
  BX    lr

.end