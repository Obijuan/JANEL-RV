#---------------------------------
#-- Ejemplos de prueba
#---------------------------------

    .data
msg1: .string "Hi!\n"    

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Imprimir una cadena
    la a0, msg1
    jal puts

    #-- Terminar
    jal exit

