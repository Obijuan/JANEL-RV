#----------------------------------------------------------
#-- Implementacion de la Entrada/Salida a bajo nivel
#--
#-- Esta implementacion utiliza los servicios del sistema
#-- operativo del RARs
#----------------------------------------------------------
#-- Funciones de BAJO nivel a implementar en cada plataforma:
#--
#-- * io_init(): Inicializacion del modulo de I/O
#-- * exit(): Funcion para terminar
#-- * putchar(car): Imprimir un caracter en la consola
#--
#------------------------------------------------------------

#-- Servicios del sistema operativo del RARs
	.include "rars_so.h"

#--------------------------------------
#-- io_init()
#--
#-- Configuracion de la entrada salida
#--
#-- Como hay un sistema operativo debajo,
#-- no hay que configurar nada
#----------------------------------------
.global io_init
io_init:
    ret

#----------------------------------------
#-- putchar(car)
#--
#-- Imprimir un caracter en la consola
#----------------------------------------
.global putchar
putchar:

    #-- Llamar al sistema operativo para
    #-- imprimir el caracter
    PRINT_CHAR

    ret

#------------------------------------------
#-- exit
#--
#-- Terminar
#------------------------------------------
    .data
msg_exit: .string "io_rars_os: EXIT\n\n"

    .text

.global exit
exit:
    #-- Imprimir mensaje de fin
    la a0, msg_exit
    jal puts

    #-- Terminar
    EXIT
