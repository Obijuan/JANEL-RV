#----------------------------------------------------------
#-- Implementacion de la Entrada/Salida a bajo nivel
#--
#-- Esta implementacion utiliza los servicios del sistema
#-- operativo del RARs
#----------------------------------------------------------

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
.global exit
exit:
    EXIT
