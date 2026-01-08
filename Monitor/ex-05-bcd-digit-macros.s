#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de digitos BCD
#----------------------------------------

    .include "stdio.h"

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Digitos BCD: \n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Mensaje de inicio
    PUTS("Digitos BCD: \n")

    #------ Impresion de todos los digitos BCD
    #-- Contador de digitos
    li s1, 0

    #-- Buffer donde imprimir
    la a0, buffer

 next_digit:
    #-- Imprimir digito actual
    SPRINT_BCD_DIGITR(s1)
    SPRINT_CHAR('\n')

    #-- Incrementar contador
    addi s1, s1, 1

    #-- Si el digito es menor a 16, repetir
    li t0, 16
    blt s1, t0, next_digit

    #-- Imprimir cadena resultado
    PUTSL(buffer)

    #-- Terminar
    jal exit

