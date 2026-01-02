#--------------------------------------------------
#-- Constantes y macros para el uso de la PILA  
#--------------------------------------------------

#-------------------------------------------------------
#-- Crear una pila de 16 bytes
#-- Espacio para 4 registros (offsets 0 - 8)
#-- La direccion de retorno se guarda en el offset 12
#-------------------------------------------------------
.macro STACK16
  addi sp, sp, -16
  sw ra, 12(sp)
.end_macro

#----------------------------------------
#-- Liberar la pila de 16 bytes
#-- Recuperar la direccion de retorno
#-- RETORNAR DE LA FUNCION!
#----------------------------------------
.macro UNSTACK16
  lw ra, 12(sp)
  addi sp, sp, 16
  ret
.end_macro

#-------------------------------------------------------
#-- Crear una pila de 32 bytes
#-- Espacio para 8 registros (offsets 0 - 24)
#-- La direccion de retorno se guarda en el offset 28
#-------------------------------------------------------
.macro STACK32
  addi sp, sp, -32
  sw ra, 28(sp)
.end_macro

#----------------------------------------
#-- Liberar la pila de 32 bytes
#-- Recuperar la direccion de retorno
#-- RETORNAR DE LA FUNCION!
#----------------------------------------
.macro UNSTACK32
  lw ra, 28(sp)
  addi sp, sp, 32
  ret
.end_macro

#-----------------------------------
#-- Meter en la pila SOLO 1 registro
#--   Se gudarda en offset 0
#-----------------------------------
.macro PUSH1(%reg)
  sw %reg, 0(sp)
.end_macro

#------------------------------------------
#-- Recuperar de la pila SOLO 1 registro
#--   Se recupera del offset 0
#------------------------------------------
.macro POP1(%reg)
  lw %reg, 0(sp)
.end_macro

