
#------------------------------------------------------------------------------
#-- stdio.s: Rutinas para salida standar
#------------------------------------------------------------------------------
#-- Mascaras para BITs
	.eqv BIT0 0x01 

#-- Macros de acceso a la pila
.include "stack.h"

	.data
 buffer_bcd: .space 32

	.text


.global sprint_uint32
sprint_uint32:
#----------------------------------------------------------------
#-- SPRINT_UINT32(dst, n)
#--
#-- Imprimir un numero decimal sin signo, de 32 bits (10 digitos)
#--
#-- ENTRADA:
#--   - a0 (dst): Dirección de la cadena destino
#--   - a1 (n): Numero de 32 bits a imprimir
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#------------------------------------------------------------------
#-- Registro de calculo para hacer los desplazamientos:
#
#  -Parte alta (s3)
#    31                                              8 | 7    4 | 3       0
#  +------------------------------------------------------------------------+
#  |                                                   |   Dig9 |   Dig8    |
#  |                                                   | 0 0 0 0|  0 0 0 0  |
#  +------------------------------------------------------------------------+
#
#  -Parte media (s2):
#   31   28| 27   24|23    20| 19  16 | 15   12 | 11    8| 7      4| 3     0
#  +------------------------------------------------------------------------+
#  |  Dig7 |  Dig6  |  Dig5  | Dig 4  |  Dig3   | Dig2   |  Dig1   |  Dig0  |
#  |0 0 0 0| 0 0 0 0| 0 0 0 0| 0 0 0 0| 0 0 0 0 | 0 0 0 0| 0 0 0 0 | 0 0 0 0|
#  +------------------------------------------------------------------------+
#
#  -Parte baja (s1):
#   31                                                                    0
#  +------------------------------------------------------------------------+
#  |      n                                                                 |
#  |  d31 - d0                                                              |
#  +------------------------------------------------------------------------+
	.data

	#-- Buffer donde guardar los digitos bcd en memoria
	#-- para luego "imprimirlos"
 sprint_uint32_buff:  .space 10

	.text
	STACK32
	STACK32_PUSH5(s0, s1, s2, s3, s4)

	#-- Guardar direccion de la cadena destino
	mv s0, a0
	
	#-- Inicializar registro BCD
	mv s1, a1  #-- Parte baja
	li s2, 0
	li s3, 0   #-- Parte alta

	#------- Estado inicial. Desplazar registro BCD 3 bits
	#------- a la izquierda  s2 <- s1
	#-- 1. Obtener los 3 bits de mayor peso de s1
	li t0, 0xE0000000  #-- Cambiar a lui
	and t0, s1, t0

	#-- 2. Llevar estos 3 bits a s2 (a la pos de menor peso)
	srli s2, t0, 29

	#-- 3. Desplazar s1 3 bits a la izquierda
	slli s1, s1, 3

	#-- Contador de desplazamientos a realizar para finalizar el algoritmo
	#-- Ya hemos hecho 3, quedan 32-3 = 29
	li s4, 29


 sprint_uint32_next:

	#-------------- Actualizar la parte alta del registro bcd
	#-------------- Este registro almacena 2 digitos
	mv a0, s3  #-- Registro bcd alto
	li a1, 2   #-- Actualizar 2 digitos
	li a2, 0   #-- Offset: 0
	jal uint_update_bcd_reg
	mv s3, a0

	#-------------- Actualizar la parte baja del registro bcd
	#-------------- Este registro almacena 8 digitos
	mv a0, s2  #-- Registro bcd alto
	li a1, 8   #-- Actualizar 8 digitos
	li a2, 0   #-- Offset 0
	jal uint_update_bcd_reg
	mv s2, a0


	#------------ Desplazamiento a la izquierda del registro s3-s2-s1
	#-- 1. Desplazar s3 a la izquierda
	slli s3, s3, 1

	#-- 2. Leer bit mas significativo de s2
	slt t0, s2, zero

	#-- 3. Añadir BMS de s2 a s3
	add s3, s3, t0

	#-- 4. Desplazar s2 a la izquierda
	slli s2, s2, 1

	#-- 5. Leer bit mas significativo de s1
	slt t0, s1, zero

	#-- 6. Añadir BMS de s1 a s2
	add s2, s2, t0

	#-- 7. Desplazar s1 a la izquierda
	slli s1, s1, 1

	#------------ Queda un paso menos por hacer del algoritmo
	addi s4, s4, -1

	#-- Repetir el algoritmo si todavía toca
	bgt s4, zero, sprint_uint32_next

	#------- Fase de impresion
	#-- Primero se almacena en un buffer
	#-- Luego se imprime desde memoria

	#-- Almacenar registro bcd de mayor peso
	la a0, sprint_uint32_buff
	mv a1, s3  #-- reg
	li a2, 2   #-- Numero de digitos
	jal store_bcd

	#-- Almacenar registro bcd de menor peso
	mv a1, s2  #-- Reg
	li a2, 8   #-- Numero de digitos
	jal store_bcd

	#-- "Imprimir" los digitos en la cadena destino
	mv a0, s0  #-- dst
	la a1, sprint_uint32_buff
	li a2, 10  #-- Numero de digitos
	li a3, 0  #-- Ceros iniciales: NO
	jal sprint_bcd_from_mem

	#-- Liberar la pila
	STACK32_POP5(s0, s1, s2, s3, s4)
	UNSTACK32


