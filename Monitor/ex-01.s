#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de cadenas mediante puts
#----------------------------------------

    .data
msg1: .string "Ejemplo de uso de la funcion puts()\n"    

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Imprimir una cadena
    la a0, msg1
    jal puts

    #-- Terminar
    jal exit

