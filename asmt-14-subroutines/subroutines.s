  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb
  
  .global  get9x9
  .global  set9x9
  .global  average9x9
  .global  blur9x9


@ get9x9 subroutine
@ Retrieve the element at row r, column c of a 9x9 2D array
@   of word-size values stored using row-major ordering.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@
@ Return:
@   R0: element at row r, column c
get9x9:
  PUSH    {R4, R9, LR}              @ add any registers R4...R12 that you use

                                    @ get9x9(adress, rowNumber, coloumnNumber) {

  MOV     R9, #9                    @   nine = 9;
  MUL     R4, R1, R9                @   index = rowNumber * nine;
  ADD     R4, R4, R2                @   index += columnNumber;
  LDR     R0, [R0, R4, LSL#2]       @   returnValue = array9x9[index];

                                    @ }

  POP     {R4, R9, PC}              @ add any registers R4...R12 that you use



@ set9x9 subroutine
@ Set the value of the element at row r, column c of a 9x9
@   2D array of word-size values stored using row-major
@   ordering.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@   R3: value - new word-size value for array[r][c]
@
@ Return:
@   none
set9x9:
  PUSH    {R4, R9, LR}              @ add any registers R4...R12 that you use

                                    @ set9x9(adress, rowNumber, coloumnNumber, value) {

  MOV     R9, #9                    @   nine = 9;
  MUL     R4, R1, R9                @   index = rowNumber * nine;
  ADD     R4, R4, R2                @   index += columnNumber;
  STR     R3, [R0, R4, LSL#2]       @   array9x9[index] = value;

                                    @ }

  POP     {R4, R9, PC}              @ add any registers R4...R12 that you use



@ average9x9 subroutine
@ Calculate the average value of the elements up to a distance of
@   n rows and n columns from the element at row r, column c in
@   a 9x9 2D array of word-size values. The average should include
@   the element at row r, column c.
@
@ Parameters:
@   R0: address - array start address
@   R1: r - row number
@   R2: c - column number
@   R3: n - element radius
@
@ Return:
@   R0: average value of elements
average9x9:
  PUSH    {R4-R11, LR}              @ add any registers R4...R12 that you use

                                    @ average9x9(address, rowNumber, coloumnNumber, radius) {

  SUB     R4, R1, R3                @   startRowNumber = rowNumber - radius;
  SUB     R5, R2, R3                @   startColumnNumber = rowNumber - radius;
  ADD     R1, R1, R3                @   endRowNumber = rowNumber + radius;
  ADD     R2, R2, R3                @   endColumnNumber = columnNumber + radius;

  MOV     R10, #0                   @   runningTotal = 0;
  MOV     R9, #9                    @   nine = 9;

  CMP     R2, #8                    @   if (endColoumnNumber > 8) {
  BLE     FalseIf                   @
  MOV     R2, #8                    @     endColoumnNumber = 8;
FalseIf:                            @   }

  CMP     R5, #0                    @   if (coloumnNumber < 0) {
  BGE     FalseIf2                  @   
  MOV     R5, #0                    @     coloumnNumber = 0;
FalseIf2:                           @   }

  CMP     R1, #8                    @   if (endRowNumber > 8) {
  BLE     FalseIf3                  @
  MOV     R1, #8                    @     endRowNumber = 8;
FalseIf3:                           @   }

  CMP     R4, #0                    @   if (rowNumber < 0) {
  BGE     FalseIf4                  @   
  MOV     R4, #0                    @     rowNumber = 0;
FalseIf4:                           @   }

  MOV     R11, R5                   @   tempColumnNumber = endColoumnNumber

WhileRow:                           @   while (rowNumber <= endRowNumber)
  CMP     R4, R1                    @   {
  BHI     EndWhileRow               @

  MOV     R5, R11                   @     coloumnNumber = temp;

WhileColumn:                        @     while (columnNumber <= endColumnNumber)
  CMP     R5, R2                    @     {
  BHI     EndWhileColumn            @

  MUL     R7, R4, R9                @       index = rowNumber * nine;
  ADD     R7, R7, R5                @       index += coloumnNumber;
  LDR     R8, [R0, R7, LSL#2]       @       nextNumber = array9x9[index];
  ADD     R10, R10, R8              @       runningTotal += nextNumber;
  ADD     R6, #1                    @       numberOfNumbers++;

  ADD     R5, #1                    @       rowColumn++;
  B       WhileColumn               @     }

EndWhileColumn:                     @
  ADD     R4, #1                    @     rowNumber++;
  B       WhileRow                  @   }

EndWhileRow:                        @
  UDIV    R0, R10, R6               @   return (runningTotal / numberOfNumbers);

                                    @ }

  POP     {R4-R11, PC}              @ add any registers R4...R12 that you use



@ blur9x9 subroutine
@ Create a new 9x9 2D array in memory where each element of the new
@ array is the average value the elements, up to a distance of n
@ rows and n columns, surrounding the corresponding element in an
@ original array, also stored in memory.
@
@ Parameters:
@   R0: addressA - start address of original array
@   R1: addressB - start address of new array
@   R2: n - radius
@
@ Return:
@   none
blur9x9:
  PUSH    {R4, R5, R8-R12, LR}      @ add any registers R4...R12 that you use

                                    @ blur9x9(origAddr, newAddr, rad) {

  MOV     R10, R0                   @   addressA = origAddr;
  MOV     R11, R1                   @   addressB = newAddr; 
  MOV     R12, R2                   @   radius = rad;     //moving these to be able to use other subroutines

  MOV     R9, #9                    @   nine = 9;

  MOV     R4, #0                    @   row = 0;
ForR:                               @   for(row = 0; row < nine; row++){
  CMP     R4, R9                    @
  BHS     EndForR                   @

  MOV     R5, #0                    @     coloumn = 0;
ForC:                               @     for(coloumn = 0; coloumn < nine; column++){
  CMP     R5, R9                    @     
  BHS     EndForC                   @

  MOV     R0, R10                   @       origAddr = addressA;
  MOV     R1, R4                    @       rowNumber = row;
  MOV     R2, R5                    @       coloumnNumber = coloumn;
  MOV     R3, R12                   @       rad = radius;
  BL      average9x9                @       average9x9(origAddr, rowNumber, coloumnNumber, rad);
  MOV     R8, R0                    @       average = avg;
  
  MOV     R0, R11                   @       newAddr = addressB;
  MOV     R1, R4                    @       rowNumber = row;
  MOV     R2, R5                    @       coloumnNumber = coloumn;
  MOV     R3, R8                    @       avg = average;
  BL      set9x9                    @       set9x9(newAddr, rowNumber, coloumnNumber, avg);

  ADD     R5, #1                    @       coloumn++;
  B       ForC                      @     }
  EndForC:                          @

  ADD     R4, #1                    @     row++;
  B       ForR                      @   }
  EndForR:                          @

                                    @ }

  POP     {R4, R5, R8-R12, PC}      @ add any registers R4...R12 that you use

.end