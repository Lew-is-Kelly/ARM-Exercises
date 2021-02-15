  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

@
@ bubblesort exercise
@ See the Exercises discussion board on Blackboard
@

Main:

DoLoop:             @ do {
  MOV     R12, #0   @   swapped = false;
For:                @   for (i = 1; i < N; i++) {
  MOV     R10, #0   @
  LDR     R11, [R1] @
  CMP               @       if (array[i−1] > array[i]) {
                    @           tmpswap = array[i−1];
                    @           array[i−1] = array[i];
                    @           array[i] = tmpswap;
  MOV     R12, #1   @           swapped = true ;
                    @       }
EndFor:             @   }
EndLoop:            @ } while ( swapped );

End_Main:
  BX      LR

  .end