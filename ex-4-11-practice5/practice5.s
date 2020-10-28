  .syntax unified
  .cpu cortex-m4
  .thumb
  .global  Main

Main:

  @ if (ch=='a' || ch=='e' || ch=='i' || ch=='o' || ch=='u')
  @ {
  @ 	v = 1;
  @ }
  @ else {
  @ 	v = 0;
  @ }

  @ ch    R1
  @ v     R0

@   CMP     R1, #0x61
  CMP     R1, #'a'
  BEQ     IfVowel
  CMP     R1, #'e'
  BEQ     IfVowel
  CMP     R1, #'i'
  BEQ     IfVowel
  CMP     R1, #'o'
  BEQ     IfVowel
  CMP     R1, #'u'
  BNE     ElseNotVowel

IfVowel:
  MOV     R0, #1
  B       EndIfVowel
ElseNotVowel:
  MOV R0, #0
EndIfVowel:

  @ End of program ... check your result

End_Main:
  BX    lr

.end