.global sprint_uint16
sprint_uint16:
#----------------------------------------------------------------
#-- SPRINT_UINT16(dst, n)
#--
#-- Imprimir un numero decimal sin signo, de 16 bits (5 digitos)
#--
#-- ENTRADA:
#--   - a0 (dst): Dirección de la cadena destino
#--   - a1 (n): Numero de 16 bits a imprimir
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#------------------------------------------------------------------
#-- Registro de calculo para hacer los desplazamientos:
#
#  -Parte alta (s2)
#    31                                                  3       0
#  +---------------------------------------------------------------+
#  |                                                   |   Dig4    |
#  |                                                   |  0 0 0 0  |
#  +---------------------------------------------------------------+
#
#  -Parte baja (s1):
#   31     28 27     24 23     20  19    16  15                  0
#  +---------------------------------------------------------------+
#  |   Dig3  |   Dig2  |  Dig1    | Dig 0   |           n          |
#  | 0 0 0 0 | 0 0 0 0 | 0 0 0 0  | 0 0 0 0 |        d15 - d0      |
#  +---------------------------------------------------------------+
	.data

	#-- Buffer donde guardar los digitos bcd en memoria
	#-- para luego "imprimirlos"
 sprint_uint16_buff:  .space 5

	.text

	STACK32
	STACK32_PUSH4(s0, s1, s2, s3)

	#-- Guardar direccion de la cadena destino
	mv s0, a0

	#-- S2: Registro bcd. Parte alta
	li s2, 0

	#-- S1: Registro bcd. Parte baja
	li t0, 0x0000FFFF
	and s1, a1, t0
	
	#-- Estado inicial. Desplazar parte baja 3 bits a la izquierda
	#-- La parte alta se queda como está, a 0
	slli s1, s1, 3

	#-- Contador de desplazamientos a realizar para finalizar el algoritmo
	#-- Ya hemos hecho 3, quedan 16-3 = 13
	li s3, 13

 sprint_uint16_next:

	#-- Actualizar campo Dig4
	mv a0, s2
	li a1, 0   #-- Numero de digito
	li a2, 0   #-- Tamaño de n (en bits)
	jal uint_update_bcd
	mv s2, a0


	#-------------- Actualizar la parte alta del registro bcd
	#-------------- Este registro almacena 4 digitos
	mv a0, s1  #-- Registro bcd alto
	li a1, 4   #-- Actualizar 4 digitos
	li a2, 16  #-- Offset
	jal uint_update_bcd_reg
	mv s1, a0

	#---------- Desplazamiento a la izquierda del registro s2-s1
	#-- 1. Desplazar S2 a la izquierda
	slli s2, s2, 1

	#-- 2. Leer bit mas significativo de s1
	slt t0, s1, zero

	#-- 3. Añadir BMS de s1 a s2
	add s2, s2, t0

	#-- 4. Desplazar s1 a la izquierda
	slli s1, s1, 1

	#-------- Queda un desplazamiento menos por hacer
	addi s3, s3, -1

	#-- Repetir el algoritmo si todavía toca
	bgt s3, zero, sprint_uint16_next

	#------- Fase de impresion
	#-- Primero se almacena en un buffer
	#-- Luego se imprime desde memoria

	#-- Almacenar registro bcd de mayor peso
	la a0, sprint_uint16_buff
	mv a1, s2  #-- reg
	li a2, 1   #-- Numero de digitos
	jal store_bcd

	#-- Almacenar registro bcd de menor peso
	srli a1, s1, 16  #-- Reg
	li a2, 4         #-- Numero de digitos
	jal store_bcd

	#-- "Imprimir" los digitos en la cadena destino
	mv a0, s0  #-- dst
	la a1, sprint_uint16_buff
	li a2, 5  #-- Numero de digitos
	li a3, 0  #-- Ceros iniciales: NO
	jal sprint_bcd_from_mem


	#-- Liberar la pila
	STACK32_POP4(s0, s1, s2, s3)
	UNSTACK32


.global sprint_uint8
sprint_uint8:
#----------------------------------------------------------------
#-- SPRINT_UINT8(dst, n)
#--
#-- Imprimir un numero decimal sin signo, de 8 bits (3 digitos)
#--
#-- ENTRADA:
#--   - a0 (dst): Dirección de la cadena destino
#--   - a1 (n): Numero de 8 bits a imprimir
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#------------------------------------------------------------------
#-- Registro de calculo para hacer los desplazamientos: a1
#  +----------------------------------------------------------+
#  |  Dig2    |  Dig1    | Dig 0   |            n             |
#  | 0 0 0 0  | 0 0 0 0  | 0 0 0 0 | d7 d6 d5 d4 d3 d2 d1 d0  |
#  +----------------------------------------------------------+
#
# La posicion de cada campo es: pos(digi) = i*4 + tam(n)
	.data

	#-- Buffer donde guardar los digitos bcd en memoria
	#-- para luego "imprimirlos"
 sprint_uint8_buff:  .space 3

	.text

	STACK16
	PUSH2(s0, s1)

	#-- Guardar direccion de la cadena destino
	mv s0, a0

	#-- Poner a 0 todos los digitos BCD
	andi a1, a1, 0xFF

	#-- Desplazar 3 bits a la izquierda. A partir de eso comienza
	#-- el algoritmo
	slli a1, a1, 3

 #  +----------------------------------------------------------+
 #  |  Dig2    |  Dig1    | Dig 0      |            n          |
 #  | 0 0 0 0  | 0 0 0 0  | 0 d7 d6 d5 | d4 d3 d2 d1 d0 0 0 0  |
 #  +----------------------------------------------------------+

	#-- Contador de desplazamientos a realizar para finalizar el algoritmo
	#-- Ya hemos hecho 3, quedan 5 (en total son 8)
	li s1, 5

	mv a0, a1  #-- Registro bcd

 sprint_uint8_next:


	#-------------- Actualizar registro bcd
	#-------------- Este registro almacena 3 digitos
	#mv a0, a1  #-- Registro bcd
	li a1, 3   #-- Actualizar 3 digitos
	li a2, 8  #-- Offset
	jal uint_update_bcd_reg

	#-- Desplazamiento a la izquierda
	slli a0, a0, 1

	#-- Queda un paso menos del algoritmo por hacer
	addi s1, s1, -1

	bgt s1, zero, sprint_uint8_next

	#------- Fase de impresion
	#-- Primero se almacena en un buffer
	#-- Luego se imprime desde memoria

	#-- s1: Registro bcd
	mv s1, a0

	#-- Almacenar registro bcd
	la a0, sprint_uint8_buff
	srli a1, s1, 8  #-- Reg bcd
	li a2, 3        #-- Numero de digitos
	jal store_bcd

	#-- "Imprimir" los digitos en la cadena destino
	mv a0, s0  #-- dst
	la a1, sprint_uint8_buff
	li a2, 3  #-- Numero de digitos
	li a3, 0  #-- Ceros iniciales: NO
	jal sprint_bcd_from_mem

	#-- Liberar la pila
	POP2(s0, s1)
	UNSTACK16


