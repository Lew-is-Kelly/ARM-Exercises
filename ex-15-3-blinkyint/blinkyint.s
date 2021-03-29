  .syntax unified
  .cpu cortex-m4
  .thumb
  .global Main
  .global SysTick_Handler

  @ Definitions are in definitions.s to keep blinky.s "clean"
  .include "definitions.s"

  .equ    BLINK_PERIOD, 1000

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

  @ We'll blink LED LD3 (the orange LED) every 1s

  LDR     R4, =countdown
  LDR     R5, =BLINK_PERIOD
  STR     R5, [R4]  

  @ Configure LD3 for output
  @ by setting bits 27:26 of GPIOD_MODER to 01 (GPIO Port D Mode Register)
  @ (by BIClearing then ORRing)
  LDR     R4, =GPIOD_MODER
  LDR     R5, [R4]                  @ Read ...
  BIC     R5, #(0b11<<(LD3_PIN*2))  @ Modify ...
  ORR     R5, #(0b01<<(LD3_PIN*2))  @ write 01 to bits 
  STR     R5, [R4]                  @ Write 

  LDR   R4, =SYSTICK_CSR            @ Stop SysTick timer
  LDR   R5, =0                      @   by writing 0 to CSR
  STR   R5, [R4]                    @   CSR is the Control and Status Register
  
  LDR   R4, =SYSTICK_LOAD           @ Set SysTick LOAD for 1ms delay
  LDR   R5, =0x3E7F                 @ Assuming a 16MHz clock,
  STR   R5, [R4]                    @   16x10^6 / 10^3 - 1 = 15999 = 0x3E7F

  LDR   R4, =SYSTICK_VAL            @   Reset SysTick internal counter to 0
  LDR   R5, =0x1                    @     by writing any value
  STR   R5, [R4]

  LDR   R4, =SYSTICK_CSR            @   Start SysTick timer by setting CSR to 0x7
  LDR   R5, =0x7                    @     set CLKSOURCE (bit 2) to system clock (1)
  STR   R5, [R4]                    @     set TICKINT (bit 1) to 1 to enable interrupts
                                    @     set ENABLE (bit 0) to 1

Do_Nothing:
  B     Do_Nothing
  
End_Main:
  POP   {R4-R5,PC}


  .type  SysTick_Handler, %function
SysTick_Handler:

  LDR   R4, =countdown
  LDR   R5, [R4]
  CMP   R5, #0
  BEQ   .LelseFire

  SUB   R5, R5, #1
  STR   R5, [R4]

  B     .LendIfDelay

.LelseFire:

  @ Invert LD3
  @ by inverting bit 13 of GPIOD_ODR (GPIO Port D Output Data Register)
  @ (by using EOR to invert bit 13, leaving other bits unchanged)
  LDR     R4, =GPIOD_ODR
  LDR     R5, [R4]                  @ Read ...
  EOR     R5, #(0b1<<(LD3_PIN))     @ Modify ...
  STR     R5, [R4]                  @ Write

  LDR     R4, =countdown
  LDR     R5, =BLINK_PERIOD
  STR     R5, [R4]

.LendIfDelay:

  LDR     R4, =SCB_ICSR
  LDR     R5, =SCB_ICSR_PENDSTCLR
  STR     R5, [R4]

  BX    LR
  @ .size  SysTick_Handler, .-SysTick_Handler

  .section .data

countdown:
  .space  4

  .end
