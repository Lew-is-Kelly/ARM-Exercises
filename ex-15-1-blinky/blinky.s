  .syntax unified
  .cpu cortex-m4
  .thumb
  .global Main

  @ Definitions are in definitions.s to keep blinky.s "clean"
  .include "definitions.s"


@
@ To debug this program, you need to change your "Run and Debug"
@   configuration from "Emulate current ARM .s file" to "Graphic Emulate
@   current ARM .s file".
@
@ You can do this is either of the followig two ways:
@
@   1. Switch to the Run and Debug panel ("ladybug/play" icon on the left).
@      Change the dropdown at the top of the Run and Debug panel to "Graphic
@      Emulate current ARM .s file".
@
@   2. ctrl-shift-P (cmd-shift-P on a Mac) and type "Select and Start Debugging".
@      When prompted, select "Graphic Emulate ...".
@



Main:
  PUSH    {R4-R5,LR}

  @ Enable GPIO port D by enabling its clock
  LDR     R4, =RCC_AHB1ENR
  LDR     R5, [R4]
  ORR     R5, R5, RCC_AHB1ENR_GPIODEN
  STR     R5, [R4]

  @ We'll blink LED LD3 (the orange LED)

  @ Configure LD3 for output
  @ by setting bits 27:26 of GPIOD_MODER to 01 (GPIO Port D Mode Register)
  @ (by BIClearing then ORRing)
  LDR     R4, =GPIOD_MODER
  LDR     R5, [R4]                  @ Read ...
  BIC     R5, #(0b11<<(LD3_PIN*2))  @ Modify ...
  ORR     R5, #(0b01<<(LD3_PIN*2))  @ write 01 to bits 
  STR     R5, [R4]                  @ Write 

  @ Loop forever
.LwhBlink:
  @ Invert LD3
  @ by inverting bit 13 of GPIOD_ODR (GPIO Port D Output Data Register)
  @ (by using EOR to invert bit 13, leaving other bits unchanged)
  LDR     R4, =GPIOD_ODR
  LDR     R5, [R4]                  @ Read ...
  EOR     R5, #(0b1<<(LD3_PIN))     @ Modify ...
  STR     R5, [R4]                  @ Write

  @ wait for 1s ...
  LDR     R5, =8000000    @ Assuming 16MHz clock and 2 instructions executed
                          @   in each iteration of the loop below
.Lwhwait:
  SUBS    R5, R5, #1      @ Keep looping until we count down to zero
  BNE     .Lwait  

  @ ... and repeat
  B       .LwhBlink
  
End_Main:
  POP   {R4-R5,PC}


  .end
