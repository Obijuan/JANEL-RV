
#------------------------------------------------------------------------------
#-- stdio.s: Rutinas para salida standar
#------------------------------------------------------------------------------
#-- Mascaras para BITs
	.eqv BIT0 0x01 

.global sprint_oct
sprint_oct:
 #--------------------------------------------------
 #-- SPRINT_OCT(dst, n, tam)
 #-- Imprimir un numero octar de n digitos
 #--
 #--  ENTRADAS:
 #--   - a0 (dst): Puntero a cadena destino
 #--   - a1 (n): Numero a imprimir
 #--   - a2 (tam): Tamaño del numero a imprimir (en digitos)
 #--  SALIDA:
 #--   - a0: Puntero al final de la cadena destino
 #--   - a1: (Opcional) Nº de bits impresos
 #--------------------------------------------------

	#-- Crear la pila
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)


	#-- Guardar argumentos
	mv s0, a0  #-- Puntero a cadena destino
	mv s1, a1  #-- Numero a imprimir
	mv s2, a2  #-- Tamaño en digitos

	#------- Calcular el numero de bits a desplazar hacia la derecha
	#------ (tam - 1) * 3
	#-- s3 = tam - 1
	addi s3, s2, -1

	#-- s3 = (tam - 1) * 3
	slli t0, s3, 1  #-- * 2
	add s3, t0, s3  #-- * 3


	#-- Imprimir digito a digito
 sprint_oct_next:


	#-- Extraer el digito que toca
	srl a1, s1, s3

	#-- Imprimir el digito octal!
	jal sprint_oct3


	#-- Un digito menos por imprimir
	addi s2, s2, -1

	#-- 3 bits menos por desplazar
	addi s3, s3, -3

	#-- Hemos impreso los n bits?
	bgt s2, zero, sprint_oct_next

	#-- n bits impresos
	#-- TODO

	#-- Liberar la pila
	lw ra, 28(sp)
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	addi sp, sp, 32
	ret



.global sprint_oct3
sprint_oct3:
 #--------------------------------------------------
 #-- SPRINT_OCT3(dst, n)
 #-- Imprimir un numero octal de 3 bits
 #--
 #--  ENTRADAS:
 #--   - a0 (dst): Puntero a cadena destino
 #--   - a1 (n): Numero a imprimir
 #--  SALIDA:
 #--   - a0: Puntero al final de la cadena destino
 #--   - a1: (Opcional) Nº de bits impresos
 #--------------------------------------------------

	#-- Quedarse con los 3 bits menos significativos
	andi a1, a1, 0x07

	#-- Convertir a caracter '0'...'7'
	addi a1, a1, '0'

	#-- Almacenar caracter en cadena destino
	sb a1, 0(a0)

	#-- Incrementar puntero de cadena destino
	addi a0, a0, 1

	#-- Cadena terminada
	sb zero, 0(a0)

	li a1, 3  #-- 3 bits impresos
	ret


.global sprint_bin
sprint_bin:
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

	#-- Crear la pila
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	sw s1, 4(sp)
	sw s2, 0(sp)

	#-- Quedarse solo con los n bits de menor peso
	#-- Del numero
	#-- Calcular mascara: (1<<tam)-1  Cuando tam<32
	#--   si tam=32, la mascara es 0xFFFFFFFF
	li t0, 32
	blt a2, t0, mask1

	#-- Tamaño: 32 bits
	li t0, -1  #-- mascara 0xFFFFFFFF
	j cont

 mask1:
	#-- Tamaño < 32 bits
	li t0, 1
	sll t0, t0, a2
	addi t0, t0, -1

 cont:
	#-- Aplicar la máscara!
	and a1, a1, t0

	#-- Rotaciones a la derecha a realizar (tam-1)
	addi s1, a2, -1

	#-- Guardar agumentos
	mv s0, a1  #-- Numero a imprimir

 sprint_bin_next:

	#-- Imprimir bit que toca
	#-- Empezando por el mas significativo
	srl a1, s0, s1
	jal sprint_bin1

    #-- Una rotacion menos por hacer
	addi s1, s1, -1

	#-- Hemos impreso los n bits?
	bge s1, zero, sprint_bin_next

	addi a1, s1, 1  #-- n bits impresos

	#-- Liberar la pila
	lw ra, 12(sp)
	lw s0, 8(sp)
	lw s1, 4(sp)
	lw s2, 0(sp)
	addi sp, sp, 16
	ret


.global sprint_bin1
sprint_bin1:
 #--------------------------------------------------
 #-- SPRINT_BIN1(dst, n)
 #-- Imprimir un numero binario de 1 bit
 #--
 #--  ENTRADAS:
 #--   - a0 (dst): Puntero a cadena destino
 #--   - a1 (n): Numero a imprimir
 #--  SALIDA:
 #--   - a0: Puntero al final de la cadena destino
 #--   - a1: (Opcional) Nº de bits impresos
 #--------------------------------------------------

	#-- Quedarse con el bit 0
	andi a1, a1, BIT0

	#-- Convertir a caracter: '0' o '1'
	addi a1, a1, '0'

	#-- Almacenar caracter en cadena destino
	sb a1, 0(a0)

	#-- Incrementar puntero de cadena destino
	addi a0, a0, 1

	#-- Cadena terminada
	sb zero, 0(a0)

	li a1, 1  #-- Un bit impreso
	ret


.global sprint_unary
sprint_unary:
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


.global sprint
sprint:
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

	
	
