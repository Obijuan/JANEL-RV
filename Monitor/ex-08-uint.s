#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros decimales
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Numeros Decimales: \n"
msg2:   .string "Dec: "
msg3:   .string "----->"
msg4:   .string "<-----\n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #-- Mensaje de inicio
    la a0, msg1
    jal puts

    #------------ Imprimir numeros decimales
    la a0, buffer
    li a1, 0
    li a2, 1
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts 

    la a0, buffer
    li a1, 9
    li a2, 1
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x10
    li a2, 2
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x100
    li a2, 3
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x1000
    li a2, 4
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x10000
    li a2, 5
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x1A000
    li a2, 6
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x100000
    li a2, 7
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x1000000
    li a2, 8
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0x10000000
    li a2, 9
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xFFFFFFFF
    li a2, 10
    jal sprint_uint
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
    jal sprint_uint

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
    jal sprint_uint

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
    li a2, 2
    jal sprint_uint

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 16
    blt s1, t0, next

    #------------- Imprimir otros numeros decimales
    la a0, buffer
    li a1, 0x5555
    li a2, 10
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xAAAA
    li a2, 10
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xCAFEBACA
    li a2, 10
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xFFFFFFFF
    li a2, 10
    jal sprint_uint
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts
    

    #-- Terminar
    jal exit

