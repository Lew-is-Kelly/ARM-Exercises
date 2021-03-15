  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global  quicksort

@ quicksort subroutine
@ Sort an array of words using Hoare's quicksort algorithm
@
@ Parameters:
@   R0: Array start address
@   R1: lo index of portion of array to sort
@   R2: hi index of portion of array to sort
@
@ Return:
@   none
quicksort:
  PUSH    {LR}                      @ add any registers R4...R12 that you use

  @ if (lo < hi) {
  @   p = partition(array, lo, hi);
  @   quicksort(array, lo, p - 1);
  @   quicksort(array, p + 1, hi);
  @ }

  @
  @ your implementation goes here
  @

  POP     {PC}                      @ add any registers R4...R12 that you use


@ partition subroutine
@ Partition an array of words into two parts such that all elements before some
@   element in the array this is chosen as a 'pivot' are less than the pivot
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
  PUSH    {LR}                      @ add any registers R4...R12 that you use

  @ pivot = array[hi];
  @ i = lo;
  @ for (j = lo; j <= hi; j++) {
  @   if (array[j] < pivot) {
  @     swap (array, i, j);
  @     i = i + 1;
  @   }
  @ }
  @ swap(array, i, hi);
  @ return i;

  @
  @ your implementation goes here
  @

  POP     {PC}                      @ add any registers R4...R12 that you use



@ swap subroutine
@ Swap the elements at two specified indices in an array of words.
@
@ Parameters:
@   R0: array start address
@   R1: a - index of first element to be swapped
@   R2: b - index of second element to be swapped
@
@ Return:
@   none
swap:
  PUSH    {LR}

  @
  @ your implementation goes here
  @

  POP     {PC}


.end