.global sprint_bcd
sprint_bcd:
#-------------------------------------------------------------
#-- sprint_bcd(dst, bcd, ndig, ini0)
#--
#--  Imprimir en la cadena destino los digitos bcd
#--
#--  ENTRADA:
#--    - a0 (dst): Buffer donde "imprimir" la cadena
#--    - a1 (bcd): Registro con digitos bcd (8 como maximo)  
#--    - a2 (ndig): Numero de digitos a mostrar
#--    - a3 (ini0): Mostrar ceros iniciales
#--       - 0: Sin cero iniciales
#--       - 1: Mostrar los ceros iniciales
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#------------------------------------------------------------
	.data

	#-- Buffer donde guardar los digitos bcd en memoria
	#-- para luego "imprimirlos"
sprint_bcd_buff:  .space 32

	.text

	STACK32
	STACK32_PUSH4(s0, s1, s2, s3)

	#-- Guardar parámetros
	mv s0, a0  #-- Cadena destino
	mv s1, a1  #-- Registro bcd
	mv s2, a2  #-- Num. Maximo de digitos
	mv s3, a3  #-- Ceros iniciales

	#-- Almacenar el registro con digitos bcds en memoria
	la a0, sprint_bcd_buff
	mv a1, s1  #-- reg
	mv a2, s2  #-- n
	jal store_bcd

	#-- "Imprimir" los digitos en la cadena destino
	mv a0, s0  #-- dst
	la a1, sprint_bcd_buff
	mv a2, s2  #-- n
	mv a3, s3  #-- ini0
	jal sprint_bcd_from_mem

	STACK32_POP4(s0, s1, s2, s3)
	UNSTACK32


.global sprint_bcd_from_mem
sprint_bcd_from_mem:
#-----------------------------------------------------------------
#-- sprint_bcd_from_memory(dst,buff, n, ini0)
#--
#-- Imprimir los n digitos bcd almacenados en buffer en la cadena dst
#--
#-- ENTRADA:
#--   - a0 (dst):  Cadena destino en memoria
#--   - a1 (buff): Buffer con los digitos bcd almacenados
#--   - a2 (n): Numero de digitos
#--   - a3 (ini0): Mostrar ceros iniciales
#--       - 0: Sin cero iniciales
#--       - 1: Mostrar los ceros iniciales
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena
#-----------------------------------------------------------------
	STACK32
	STACK32_PUSH5(s0, s1, s2, s3, s4)

	#-- Almacenar parametros
	mv s0, a0  #-- Cadena destino
	mv s1, a1  #-- Buffer de digitos bcd
	mv s2, a2  #-- Numero de digitos
	mv s3, a3  #-- Ceros iniciales

	#-- Detectar el primer digito no cero
	#-- s4 = 0 --> No se ha alcanzado el primer digito
	#-- s4 = 1 --> Primer digito alcanzadof
	mv s4, a3

sprint_bcd_from_mem_next:

	#-- Leer primer digito
	lbu a1, 0(s1)

	#-- Si s4==1, estamos en modo impresión
	#-- ¡Imprimir el digito!
	li t0, 1
	beq s4, t0, sprint_bcd_from_mem_print

	#-- Comprobar si se ha alcazando el primer
	#-- digito distinto de cero
	beq a1, zero, sprint_bcd_from_mem_skip

	#-- digi == 0
	#-- Primer digito no 0 alcanzado!
 sprint_bcd_from_mem_print:
	#-- Pasar a modo impresion
	li s4, 1 

	#-- Imprimir digito bcd
	jal sprint_hex4

 sprint_bcd_from_mem_skip:

	#-- Incrementar el puntero del buffer
	addi s1, s1, 1

	#-- Queda un digito menos
	addi s2, s2, -1

	#-- ¿Hemos terminado?
	bgt s2, zero, sprint_bcd_from_mem_next

	#-- Caso especial
	#-- Si s4 == 0, el numero es un 0. ¡Imprimirlo!
	bne s4, zero, sprint_bcd_from_mem_next2

	#-- Imprimir el 0!
	mv a0, s0
	mv a1, zero
	jal sprint_hex4

 sprint_bcd_from_mem_next2:

	#-- Liberar la pila
	STACK32_POP5(s0, s1, s2, s3, s4)
	UNSTACK32


.global store_bcd
store_bcd:
#------------------------------------------------------------------
#-- store_bcd(buff, reg, n)
#--  Almacenar en la memoria apuntada por buff los n digitos bcd
#--  que se encuentran en reg (8 como maximo)
#--
#--  Cada dígito BCD se almacena como un byte, empezando por el de
#--  mayor peso
#--
#--  Ejemplo: store_bcd(buff, 0x321, 3) --> Almacena en memoria
#--    estos bytes: 0x03, 0x02, 0x01 (Ordenacion Big Endian) 
#--
#-- ENTRADAS:
#--   - a0: (buff) Puntero al buffer donde guardar los digitos bcd
#--   - a1: (reg) Registro con los dígitos bcd
#--   - a2 (n): Número de digitos a copiar (desde el de menor peso)
#--
#-- SALIDA:
#--   - a0: Puntero al final de los digitos bcd
#------------------------------------------------------------------
store_bcd_next:

	#-- Bits a desplazar: t2 = (tam-1)*4
	mv t2, a2
	addi t2, t2, -1  #-- tam-1
	slli t2, t2, 2   #-- (tam-1)*4

	#-- t0 = mascara para obtener el digito actual
	li t0, 0xF
	sll t0, t0, t2

	#-- t1 = digito actual
	and t1, a1, t0   #-- Sacarlo del registro
	srl t1, t1, t2   #-- Llevarlos a la posición de menor peso

	#-- Guardarlo en el buffer
	sb t1, 0(a0)

	#-- Apuntar a la siguiente posicion
	addi a0, a0, 1

	#-- Queda un digito menos
	addi a2, a2, -1

	#-- Terminar si todos los digitos estan almacenados
	bgt a2, zero, store_bcd_next

	ret


