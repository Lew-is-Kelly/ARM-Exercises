  .syntax unified
  .cpu cortex-m4
  .fpu softvfp
  .thumb

  .global Main


  .section  .text


  .type     Main, %function
Main:
  STMFD   SP!, {LR}

@
@ *** CSU11022 EXAM TEST ***
@
@ If you can see this you have successfully pulled the
@   latest version of the CSU11022 repository.
@
@ You will need to pull the latest version of the repository
@   again at the start of the exam.
@

End_Main:
  LDMFD   SP!, {PC}



  .section  .rodata





  .section  .data

@
@ you can declare space here for any data you wish to store in RAM
@

.end
