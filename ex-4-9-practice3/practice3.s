  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

Start:
  CMP   R0, #13
  BHS   While         @ while (h >= 13)
  B     End
While:                @ {
  SUB   R0, R0, #12   @ 	h = h - 12;
  B     Start         @ }
End:

  @ End of program ... check your result

End_Main:
  BX    lr

.end