uint_update_bcd_reg:
#------------------------------------------------------------------
#--  uint_update_bcd_reg(reg, ndig, off)
#--
#--  Actulizar TODOS los digitos indicados del registro
#--
#--  ENTRADAS:
#--   - a0 (reg): Registro bcd (que contiene como max. 8 digitos)
#--   - a1 (ndig): Numero de digitos a actualizar
#--   - a2 (off): Offset dentro del registro (para el comienzo de
#--               los digitos)
#--
#--  SALIDA:
#--   - a0: Devolver el registro actualizado
#------------------------------------------------------------------
	STACK16
	PUSH2(s0, s1)

	#-- Contador de digitos a actualizar
	mv s0, a1  #-- numero de digitos
	mv s1, a2  #-- offset

 uint_update_bcd_reg_next:

	#-- Actualizar contador
	addi s0, s0, -1

	#-- Actualizar digito
	mv a1, s0  #-- Numero de digito
	mv a2, s1  #-- Offset
	jal uint_update_bcd

	#-- Siguiente digito
	bgt s0, zero, uint_update_bcd_reg_next

	POP2(s0, s1)
	UNSTACK16



uint_update_bcd:
#--------------------------------------------------------------------
#-- uint_update_bcd(reg_bcd, i, n)
#--
#--  Actualizar el campo Digi del registro BCD
#--  Esta actualizacion consiste en sumar 3 si el valor de este
#--  campo es estrictamente mayor a 4
#--
#-- ENTRADAS:
#--
#--  a0: Registro bcd
#--  a1: Numero de digito (0-i)
#--  a2: Tamaño de n (en bits)
#--
#-- SALIDA:
#--   a0: Valor actualizado del registro BCD
#----------------------------------------------------------------------

	#-- Obtener la posicion del campo
	#-- t0: pos(a1, a2) = a1*4 + a2
	slli a1, a1, 2   #-- a1 = a1*4
	add t0, a1, a2   #-- t0 = a1*4 + a2: Posicion del campo dig

	#-- t1: Obtener la mascara
	li t1, 0xF
	sll t1, t1, t0

	#-- t2: Obtener el campo especificado
	and t2, a0, t1  #-- Aislar el campo usando la mascara
	srl t2, t2, t0  #-- Llevarlo a los bits de menor peso

	#-- Si t2 > 4, t2 = t2 + 3
	li t4, 4
	ble t2, t4, uint_update_bcd_cont

	#-- Sumar 3
	addi t2, t2, 3

 uint_update_bcd_cont:
	
	#-- Llevar el campo a su posicion original
	sll t2, t2, t0

	#-- Poner a 0 el campo correspondiente del registro bcd
	xori t3, t1, -1
	and a0, a0, t3

	#-- Añadir el nuevo campo al registro bcd!
	or a0, a0, t2

	#-- a0: Registro bcd actualizado
	ret



.global sprint_uint4
sprint_uint4:
#----------------------------------------------------------------
#-- SPRINT_UINT4(dst, n)
#--
#-- Imprimir un numero decimal sin signo, de 4 bits (2 digitos)
#--
#-- ENTRADA:
#--   - a0 (dst): Dirección de la cadena destino
#--   - a1 (n): Numero de 4 bits a imprimir
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#------------------------------------------------------------------

	#-- Mascara para obtener el campo Dig1
	.eqv DIG1_MASK 0xF00 

	#-- Posicion del campo Dig1
	.eqv DIG1_POS 8

	#-- Mascara para obtener el campo Dig0
	.eqv DIG0_MASK 0x0F0

	#-- Posicion del campo Dig0
	.eqv DIG0_POS 4

	#-- Algoritmo Doubble Dabble
	#-- https://en.wikipedia.org/wiki/Double_dabble

	#-- Registro de calculo: a1
	#  +-------------------------------+
	#  |  Dig1    |  Dig0    |    n    |
	#  | 0 0 0 0  | 0 0 0 0  | a b c d |
	#  +-------------------------------+

	STACK16
	PUSH2(s0, s1)

	#-- Guardar los parámetros
	mv s0, a0  #-- Cadena destino
	#-- s1: Registro bcd

	#-- Estado inicial: Poner dig1 y dig0 a 0
	andi s1, a1, 0xF

	#-- Primera fase: Desplazar a1 3 bits hacia la izquierda
	slli s1, s1, 3
	#  +-------------------------------+
	#  |  Dig1    |  Dig0    |    n    |
	#  | 0 0 0 0  | 0 a b c  | d 0 0 0 |
	#  +-------------------------------+

	#-- Actualizar campo Dig1
	mv a0, s1  #-- Registro bcd
	li a1, 1   #-- Numero de digito bcd
	li a2, 4   #-- Tamaño de 4 bits
	jal uint_update_bcd

	#-- Actualizar campo Dig0
	li a1, 0   #-- Numero de digito bcd
	li a2, 4   #-- Tamaño de 4 bits
	jal uint_update_bcd

	#-- Desplazamiento a la izquierda 1 bit: Fin!
	#-- Ya tenemos en dig1 y dig0 el numero en BCD
	slli a0, a0, 1

	#-- Guardar registro bcd
	mv s1, a0

	#-- Obtener dig1
	li t2, DIG1_MASK
	and t1, s1, t2
	srli t1, t1, DIG1_POS  #-- t1 = dig1

	#-- Imprimir dig1!
	mv a0, s0
	mv a1, t1
	jal sprint_hex4

	#-- Obtener dig0
	li t2, DIG0_MASK
	and t0, s1, t2
	srli t0, t0, DIG0_POS  #-- t0 = dig0

	#-- Imprimir  dig0!
	mv a1, t0
	jal sprint_hex4

	#-- Liberar la pila
	POP2(s0, s1)
	UNSTACK16


















