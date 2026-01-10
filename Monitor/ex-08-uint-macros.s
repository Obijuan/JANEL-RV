#----------------------------------------
#-- Ejemplos de prueba
#-- Impresion de numeros decimales
#----------------------------------------

    #-- Tamaño maximo del buffer para imprimir (en bytes)
    .eqv MAX 255

    #-- Constantes para la impresion de numeros
    #-- Rellenar o NO con 0s iniciales (a la izquierda)
    .eqv RELLENO_0     1
    .eqv NO_RELLENO_0  0

    .data
buffer: .space MAX
msg1:   .string "Numeros Decimales: \n"
msg2:   .string "Dec: "
msg3:   .string "----->"
msg4:   .string "<-----\n"

    .text

	#-- Configurar la E/S
	jal io_init

    #-- Mensaje de inicio
    PUTS("Numeros Decimales:\n")

    #------------ Imprimir numeros decimales
    SPRINT_UINT(buffer, 0, 2, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 9, 1, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x10, 2, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x100, 3, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x1000, 4, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x10000, 5, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x1A000, 6, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x100000, 7, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x1000000, 8, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x10000000, 9, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0xFFFFFFFF, 10, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #----- Imprimir cadena + numero
    SPRINT(buffer, "Dec: ")
    SPRINT_UINT(0x80, 2, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)
    
    #------ Imprimir cadena + numero + cadena
    SPRINT(buffer, "----->")
    SPRINT_UINT(0x8000, 4, NO_RELLENO_0)
    SPRINT("<-----\n")
    PUTSL(buffer)

    #------------ Imprimir numeros de 0 al 15
    li s1, 0  #-- Contador de bits

 next:
    #-- Imprimir numero
    SPRINT_UINTR(buffer, s1, 2, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Incrementar numero
    addi s1, s1, 1

    #-- Comprobar finalizacion
    li t0, 16
    blt s1, t0, next

    #------------- Imprimir otros numeros decimales
    SPRINT_UINT(buffer, 0x5555, 10, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0xAAAA, 10, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0xCAFEBACA, 10, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0xFFFFFFFF, 10, NO_RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #--------- Imprimir con 0s iniciales
    SPRINT_UINT(buffer, 0, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 9, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x10, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x100, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x1000, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x10000, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x1A000, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x100000, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x1000000, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0x10000000, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0xFFFFFFFF, 10, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0, 2, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0, 3, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    SPRINT_UINT(buffer, 0, 3, RELLENO_0)
    SPRINT_CHAR('\n')
    PUTSL(buffer)

    #-- Terminar
    jal exit

