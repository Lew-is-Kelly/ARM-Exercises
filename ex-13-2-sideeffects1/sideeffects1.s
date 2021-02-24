  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:
  BL      subroutine1     @ invoke subroutine1
   
End_Main:
  BX    lr       


@ subroutine1
subroutine1:
  ADD     R0, R1, R2      @ do something
  BL      subroutine2     @ call subroutine2
  ADD     R3, R4, R5      @ do something else
  BX      LR              @ return from subroutine1


@ subroutine2
subroutine2:

  BX      LR              @ just return from subroutine2

  .end