#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de caracteres con sprint
#----------------------------------------

    .include "stdio.h"

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX

    .text

	#-- Configurar la E/S
	jal io_init

    #------ Construir una cadena a partir de un caracter
    SPRINT_CHAR(buffer, 'A')
    PUTSL(buffer)

    #------ Cadena con Salto de linea
    SPRINT_CHAR(buffer, '\n')
    PUTSL(buffer)

    #------ Cadena a partir de 3 caracteres
    SPRINT_CHAR(buffer, 'B')
    SPRINT_CHAR('C')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------- Construir cadena + caracter + NL
    SPRINT(buffer, "Test-")
    SPRINT_CHAR('Z')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Terminar
    jal exit

