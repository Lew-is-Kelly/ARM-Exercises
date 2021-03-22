  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global   quicksort
  .global   partition
  .global   swap

@ quicksort subroutine
@ Sort an array of words using Hoare's quicksort algorithm
@ https://en.wikipedia.org/wiki/Quicksort 
@
@ Parameters:
@   R0: Array start address
@   R1: lo index of portion of array to sort
@   R2: hi index of portion of array to sort
@
@ Return:
@   none
quicksort:
  PUSH    {R4-R7, LR}                  @ add any registers R4...R12 that you use

                                    @ quicksort(array, lo, hi) {
  CMP     R1, R2                    @   if (lo < hi) { // !!! You must use signed comparison (e.g. BGE) here !!!
  BGE     LoGreaterEqualHi          @

  MOV     R5, R0                    @     tempAddress = arrayAddress;
  MOV     R6, R1                    @     tempLo = lo;
  MOV     R7, R2                    @     tempHi = hi;

  BL      partition                 @     partition(array, lo, hi);
  MOV     R4, R0                    @     pivot = partition;
  MOV     R0, R5                    @     arrayAddress = tempAddress;
  MOV     R1, R6                    @     lo = tempLo;
  MOV     R2, R7                    @     hi = tempHi;

  SUB     R4, R4, #1                @     pivot--;
  MOV     R2, R4                    @     hi = pivot
  BL      quicksort                 @     quicksort(array, lo, hi);
  MOV     R0, R5                    @     arrayAddress = tempAddress;
  MOV     R1, R6                    @     lo = tempLo;
  MOV     R2, R7                    @     hi = tempHi;

  ADD     R4, R4, #2                @     pivot = pivot + 2;
  MOV     R1, R4                    @     lo = pivot;
  BL      quicksort                 @     quicksort(array, lo, hi);

LoGreaterEqualHi:                   @   }
                                    @ }

  POP     {R4-R7, PC}                  @ add any registers R4...R12 that you use


@ partition subroutine
@ Partition an array of words into two parts such that all elements before some
@   element in the array that is chosen as a 'pivot' are less than the pivot
@   and all elements after the pivot are greater than the pivot.
@
@ Based on Lomuto's partition scheme (https://en.wikipedia.org/wiki/Quicksort)
@
@ Parameters:
@   R0: array start address
@   R1: lo index of partition to sort
@   R2: hi index of partition to sort
@
@ Return:
@   R0: pivot - the index of the chosen pivot value
partition:
  PUSH    {R4-R8, LR}               @ add any registers R4...R12 that you use

                                    @ partition(array, lo, hi) {
  LDR     R4, [R0, R2, LSL#2]       @   pivot = array[hi];
  MOV     R5, R1                    @   i = lo;
  
  MOV     R6, R1                    @   j = lo;
For:
  CMP     R6, R2                    @   for (j = lo; j <= hi; j++) {
  BHI     ForOver                   @
  
  LDR     R7, [R0, R6, LSL#2]       @     element = array[j]
  CMP     R7, R4                    @     if (element < pivot) {
  BHS     ElemGreaterEqualPiv       @

  MOV     R1, R5                    @       a = i;
  MOV     R8, R2                    @       tempHi = hi;
  MOV     R2, R6                    @       b = j;
  BL      swap                      @       swap(array, a, b);
  MOV     R2, R8                    @       hi = tempHi;

  ADD     R5, R5, #1                @       i++;

ElemGreaterEqualPiv:                @     }

  ADD     R6, R6, #1                @     j++;
  B       For                       @
ForOver:                            @   }

  MOV     R1, R5                    @   a = i;
  BL      swap                      @   swap(array, a, hi);
  MOV     R0, R5                    @   return i;
                                    @ }

  POP     {R4-R8, PC}               @ add any registers R4...R12 that you use



@ swap subroutine
@ Swap the elements at two specified indices in an array of words.
@
@ Parameters:
@   R0: array - start address of an array of words
@   R1: a - index of first element to be swapped
@   R2: b - index of second element to be swapped
@
@ Return:
@   none
swap:
  PUSH    {R4, R5, LR}

                                    @ swap(array, a, b) {
  LDR     R4, [R0, R1, LSL#2]       @   elementOne = array[a];
  LDR     R5, [R0, R2, LSL#2]       @   elementTwo = array[b];

  STR     R4, [R0, R2, LSL#2]       @   array[b] = elementOne;
  STR     R5, [R0, R1, LSL#2]       @   array[a] = elementTwo;
                                    @ }

  POP     {R4, R5, PC}


.end