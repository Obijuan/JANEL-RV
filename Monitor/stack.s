#--------------------------------------------------
#-- Constantes y macros para el uso de la PILA  
#--------------------------------------------------

#-------------------------------------------------------
#-- Crear una pila de 16 bytes
#-- Espacio para 4 registros
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