#---------------------------------
#-- Ejemplos de prueba
#---------------------------------

    .data
msg1: .string "Hi!\n"    

    .text

    #-- Imprimir una cadena
    la a0, msg1
    jal puts

    #-- Terminar
    jal exit

