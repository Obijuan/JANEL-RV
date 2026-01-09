#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros hexadecimales
#----------------------------------------

    .include "stdio.h"

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    #-- Constantes para la impresion de numeros
    #-- Rellenar o NO con 0s iniciales (a la izquierda)
    .eqv RELLENO_0     1
    .eqv NO_RELLENO_0  0
    .eqv SIZE_4   1
    .eqv SIZE_8   2
    .eqv SIZE_16  4
    .eqv SIZE_32  8


    .data
buffer: .space MAX

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Mensaje de inicio
    PUTS("Numeros Hexadecimales:\n")

    #------------ Imprimir Digitos hexa 0 y A
    SPRINT_HEX(buffer, 0, SIZE_4, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_HEX(buffer, 0xA, SIZE_4, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #----- Imprimir cadena + numero
    SPRINT(buffer, "Hex: ")
    SPRINT_HEX(0x80, SIZE_8, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #------ Imprimir cadena + numero + cadena
    SPRINT(buffer, "0X")
    SPRINT_HEX(0x8080, SIZE_16, RELLENO_0)
    SPRINT("<-----\n")
    PUTSL(buffer)

    #------------ Imprimir numeros de 0 al 15
    li s1, 0  #-- Contador de bits

 next:
    #-- Imprimir numero
    SPRINT_HEXR(buffer, s1, SIZE_4, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 16
    blt s1, t0, next

    #------------ Imprimir numeros de 0 al 7 en binario
    li s1, 0  #-- Contador de bits

 next2:
    #-- Imprimir numero
    SPRINT_HEXR(buffer, s1, SIZE_8, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 32
    blt s1, t0, next2

    #------------- Imprimir otros numeros hexadecimales
    SPRINT_HEX(buffer, 0x5555, SIZE_16, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_HEX(buffer, 0xAAAA, SIZE_16, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_HEX(buffer, 0xCAFEBACA, SIZE_32, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_HEX(buffer, 0xFFFFFFFF, SIZE_32, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Terminar
    jal exit

