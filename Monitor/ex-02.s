#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de cadenas con sprint
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Hola-"
msg2:   .string "probando..."
msg3:   .string "Vaaaamos...\n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #-- Construir una cadena en el buffer, a partir
    #-- de la concatenacion de msg1, msg2 y msg3
    mv a0, s0
    la a1, msg1
    jal sprint

    la a1, msg2
    jal sprint

    la a1, msg3
    jal sprint

    #-- Imprimir la cadena generada
    mv a0, s0
    jal puts

    #-- Terminar
    jal exit

