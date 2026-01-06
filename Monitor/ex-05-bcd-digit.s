#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de digitos BCD
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Digitos BCD: \n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #-- Mensaje de inicio
    la a0, msg1
    jal puts

    #------ Impresion de todos los digitos BCD
    #-- Contador de digitos
    li s1, 0

    #-- Buffer donde imprimir
    la a0, buffer

 next_digit:
    #-- Imprimir digito actual
    mv  a1, s1
    jal sprint_bcd_digit

    #-- Imprimir separador
    li a1, '\n'
    jal sprint_char

    #-- Incrementar contador
    addi s1, s1, 1

    #-- Si el digito es menor a 16, repetir
    li t0, 16
    blt s1, t0, next_digit

    #-- Imprimir cadena resultado
    la a0, buffer
    jal puts 

    #-- Terminar
    jal exit

