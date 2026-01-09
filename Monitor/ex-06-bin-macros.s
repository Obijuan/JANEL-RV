#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros binarios
#----------------------------------------

    .include "stdio.h"

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    #-- Constantes para la impresion de numeros
    #-- Rellenar o NO con 0s iniciales (a la izquierda)
    .eqv RELLENO_0     1
    .eqv NO_RELLENO_0  0

    .data
buffer: .space MAX

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Mensaje de inicio
    PUTS("Numeros binarios: \n")

    #------------ Imprimir Bits 0 y 1
    SPRINT_BIN(buffer, 0, 1, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_BIN(buffer, 1, 1, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #----- Imprimir cadena + numero binario
    SPRINT(buffer, "Bin: ")
    SPRINT_BIN(0x80, 8, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------ Imprimir cadena + numero bin + cadena
    SPRINT(buffer, "Binario: ")
    SPRINT_BIN(0x8080, 16, RELLENO_0)
    SPRINT("<-----\n")
    PUTSL(buffer)

    #------------ Imprimir numeros de 0 al 3 en binario
    li s1, 0  #-- Contador de bits

 next:
    #-- Imprimir numero en binario
    SPRINT_BINR(buffer, s1, 2, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 4
    blt s1, t0, next

    #------------ Imprimir numeros de 0 al 7 en binario
    li s1, 0  #-- Contador de bits

 next2:
    #-- Imprimir numero en binario
    SPRINT_BINR(buffer, s1, 3, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 8
    blt s1, t0, next2

    #------------- Imprimir otros numeros binarios
    SPRINT_BIN(buffer, 0x5555, 16, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_BIN(buffer, 0xAAAA, 16, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_BIN(buffer, 0xCAFEBACA, 32, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_BIN(buffer, 0xFFFFFFFF, 32, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Terminar
    jal exit

