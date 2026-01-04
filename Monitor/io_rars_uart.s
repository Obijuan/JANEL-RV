#----------------------------------------------------------
#-- Implementacion de la Entrada/Salida a bajo nivel
#--
#-- Esta implementacion utiliza la uart del modulo
#--  "keyboard and display MMIO" del RARs
#----------------------------------------------------------
	#-- Direccion base de la UART (consola)
	.eqv UART_BASE 0xFFFF0000
	
	#------ Offset de los registros
	#-- Transmitter Control register
	.eqv TX_CTRL 0x08
	
	#-- Transmitter DATA register
	.eqv TX_DATA 0x0C
	
	#-- Bit Ready
	.eqv TX_READY 0x01  

#-----------------------------------------------
#-- io_init
#--
#-- Configuracion del modulo de bajo nivel
#-- La direccion de la uart se almacena en el 
#-- registro gp
#-----------------------------------------------
.global io_init
io_init:
	li gp, UART_BASE
	ret

#----------------------------------------
#-- putchar(car)
#--
#-- Imprimir un caracter en la consola
#----------------------------------------
.global putchar
putchar:

	#-- Esperar a que se active el bit de ready
wait_tx_ready:
	#-- Leer el bit de ready del transmisor
	lw t0, TX_CTRL(gp)
	
	#-- Aislar el bit de ready
	andi t0, t0, TX_READY
	
	#-- Si es cero, repetir
	beq t0, zero, wait_tx_ready
	
	#-- Transmitir el carácter!
	sw a0, TX_DATA(gp)
	
	ret
	

#------------------------------------------
#-- exit
#--
#-- Terminar
#------------------------------------------
.global exit
exit:

	#-- La funcion de exit para un sistema empotrado deberia
	#-- ser un bucle infinito
#inf:	j _inf

	#-- Pero para las pruebas llamamos directamente
	#-- al sistema operativo (a pelo, para no tener
	#-- que incluir el fichero rars_so.h
	nop
	nop
	nop
	nop
	nop
	nop
	nop
    li a7, 10
   	ecall
