  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  MOV   R4, #0                @ for (i = 0; i < N; i++) {
fori:
  CMP   R4, R10
  BHS   endfori

  MOV   R5, #0                @   for (j = 0; j < P; j++) {
forj:
  CMP   R5, R12
  BHS   endforj

  MOV   R7, #0                @     r = 0;

  MOV   R6, #0                @     for (k = 0; k < M; k++) {
fork:
  CMP   R6, R11
  BHS   endfork

  MUL   R8, R4, R11           @       a = A[i][k];
  ADD   R8, R8, R6
  LDR   R9, [R0, R8, LSL #2]

  MUL   R8, R6, R12           @       b = B[k][j];
  ADD   R8, R8, R5
  LDR   R8, [R1, R8, LSL #2]

  MUL   R9, R9, R8            @       r = r + a * b;
  ADD   R7, R7, R9

  ADD   R6, R6, #1
  B     fork                  @     }
endfork:

  MUL   R8, R4, R12           @     C[i][j] = r;
  ADD   R8, R8, R5
  STR   R7, [R2, R8, LSL #2]

  ADD   R5, R5, #1
  B     forj                  @   }
endforj:

  ADD   R4, R4, #1
  B     fori                  @ }
endfori:


End_Main:
  BX    lr

  .end