.global sprint_hex4
sprint_hex4:
 #--------------------------------------------------
 #-- SPRINT_HEX4(dst, n)
 #-- Imprimir un numero hexadecimal de 4 bits
 #--
 #--  ENTRADAS:
 #--   - a0 (dst): Puntero a cadena destino
 #--   - a1 (n): Numero a imprimir
 #--  SALIDA:
 #--   - a0: Puntero al final de la cadena destino
 #--   - a1: (Opcional) Nº de bits impresos
 #--------------------------------------------------

	#-- Quedarse con los 4 bits menos significativos
	andi a1, a1, 0x0F

	#-- Convertir a caracter '0'...'9' - 'A'...'F'
	#-- Si n < 10, sumar '0'. Es un digito '0' - '9'
	#-- sino, sumar ('A'-10) = 0x37
	li t0, 10
	blt a1, t0, digit_0_9

	#-- Digito 'A'...'F'
	addi a1, a1, 0x37
	j sprint_hex4_next

 digit_0_9:
	addi a1, a1, '0' 

 sprint_hex4_next:

	#-- Almacenar caracter en cadena destino
	sb a1, 0(a0)

	#-- Incrementar puntero de cadena destino
	addi a0, a0, 1

	#-- Cadena terminada
	sb zero, 0(a0)

	li a1, 4  #-- 4 bits impresos
	ret





#----------------------------------------------------------------
#-- SPRINT_UINT(dst, n)
#--
#-- Imprimir un numero decimal sin signo, de 32 bits (10 digitos)
#--
#-- ENTRADA:
#--   - a0 (dst): Dirección de la cadena destino
#--   - a1 (n): Numero de 32 bits a imprimir
#--   - a2 (ndig): Numero de digitos (1-10)
#--
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#------------------------------------------------------------------
#-- Registro de calculo para hacer los desplazamientos:
#
#  -Parte alta (s3)
#    31                                              8 | 7    4 | 3       0
#  +------------------------------------------------------------------------+
#  |                                                   |   Dig9 |   Dig8    |
#  |                                                   | 0 0 0 0|  0 0 0 0  |
#  +------------------------------------------------------------------------+
#
#  -Parte media (s2):
#   31   28| 27   24|23    20| 19  16 | 15   12 | 11    8| 7      4| 3     0
#  +------------------------------------------------------------------------+
#  |  Dig7 |  Dig6  |  Dig5  | Dig 4  |  Dig3   | Dig2   |  Dig1   |  Dig0  |
#  |0 0 0 0| 0 0 0 0| 0 0 0 0| 0 0 0 0| 0 0 0 0 | 0 0 0 0| 0 0 0 0 | 0 0 0 0|
#  +------------------------------------------------------------------------+
#
#  -Parte baja (s1):
#   31                                                                    0
#  +------------------------------------------------------------------------+
#  |      n                                                                 |
#  |  d31 - d0                                                              |
#  +------------------------------------------------------------------------+
.global sprint_uint
sprint_uint:

	.data

	#-- Buffer donde guardar los digitos bcd en memoria
	#-- para luego "imprimirlos"
 sprint_uint_buff:  .space 10

	.text
	STACK32
	STACK32_PUSH6(s0, s1, s2, s3, s4, s5)

	#-- Guardar direccion de la cadena destino
	mv s0, a0
	
	#-- Inicializar registro BCD
	mv s1, a1  #-- Parte baja
	li s2, 0
	li s3, 0   #-- Parte alta
	mv s5, a2  #-- Numero de digitos

	#------- Estado inicial. Desplazar registro BCD 3 bits
	#------- a la izquierda  s2 <- s1
	#-- 1. Obtener los 3 bits de mayor peso de s1
	li t0, 0xE0000000  #-- Cambiar a lui
	and t0, s1, t0

	#-- 2. Llevar estos 3 bits a s2 (a la pos de menor peso)
	srli s2, t0, 29

	#-- 3. Desplazar s1 3 bits a la izquierda
	slli s1, s1, 3

	#-- Contador de desplazamientos a realizar para finalizar el algoritmo
	#-- Ya hemos hecho 3, quedan 32-3 = 29
	li s4, 29


 sprint_uint_next:

	#-------------- Actualizar la parte alta del registro bcd
	#-------------- Este registro almacena 2 digitos
	mv a0, s3  #-- Registro bcd alto
	li a1, 2   #-- Actualizar 2 digitos
	li a2, 0   #-- Offset: 0
	jal uint_update_bcd_reg
	mv s3, a0

	#-------------- Actualizar la parte baja del registro bcd
	#-------------- Este registro almacena 8 digitos
	mv a0, s2  #-- Registro bcd alto
	li a1, 8   #-- Actualizar 8 digitos
	li a2, 0   #-- Offset 0
	jal uint_update_bcd_reg
	mv s2, a0


	#------------ Desplazamiento a la izquierda del registro s3-s2-s1
	#-- 1. Desplazar s3 a la izquierda
	slli s3, s3, 1

	#-- 2. Leer bit mas significativo de s2
	slt t0, s2, zero

	#-- 3. Añadir BMS de s2 a s3
	add s3, s3, t0

	#-- 4. Desplazar s2 a la izquierda
	slli s2, s2, 1

	#-- 5. Leer bit mas significativo de s1
	slt t0, s1, zero

	#-- 6. Añadir BMS de s1 a s2
	add s2, s2, t0

	#-- 7. Desplazar s1 a la izquierda
	slli s1, s1, 1

	#------------ Queda un paso menos por hacer del algoritmo
	addi s4, s4, -1

	#-- Repetir el algoritmo si todavía toca
	bgt s4, zero, sprint_uint_next

	#------- Fase de impresion
	#-- Primero se almacena en un buffer
	#-- Luego se imprime desde memoria

	#-- Almacenar registro bcd de mayor peso
	la a0, sprint_uint_buff
	mv a1, s3  #-- reg
	li a2, 2   #-- Numero de digitos
	jal bcd_store_hex

	#-- Almacenar registro bcd de menor peso
	mv a1, s2  #-- Reg
	li a2, 8   #-- Numero de digitos
	jal bcd_store_hex

	#-- "Imprimir" los digitos en la cadena destino
	mv a0, s0  #-- dst
	la a1, sprint_uint_buff
	li a2, 10  #-- Numero de digitos
	li a3, 0  #-- Ceros iniciales: NO
	jal bcd_copy

	#-- Liberar la pila
	STACK32_POP6(s0, s1, s2, s3, s4, s5)
	UNSTACK32













