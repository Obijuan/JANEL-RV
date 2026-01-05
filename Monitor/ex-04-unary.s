#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros unarios
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Unary: "
msg2:   .string "->"
msg3:   .string "<-\n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #------ Impresion de numero 1
    mv a0, s0
    li a1, 1   #-- Numero a imprimir
    li a2, '1' #-- Marca a utilizar
    jal sprint_unary

    #-- Salto de linea
    li a1, '\n'
    jal sprint_char

    #-- Imprimir la cadena
    mv a0, s0
    jal puts

    #------ Impresion del numero 11
    mv a0, s0
    li a1, 2
    li a2, '1'
    jal sprint_unary
    li a1, '\n'
    jal sprint_char

    mv a0, s0
    jal puts

    #------- Impresion del numero 111
    mv a0, s0
    li a1, 3
    li a2, '1'
    jal sprint_unary
    li a1, '\n'
    jal sprint_char

    mv a0, s0
    jal puts

    #------- Barra de progreso de 4
    mv a0, s0
    li a1, 4
    li a2, '*'
    jal sprint_unary
    li a1, '\n'
    jal sprint_char

    mv a0, s0
    jal puts

    #------- Cadena + unario
    mv a0, s0
    la a1, msg1
    jal sprint
    li a1, 5
    li a2, '1'
    jal sprint_unary
    li a1, '\n'
    jal sprint_char

    mv a0, s0
    jal puts

    #------ Cadena + unario + cadena
    mv a0, s0
    la a1, msg2
    jal sprint
    li a1, 6
    li a2, '1'
    jal sprint_unary
    la a1, msg3
    jal sprint

    mv a0, s0
    jal puts

    #-- Terminar
    jal exit

