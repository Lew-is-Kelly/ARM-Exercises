  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  Main

Main:

  @
  @ write your program here
  @

  @ Debugging tip:
  @ Use the watch expression ...
  @
  @   (signed int [64]) setC
  @
  @ ... to view your intersection set as your program creates it
  @ in memory.

  @ End of program ... check your result

End_Main:
  BX    lr

