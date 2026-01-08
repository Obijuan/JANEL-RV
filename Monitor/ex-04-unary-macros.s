#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros unarios
#----------------------------------------

    .include "stdio.h"

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX

    .text

	#-- Configurar la E/S
	jal io_init

    #------ Impresion de numero 1
    SPRINT_UNARY(buffer, 1, '1')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------ Impresion del numero 11
    SPRINT_UNARY(buffer, 2, '1')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------- Impresion del numero 111
    SPRINT_UNARY(buffer, 3, '1')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------- Barra de progreso de 4
    SPRINT_UNARY(buffer, 4, '*')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------- Cadena + unario
    SPRINT(buffer, "Unary: ")
    SPRINT_UNARY(5, '1')
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------ Cadena + unario + cadena
    SPRINT(buffer, "->")
    SPRINT_UNARY(6, '1')
    SPRINT("<-\n")
    PUTSL(buffer)

    #-- Terminar
    jal exit

