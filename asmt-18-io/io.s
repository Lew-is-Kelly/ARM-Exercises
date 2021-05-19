  .syntax unified
  .cpu cortex-m4
  .thumb
  .global Main
  .global SysTick_Handler
  .global EXTI0_IRQHandler

@ Uncomment if you are providing a EXTI0_IRQHandler subroutine
@  .global EXTI0_IRQHandler

  @ Definitions are in definitions.s to keep this file "clean"
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

  @ Configure LD3 for output
  @ by setting bits 27:26 of GPIOD_MODER to 01 (GPIO Port D Mode Register)
  @ (by BIClearing then ORRing)
  LDR     R4, =GPIOD_MODER
  LDR     R5, [R4]                  @ Read ...
  BIC     R5, #0b11<<(LD3_PIN*2)    @ Modify ...
  ORR     R5, #0b01<<(LD3_PIN*2)    @ write 01 to bits 
  ORR     R5, #0b01<<(LD4_PIN*2)    @ write 01 to bits 
  ORR     R5, #0b01<<(LD5_PIN*2)    @ write 01 to bits 
  ORR     R5, #0b01<<(LD6_PIN*2)    @ write 01 to bits 
  STR     R5, [R4]                  @ Write 


  @ We'll blink LED LD3 (the orange LED) every 1s
  @ Initialise the first countdown to 1000 (1000ms)

  LDR     R4, =countdown            @
  LDR     R5, =BLINK_PERIOD         @
  STR     R5, [R4]                  @


  @ Configure SysTick Timer to generate an interrupt every 1ms

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

  @ Enable (unmask) interrupts on external interrupt Line0
  LDR     R4, =EXTI_IMR
  LDR     R5, [R4]
  ORR     R5, R5, #1
  STR     R5, [R4]

  @ Set falling edge detection on Line0
  LDR     R4, =EXTI_FTSR
  LDR     R5, [R4]
  ORR     R5, R5, #1
  STR     R5, [R4]

  @ Enable NVIC interrupt #6 (external interrupt Line0)
  LDR     R4, =NVIC_ISER
  MOV     R5, #(1<<6)
  STR     R5, [R4]

  @ Nothing else to do in Main
  @ Idle loop forever (welcome to interrupts!)
Idle_Loop:
  B     Idle_Loop
  
End_Main:
  POP   {R4-R5,PC}


@
@ SysTick interrupt handler
@
  .type  SysTick_Handler, %function
SysTick_Handler:

  PUSH  {R4-R9, LR}

  LDR   R4, =countdown              @ if (countdown != 0) {
  LDR   R5, [R4]                    @
  CMP   R5, #0                      @
  BEQ   .LelseFire                  @

  SUB   R5, R5, #1                  @   countdown = countdown - 1;
  STR   R5, [R4]                    @

  B     .LendIfDelay                @ }

.LelseFire:                         @ else {

  LDR     R4, =runLights            @
  LDR     R5, [R4]                  @
  CMP     R5, #1                    @  boolean that skips the inversion of lights if the button was pressed.
  BNE     .LendIfDelay              @

  LDR     R4, =GPIOD_ODR            @
  LDR     R5, [R4]                  @

  LDR     R6, =lightCount           @ uses a light counter that counts what light was the last to be inverted
  LDR     R7, [R6]                  @ has an extra state that signifies if no light has been inverted before it

  CMP     R7, #4                    @ 
  BNE     NotFirstFire              @ 
  EOR     R5, #0b1<<(LD4_PIN)       @
  MOV     R7, #0                    @
  B       Over                      @
NotFirstFire:                       @

  CMP     R7, #0                    @
  BNE     NotGreen                  @
  EOR     R5, #0b1<<(LD4_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD4_PIN);
  EOR     R5, #0b1<<(LD3_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD6_PIN);
  MOV     R7, #1                    @
  B       Over                      @
NotGreen:                           @

  CMP     R7, #1                    @
  BNE     NotOrange                 @
  EOR     R5, #0b1<<(LD3_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD3_PIN);
  EOR     R5, #0b1<<(LD5_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD4_PIN);
  MOV     R7, #2                    @
  B       Over                      @
NotOrange:                          @

  CMP     R7, #2                    @
  BNE     NotRed                    @
  EOR     R5, #0b1<<(LD5_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD5_PIN);
  EOR     R5, #0b1<<(LD6_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD3_PIN);
  MOV     R7, #3                    @
  B       Over                      @
NotRed:                             @

  CMP     R7, #3                    @
  BNE     NotBlue                   @
  EOR     R5, #0b1<<(LD6_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD6_PIN);
  EOR     R5, #0b1<<(LD4_PIN)       @   GPIOD_ODR = GPIOD_ODR ^ (1<<LD5_PIN);
  MOV     R7, #0                    @
NotBlue:                            @

Over:                               @

  STR     R7, [R6]                  @
  STR     R5, [R4]                  @

  LDR     R4, =countdown            @   countdown = BLINK_PERIOD;
  LDR     R5, =BLINK_PERIOD         @
  STR     R5, [R4]                  @

.LendIfDelay:                       @ }

  LDR     R4, =SCB_ICSR             @ Clear (acknowledge) the interrupt
  LDR     R5, =SCB_ICSR_PENDSTCLR   @
  STR     R5, [R4]                  @

  @ Return from interrupt handler

  @
  @ External interrupt line 0 interrupt handler
  @
  POP  {R4-R9, PC}

    .type  EXTI0_IRQHandler, %function
EXTI0_IRQHandler:

  PUSH  {R4-R9,LR}

  LDR     R6, =runLights            @
  LDR     R7, [R6]                  @
  LDR     R8, =lightCount           @ 
  LDR     R9, [R8]                  @

  LDR     R4, =GPIOD_ODR            @
  LDR     R5, [R4]                  @  turns all the lights off when the button is pushed
  BIC     R5, #0b1111<<(LD4_PIN)    @
  STR     R5, [R4]                  @

  CMP     R7, #1                    @   if statement that checks if the program was running before the button was pushed
  BNE     .LnotRunning              @   using boolean
  
  CMP     R9, #2                    @
  BNE     .LnotRed                  @   checks the light count to see if it is red then turns all the lights on
  ORR     R5, #0b1111<<(LD4_PIN)    @     

.LnotRed:                           @
  STR     R5, [R4]                  @
  MOV     R7, #0                    @
  STR     R7, [R6]                  @   changes the boolean
  B       .LwasRunning              @

.LnotRunning:                       @
  MOV     R7, #1                    @   changes the boolean
  STR     R7, [R6]                  @
  MOV     R7, #4                    @   sets the light counter to its starting state.
  LDR     R6, =lightCount           @
  STR     R7, [R6]                  @

.LwasRunning:                       @

  LDR     R4, =EXTI_PR              @ Clear (acknowledge) the interrupt
  MOV     R5, #(1<<0)               @
  STR     R5, [R4]                  @

  @ Return from interrupt handler
  POP  {R4-R9,PC}


  .section .data

countdown:
  .space  4

lightCount:                         @ count to see what lights should be inverted. Used to check if the player has won
  .space  4

runLights:                          @ boolean that lets the program run
  .space  4

  .end
