  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:
  @ Initialise registers with your test vlues here
  MOV R1, #4
  MOV R2, #8

  @ Do not edit below this line
  bx    lr

.end

@ Hello Elliot!
