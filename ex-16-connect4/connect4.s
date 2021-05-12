  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  .global  isWinning


@ isWinning subroutine
@ Determines whether a given slot in a connect 4 board contains a disc
@   that is part of a winning run of 4 discs of the same colour.
@ Parameters:
@   R0: address of connect 4 board
@   R1: row number
@   R2: column number
@ Return:
@   R0: 1 if yellow wins, 2 if red wins, -1 if the slot is empty, 0 otherwise
isWinning:

  BX    lr
