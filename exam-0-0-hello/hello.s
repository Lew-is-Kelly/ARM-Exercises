  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

@
@ If you can read this and can build this program
@ using Visual Studio Code, then you have successfully
@ pulled the latest version of the GitLab Repository.
@
@ You will need to pull the latest version of the repository
@ again before or during the examination and you will be able
@ to do this 30 minutes before the start of the examination.
@

@
@ Let's test with a simple string copy ...
@

While:
  LDRB    R4, [R1]
  CMP     R4, #0
  BEQ     EndWhile
  STRB    R4, [R0]
  ADD     R0, R0, #1
  ADD     R1, R1, #1
  B       While
EndWhile:

  MOV     R4, #0
  STRB    R4, [R0]

End_Main:
  BX    lr


  @
  @ Debugging tips:
  @
  @ If using the View Memory window
  @   - view stringA string using address "&stringA" and size 32
  @   - view stringB using address "&stringB" and size 32
  @
  @ If using a Watch Expression (array with ASCII character codes)
  @   view stringA using expression "(char[32])stringA"
  @   view stringB using expression "(char[32])stringB"
  @
  @ If using a Watch Expression (just see the string)
  @   view stringA using expression "(char*)&stringA"
  @   view stringB using expression "(char*)&stringB"
  @

.end
