#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de cadenas mediante puts
#----------------------------------------

    .include "stdio.h"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Imprimir una cadena
    PUTS("Ejemplo de uso de la funcion puts()\n")

    #-- Terminar
    jal exit

