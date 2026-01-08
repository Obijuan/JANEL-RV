#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de cadenas con sprint
#----------------------------------------

    .include "stdio.h"

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Construir una cadena en el buffer, a partir
    #-- de la concatenacion de msg1, msg2 y msg3
    SPRINT(buffer, "Hola-")
    SPRINT("probando...")
    SPRINT("Vaaaamos...\n")

    #-- Imprimir la cadena generada
    PUTSL(buffer)

    #-- Terminar
    jal exit