#--------------------------------------------------
#-- SPRINT_HEX(dst, n, tam)
#-- Imprimir un numero hexadecimal de n digitos
#--
#--  ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (n): Numero a imprimir
#--   - a2 (tam): Tamaño del numero a imprimir (en digitos)
#--  SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#--------------------------------------------------
.global sprint_hex
sprint_hex:
 	STACK16
	PUSH2(s0, s1)

	#-- Guardar parametros
	mv s0, a0   #-- Cadena destino
	mv s1, a2   #-- Numero de digitos a imprimir

	#-- Pasarlos a BCD y guardarlos en memoria
	la a0, buffer_bcd
	jal bcd_store_hex

	#-- Imprimir los digitos BCD en la cadena destino
	mv a0, s0
	la a1, buffer_bcd
	mv a2, s1
	li a3, 1  #-- Con ceros iniciales
	jal bcd_copy

	POP2(s0, s1)
	UNSTACK16


#--------------------------------------------------
#-- SPRINT_OCT(dst, n, tam)
#-- Imprimir un numero octal de n digitos
#--
#--  ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (n): Numero a imprimir
#--   - a2 (tam): Tamaño del numero a imprimir
#--  SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#--------------------------------------------------
.global sprint_oct
sprint_oct:

	STACK16
	PUSH2(s0, s1)

	#-- Guardar parametros
	mv s0, a0   #-- Cadena destino
	mv s1, a2   #-- Numero de digitos a imprimir

	#-- Pasarlos a BCD y guardarlos en memoria
	la a0, buffer_bcd
	jal bcd_store_oct

	#-- Imprimir los digitos BCD en la cadena destino
	mv a0, s0
	la a1, buffer_bcd
	mv a2, s1
	li a3, 1  #-- Con ceros iniciales
	jal bcd_copy

	POP2(s0, s1)
	UNSTACK16



#--------------------------------------------------
#-- SPRINT_BIN(dst, n, tam)
#-- Imprimir un numero binario de n bits
#--
#--  ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (n): Numero a imprimir
#--   - a2 (tam): Tamaño del numero a imprimir
#--  SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bits impresos
#--------------------------------------------------
.global sprint_bin
sprint_bin:

	.text
	STACK16
	PUSH2(s0, s1)

	#-- Guardar parametros
	mv s0, a0   #-- Cadena destino
	mv s1, a2   #-- Numero de bits a imprimir

	#-- Pasarlos a BCD y guardarlos en memoria
	la a0, buffer_bcd
	jal bcd_store_bin

	#-- Imprimir los digitos BCD en la cadena destino
	mv a0, s0
	la a1, buffer_bcd
	mv a2, s1
	li a3, 1  #-- Con ceros iniciales
	jal bcd_copy

	POP2(s0, s1)
	UNSTACK16


#------------------------------------------------------------------
#-- bcd_store_hex(buff_bcd, reg, tam)
#--  Almacenar en la memoria apuntada por buff_bcd los n digitos
#--  de menor peso que se encuentra en reg (10 max)
#--
#--  Cada digito se almacena como un byte
#--
#--  Ejemplo: bcd_store_hex(buff, 0x029C, 4) --> Almacena en memoria
#--    estos bytes: 0, 2, 9, C (Ordenacion Big Endian) 
#--
#-- ENTRADAS:
#--   - a0: (buff_bcd) Puntero al buffer donde guardar los digitos bcd
#--   - a1: (reg) Registro con los dígitos bcd
#--   - a2 (n): Número de bits a copiar (desde el de menor peso)
#--
#-- SALIDA:
#--   - a0: Puntero al final de los digitos bcd
#------------------------------------------------------------------
.global bcd_store_hex
bcd_store_hex:
 bcd_store_hex_next:

	#-- Bits a desplazar: t2 = (tam-1)*4
	mv t2, a2
	addi t2, t2, -1  #-- tam-1

	#-- t3 = (tam - 1) * 4
	slli t3, t2, 2  #-- * 2

	#-- t0 = mascara para obtener el digito actual
	li t0, 0xF
	sll t0, t0, t3

	#-- t1 = digito actual
	and t1, a1, t0   #-- Sacarlo del registro
	srl t1, t1, t3   #-- Llevarlos a la posición de menor peso

	#-- Guardarlo en el buffer
	sb t1, 0(a0)

	#-- Apuntar a la siguiente posicion
	addi a0, a0, 1

	#-- Queda un digito menos
	addi a2, a2, -1

	#-- Terminar si todos los bits estan almacenados
	bgt a2, zero, bcd_store_hex_next

	ret


