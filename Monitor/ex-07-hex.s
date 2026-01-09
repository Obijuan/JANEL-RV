#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros hexadecimales
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    #-- Constantes para la impresion de numeros
    #-- Rellenar o NO con 0s iniciales (a la izquierda)
    .eqv RELLENO_0     1
    .eqv NO_RELLENO_0  0

    .data
buffer: .space MAX
msg1:   .string "Numeros Hexadecimales: \n"
msg2:   .string "Hex: "
msg3:   .string "0x"
msg4:   .string "<-----\n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #-- Mensaje de inicio
    la a0, msg1
    jal puts

    #------------ Imprimir Digitos hexa 0 y A
    la a0, buffer
    li a1, 0
    li a2, 1
    li a3, RELLENO_0
    jal sprint_hex
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts 

    la a0, buffer
    li a1, 0xA
    li a2, 1
    li a3, RELLENO_0
    jal sprint_hex
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    #----- Imprimir cadena + numero
    la a0, buffer
    la a1, msg2
    jal sprint

    li a1, 0x80
    li a2, 2
    li a3, RELLENO_0
    jal sprint_hex

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #------ Imprimir cadena + numero + cadena
    la a0, buffer
    la a1, msg3
    jal sprint

    li a1, 0x8080
    li a2, 4
    jal sprint_hex

    la a1, msg4
    jal sprint

    la a0, buffer
    jal puts

    #------------ Imprimir numeros de 0 al 15
    li s1, 0  #-- Contador de bits

 next:
    #-- Imprimir numero en binario
    la a0, buffer
    mv a1, s1
    li a2, 1   #-- 1 digito
    jal sprint_hex

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 16
    blt s1, t0, next

    #------------ Imprimir numeros de 0 al 7 en binario
    li s1, 0  #-- Contador de bits

 next2:
    #-- Imprimir numero en binario
    la a0, buffer
    mv a1, s1
    li a2, 2 
    jal sprint_hex

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 32
    blt s1, t0, next2

    #------------- Imprimir otros numeros hexadecimales
    la a0, buffer
    li a1, 0x5555
    li a2, 4
    jal sprint_hex
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xAAAA
    li a2, 4
    jal sprint_hex
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xCAFEBACA
    li a2, 8
    jal sprint_hex
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xFFFFFFFF
    li a2, 8
    jal sprint_hex
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts
    

    #-- Terminar
    jal exit

