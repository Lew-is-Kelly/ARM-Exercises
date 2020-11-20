  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @
  @ TIP: To view memory when debugging your program you can ...
  @
  @   Add the following watch expression: (unsigned char [64]) stringB
  @
  @   OR
  @
  @   Open a Memory View specifying the address 0x20000000 and length at least 11
  @   You can open a Memory View with ctrl-shift-p type view memory (cmd-shift-p on a Mac)
  @


  MOV     R3, #0

Load:
  STRB    R3, [R0]  
  LDRB    R2, [R1]
  CMP     R2, #0
  BEQ     End
  STRB    R2, [R0]
  ADD     R1, R1, #1
  ADD     R0, R0, #1
  B       Load
  
End:

  @ End of program ... check your result

End_Main:
  BX    lr

