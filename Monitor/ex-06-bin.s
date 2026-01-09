#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros binarios
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    .data
buffer: .space MAX
msg1:   .string "Numeros binarios: \n"
msg2:   .string "Bin: "
msg3:   .string "Binario: "
msg4:   .string "<-----\n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Puntero al buffer
    la s0, buffer

    #-- Mensaje de inicio
    la a0, msg1
    jal puts

    #------------ Imprimir Bits 0 y 1
    la a0, buffer
    li a1, 0   #-- Bit 0
    li a2, 1
    li a3, 1
    jal sprint_bin
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts 

    la a0, buffer
    li a1, 1   #-- Bit 1
    li a2, 1
    li a3, 1
    jal sprint_bin
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    #----- Imprimir cadena + numero binario
    la a0, buffer
    la a1, msg2
    jal sprint

    li a1, 0x80
    li a2, 8
    li a3, 1
    jal sprint_bin

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #------ Imprimir cadena + numero bin + cadena
    la a0, buffer
    la a1, msg3
    jal sprint

    li a1, 0x8080
    li a2, 16
    li a3, 1
    jal sprint_bin

    la a1, msg4
    jal sprint

    la a0, buffer
    jal puts

    #------------ Imprimir numeros de 0 al 3 en binario
    li s1, 0  #-- Contador de bits

 next:
    #-- Imprimir numero en binario
    la a0, buffer
    mv a1, s1
    li a2, 2   #-- 2 bits
    jal sprint_bin

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 4
    blt s1, t0, next

    #------------ Imprimir numeros de 0 al 7 en binario
    li s1, 0  #-- Contador de bits

 next2:
    #-- Imprimir numero en binario
    la a0, buffer
    mv a1, s1
    li a2, 3   #-- 3 bits
    li a3, 1
    jal sprint_bin

    li a1, '\n'
    jal sprint_char

    la a0, buffer
    jal puts

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 8
    blt s1, t0, next2

    #------------- Imprimir otros numeros binarios
    la a0, buffer
    li a1, 0x5555
    li a2, 16
    li a3, 1
    jal sprint_bin
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xAAAA
    li a2, 16
    li a3, 1
    jal sprint_bin
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xCAFEBACA
    li a2, 32
    li a3, 1
    jal sprint_bin
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts

    la a0, buffer
    li a1, 0xFFFFFFFF
    li a2, 32
    li a3, 1
    jal sprint_bin
    li a1, '\n'
    jal sprint_char
    la a0, buffer
    jal puts
    

    #-- Terminar
    jal exit

