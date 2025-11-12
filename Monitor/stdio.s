

	#-- Longitud maxima de las cadenas
	.eqv MAX 255

	#-- Servicios del sistema operativo del RARs
	.include "rars_so.s"
	.eqv EXIT 10

		.data
dst:	.space MAX
msg1:	.string "Holi!"
msg2:   .string "Manoli!"
msg3:   .string "--->ok!\n"

#-- Implementado como programa principal de momento
	.text
	
	#-- Prueba de impresion
	la a0, dst
	la a1, msg1
	jal sprint
	
	#-- Cadena 2
	la a1, msg2
	jal sprint
	
	#-- Cadena 3
	la a1, msg3
	jal sprint
	
	#-- Imprimir la cadena creada
	la a0, dst
	li a7, PRINT_STRING
	ecall
	
	
	#-- Terminar
	li a7, EXIT
	ecall
	
	
	
#--------------------------------------------------
#-- SPRINT(dst, src)
#-- Imprimir una cadena en una cadena destino
#--
#--
#--  ENTRADAS:
#--   - a0 (dst): Puntero a cadena destino
#--   - a1 (src): Puntero a cadena fuente
#--  SALIDA:
#--   - a0: Puntero al final de la cadena destino
#--   - a1: (Opcional) Nº de bytes copiados
#--------------------------------------------------
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

	
	