#------------------------------------------------------------------
#-- bcd_store_oct(buff_bcd, reg, tam)
#--  Almacenar en la memoria apuntada por buff_bcd los n digitos
#--  de menor peso que se encuentra en reg (10 max)
#--
#--  Cada digito se almacena como un byte
#--
#--  Ejemplo: bcd_store_oct(buff, 0x29C, 4) --> Almacena en memoria
#--    estos bytes: 1, 2, 3, 4 (Ordenacion Big Endian) 
#--
#-- ENTRADAS:
#--   - a0: (buff_bcd) Puntero al buffer donde guardar los digitos bcd
#--   - a1: (reg) Registro con los dígitos bcd
#--   - a2 (n): Número de bits a copiar (desde el de menor peso)
#--
#-- SALIDA:
#--   - a0: Puntero al final de los digitos bcd
#------------------------------------------------------------------
.global bcd_store_oct
bcd_store_oct:
 bcd_store_oct_next:

	#-- Bits a desplazar: t2 = (tam-1)*3
	mv t2, a2
	addi t2, t2, -1  #-- tam-1

	#-- t3 = (tam - 1) * 3
	slli t0, t2, 1  #-- * 2
	add t3, t0, t2  #-- * 3

	#-- t0 = mascara para obtener el digito actual
	li t0, 0x7
	sll t0, t0, t3

	#-- t1 = digito actual
	and t1, a1, t0   #-- Sacarlo del registro
	srl t1, t1, t3   #-- Llevarlos a la posición de menor peso

	#-- Guardarlo en el buffer
	sb t1, 0(a0)

	#-- Apuntar a la siguiente posicion
	addi a0, a0, 1

	#-- Queda un digito menos
	addi a2, a2, -1

	#-- Terminar si todos los bits estan almacenados
	bgt a2, zero, bcd_store_oct_next

	ret



#------------------------------------------------------------------
#-- bcd_store_bin(buff_bcd, reg, tam)
#--  Almacenar en la memoria apuntada por buff_bcd los n bits
#--  de menor peso que se encuentra en reg (32 max)
#--
#--  Cada bit se almacena como un byte
#--
#--  Ejemplo: bcd_store_bin(buff, 0x101, 3) --> Almacena en memoria
#--    estos bytes: 1, 0, 1 (Ordenacion Big Endian) 
#--
#-- ENTRADAS:
#--   - a0: (buff_bcd) Puntero al buffer donde guardar los digitos bcd
#--   - a1: (reg) Registro con los dígitos bcd
#--   - a2 (n): Número de bits a copiar (desde el de menor peso)
#--
#-- SALIDA:
#--   - a0: Puntero al final de los digitos bcd
#------------------------------------------------------------------
.global bcd_store_bin
bcd_store_bin:
 bcd_store_bin_next:

	#-- Bits a desplazar: t2 = tam-1
	mv t2, a2
	addi t2, t2, -1  #-- tam-1

	#-- t0 = mascara para obtener el digito actual
	li t0, 1
	sll t0, t0, t2

	#-- t1 = digito actual
	and t1, a1, t0   #-- Sacarlo del registro
	srl t1, t1, t2   #-- Llevarlos a la posición de menor peso

	#-- Guardarlo en el buffer
	sb t1, 0(a0)

	#-- Apuntar a la siguiente posicion
	addi a0, a0, 1

	#-- Queda un digito menos
	addi a2, a2, -1

	#-- Terminar si todos los bits estan almacenados
	bgt a2, zero, bcd_store_bin_next

	ret



#---------------------------------------------------
#-- bcd_copy(dst, buffer_bcd)
#--
#--  Imprimir una lista de digitos bcd almacenada en
#--  buffer_bcd en la cadena destino
#--
#--  Ej. La lista de bytes 1, 2, 3  se copia en la cadena
#--    destino como "123"
#--
#--  ENTRADAS:
#--   - a0 (dst): Buffer de la cadena destino
#--   - a1 (buffer_bcd): Buffer de los digitos bcd
#--   - a2 (ndig): Numero de digitos a copiar en cadena destino
#--   - a3 (ini0): Copiar ceros iniciales
#--      - 0: Sin cero iniciales
#--      - 1: Copiar los ceros iniciales
#--
#--  SALIDAS:
#--   - Ninguna
#----------------------------------------------------------------
.global bcd_copy
bcd_copy:

	STACK32
	STACK32_PUSH5(s0, s1, s2, s3, s4)

	#-- Guardar los parametros
	mv s0, a0  #-- Cadena destino
	mv s1, a1  #-- Buffer bcd origen
	mv s2, a2  #-- Contador de digitos
	mv s3, a3  #-- Ceros iniciales

	#-- Detectar el primer digito no cero
	#-- s4 = 0 --> No se ha alcanzado el primer digito
	#-- s4 = 1 --> Primer digito alcanzadof
	mv s4, a3

	#-- Si hay 0 digitos, hemos terminado
	beq s2, zero, bcd_copy_end

 bcd_copy_next:
	
	#-- Leer digito bcd actual
	lbu a1, 0(s1)

	#-- Si s4==1, estamos en modo impresión
	#-- ¡Imprimir el digito!
	li t0, 1
	beq s4, t0, bcd_copy_print

	#-- Comprobar si se ha alcazando el primer
	#-- digito distinto de cero
	beq a1, zero, bcd_copy_skip

	#-- Primer digito NO es cero 
 bcd_copy_print:

	#-- Pasar a modo impresion
	li s4, 1

	#-- Imprimirlo en la cadena
	jal sprint_bcd_digit

 bcd_copy_skip:

	#-- Siguiente digito
	addi s1, s1, 1

	#-- Decrementar contador de digitos
	addi s2, s2, -1

	#-- ¿Hemos terminado?
	bgt s2, zero, bcd_copy_next

	#-- Caso especial
	#-- Si s4 ==0, el numero es un 0. ¡Imprimirlo!
	bne s4, zero, bcd_copy_end

	#-- Imprimir el 0!
	mv a0, s0
	mv a1, zero
	jal sprint_bcd

 bcd_copy_end:
	STACK32_POP5(s0, s1, s2, s3, s4)
	UNSTACK32


