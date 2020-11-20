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
  @   Open a Memory View specifying the address 0x20000000 and length at least 11
  @   You can open a Memory View with ctrl-shift-p type view memory (cmd-shift-p on a Mac)
  @

  MOV     R3, #0
  MOV     R4, #0
  MOV     R2, R1

Loop:          
  LDRB    R5, [R2]          
  CMP     R5, #0            
  BEQ     For                 
  ADD     R4, R4, #1
  ADD     R2, R2, #1        
  B       Loop      

For:
  ADD     R0, R0, R4
  MOV     R6, #0
  STRB    R6, [R0]
  SUB     R0, R0, #1

ForLoop:
  LDRB    R3, [R1]
  CMP     R3, #0
  BEQ     End
  STRB    R3, [R0]
  ADD     R1, R1, #1
  SUB     R0, R0, #1
  B       ForLoop

End:

  @ End of program ... check your result

End_Main:

  BX    lr

