#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros unarios
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Test-"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #------ Construir una cadena a partir de un caracter
    mv a0, s0
    li a1, 'A'
    jal sprint_char

    #-- Imprimir la cadena
    mv a0, s0
    jal puts

    #------ Cadena con Salto de linea
    mv a0, s0
    li a1, '\n'
    jal sprint_char
    mv a0, s0
    jal puts

    #------ Cadena a partir de 3 caracteres
    mv a0, s0
    li a1, 'B'
    jal sprint_char
    li a1, 'C'
    jal sprint_char
    li a1, '\n'
    jal sprint_char

    #-- Imprimir la cadena
    mv a0, s0
    jal puts

    #------- Construir cadena + caracter + NL
    mv a0, s0
    la a1, msg1
    jal sprint

    li a1, 'Z'
    jal sprint_char

    li a1, '\n'
    jal sprint_char

    #-- Imprimir la cadena
    mv a0, s0
    jal puts

    #-- Terminar
    jal exit

