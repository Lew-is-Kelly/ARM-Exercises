  .syntax unified
  .cpu cortex-m4
  .thumb
  .global Main

@
@ This example uses the stack to overwrite a string in memory with its
@  reverse. There are far batter ways to do this without a stack so this
@  example should only be taken as an illustration of the use of a stack.
@ 
@ The strrev subroutine pushes each character from a string on to the
@  system stack from start to end. It then returns to the start address
@  of the original string and, popping the characters back of the stack,
@  overwrites the original string with its reverse, taking advantage of the
@  Last-In-First-Out behaviour of stacks.
@
@ Add a "Watch" expression "(char*)&testStr1" or "(char[100]testStr1" to
@  view the strings as they are reversed.
@

Main:

  @ Assume we have two strings that need to be reversed. The strings
  @   start in memory at the addresses in R4 and R5.

  MOV   R0, R4
  BL    strrev

  MOV   R0, R5
  BL    strrev
  
End_Main:


@
@ strrev subroutine
@ Replace (overwrite) a string in memory with its reverse
@
@ Parameters:
@   R0: address - string start address
@

strrev:
  PUSH  {R4,R6,LR}
  
  MOV   R4, R0          @ adr = address;

  MOV   R6, #0          @ push(NULL) on stack so we know later
  PUSH  {R6}            @   when we have reached the end

whPush:
  LDRB  R6, [R4], #1    @ while ((char = byte[adr++]) != NULL) {
  CMP   R6, #0          @
  BEQ   eWhPush         @
  PUSH  {R6}            @   push(char);
  B     whPush          @}
eWhPush:

  MOV   R4, R0          @ adr = address; // we can only do this because we
                        @                // haven't called any subroutines
                        @                // that might have overwritten R0

whReverse:
  POP   {R6}            @ while ((char = pop()) != NULL) {
  CMP   R6, #0          @
  BEQ   eWhReverse      @
  STRB  R6, [R4], #1    @   byte[adr++] = char;
  B     whReverse       @ }
eWhReverse:

  STRB  R6, [R1]        @ byte[adr] = char;

  POP  {R4,R6,PC}

  .end