#--------------------------------------------------
#-- sprint_bcd_digit(dst, dig)
#--
#-- Imprimir un digito en BCD. Del digito pasado
#-- solo se usan los 4 bits de menor peso
#--
#-- Numero BCD     Caracter
#-- ----------     --------
#-- 0000             '0'
#-- 0001             '1'
#-- 0010             '2'
#-- 0011             '3' 
#-- 0100             '4'
#-- ...
#-- 1010             'A'
#-- 1011             'B'
#-- 1100             'C'
#-- ...
#-- 1111             'F'
#--
#-- ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (bcd): Digito BCD a imprimir (4 bits)
#--
#-- SALIDAS:
#--   - a0: Puntero al final de la cadena destino
#--------------------------------------------------
#-- IMPLEMENTACION 1: Sin utilizar look-up table
#--------------------------------------------------
.global sprint_bcd_digit
sprint_bcd_digit:

	#-- Quedarse con los 4 bits menos significativos
	andi a1, a1, 0x0F

	#-- Convertir a caracter '0'...'9' - 'A'...'F'
	#-- Si n < 10, sumar '0'. Es un digito '0' - '9'
	#-- sino, sumar ('A'-10) = 0x37
	li t0, 10
	blt a1, t0, sprint_bcd_digit_digit_0_9

	#-- Digito 'A'...'F'
	addi a1, a1, 0x37
	j sprint_bcd_digit_next

 sprint_bcd_digit_digit_0_9:
	addi a1, a1, '0' 

 sprint_bcd_digit_next:

	#-- Almacenar caracter en cadena destino
	sb a1, 0(a0)

	#-- Incrementar puntero de cadena destino
	addi a0, a0, 1

	#-- Cadena terminada
	sb zero, 0(a0)

	li a1, 4  #-- 4 bits impresos
	ret

#--------------------------------------------------
#-- sprint_bcd_digit
#--------------------------------------------------
#-- IMPLEMENTACION 2: Mediante tabla de Look-up
#--------------------------------------------------
.global sprint_bcd_digit2
sprint_bcd_digit2:
	.data

	#--- Look up table (LUT) para los digitos BCD
 bcd_lut:
	.byte '0', '1', '2', '3', '4', '5', '6', '7'
	.byte '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'

	.text

	#-- Obtener direccion base de la lut
	la t0, bcd_lut

	#-- Sumar el digito bcd actual
	add t0, t0, a1

	#-- Realizar la conversion
	lb t1, 0(t0)

	#-- Almacenar caracter en cadena destino
	sb t1, 0(a0)

	#-- Incrementar puntero cadena destino
	addi a0, a0, 1

	#-- Cadena terminada
	sb zero, 0(a0)
	ret

#--------------------------------------------------
# SPRINT_UNARY(dst, n, mark)
#-- Imprimir un numero en unario
#--
#--  ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (n): Numero a imprimir en unario
#--   - a2 (mark): Marca a usar
#--  SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de marcas impresas
#--------------------------------------------------
.global sprint_unary
sprint_unary:
	#-- Contador de marcas
	li t0, 0

  sprint_unary_bucle:

	#-- Si t0==0, terminar. No hay marcas que imprimir
	beq a1, zero, sprint_unary_end

	#-- Imprimir marca
	sb a2, 0(a0)

	#-- Decrementar contador
	addi a1, a1, -1

	#-- Incrementar puntero de cadena
	addi a0, a0, 1

	#-- Repetir
	j sprint_unary_bucle

  sprint_unary_end:
	sb zero, 0(a0)  #-- Cadena terminada

	#-- a1: Contador de caracteres
	mv a1, t0 
	ret

#--------------------------------------------------
#-- sprint_char(dst, car)
#-- Imprimir un caracter en una cadena
#--
#-- ENTRADAS
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (car): Caracter a añadir a la cadena
#-- SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--------------------------------------------------
.global sprint_char
sprint_char:
	#-- Guardar caracter en el buffer
	sb a1, 0(a0)

	#-- Incrementar puntero del buffer
	addi a0, a0, 1

	#-- Almacenar el terminador 0
	sb zero, 0(a0)
	ret

#--------------------------------------------------
#-- sprint(dst, src)
#-- Imprimir una cadena en una cadena destino
#--
#--  ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (src): Puntero a cadena fuente
#--  SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bytes copiados
#--------------------------------------------------
.global sprint
sprint:
	#-- Contador de caracteres
	li t0, 0
	
	#-- Bucle principal
  sprint_bucle:
	#-- Leer caracter de cadena fuente
	lb t1, 0(a1)
	
	#-- Copiar caracter a destino
	sb t1, 0(a0)
	
	#-- Se copia el primer caracter incondicionalmente
	#-- porque podría ser el \0
	
	#--- EStamos al final de la cadena fuente?
	beq t1, zero, sprint_end
	
	#-- No hemos llegado al final
	#-- Incrementar puntero de cadenas
	addi a0, a0, 1  #-- dst
	addi a1, a1, 1  #-- src
	
	#-- Incrementar contador de caracteres
	addi t0, t0, 1
	
	#-- repetir
	j sprint_bucle
	
	
  sprint_end:
	#-- Hemos terminado de copiar
	#-- a0 apunta al final de la cadena destino
	
	#-- a1: Contador de caracteres
	mv a1, t0
	
	#-- Terminar
	ret

	
	
#------------------------------------------------
#-- puts(str)
#--
#-- Imprimir una cadena en la consola
#-- Llama a putchar para imprimir cada caracter
#--
#-- ENTRADA:
#--  - a0 (str): Puntero a la cadena a imprimir
#------------------------------------------------
.global puts
puts:

    STACK16
	PUSH1(s0)

    #-- s0: Puntero al buffer
    mv s0, a0

 puts_bucle:

    #-- Leer el caracter del buffer
    lb t0, 0(s0)

    #-- Si es 0, terminar
    beq t0, zero, puts_end

    #-- Imprimir el caracter a traves de putchar
    mv a0, t0
    jal putchar

    #-- Apuntar al siguiente caracter
    addi s0, s0, 1

    #-- Siguiente caracter
    j puts_bucle

 puts_end:

	POP1(s0)
    UNSTACK16
    ret

