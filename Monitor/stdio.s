

	#-- Longitud maxima de las cadenas
	.eqv MAX 255

	#-- Mascaras para BITs
	.eqv BIT0 0x01

	#-- Servicios del sistema operativo del RARs
	.include "rars_so.s"

		.data
dst:	.space MAX

#-----------
#-- MAIN
#----------- 
	.text   

	#-- Prueba de SPRINT
	jal sprint_test1

	#-- Prueba de SPRINT_UNARY
	jal sprint_test2

	#-- Prueba de SPRINT_BIN1
	jal sprint_test3

	#-- Prueba de SPRINT_BIN2
	jal sprint_test4


	#-- TODO: 
	#-- sprint_bin3
	#-- sprint_bin4
	#-- sprint_bin8
	#-- sprint_bin16
	#-- sprint_bin32

	#-- Terminar
	PRINT_CHARI('\n')
	EXIT
	
sprint_test4:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN2
 #-- Imprimiendo numeros binarios de 2 bits
 #------------------------------------------
	.data
 test4_msg1: .string "Binario: "	

	.eqv MAX_BIN2 4

	.text
	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	PRINT_STRINGI("\n* TEST 4:\n")
	li s0, 0  #-- Numero a imprimir

  sprint_test4_next:	
	#-- Imprimir mensaje
	la a0, dst
	la a1, test4_msg1
	jal sprint

	#-- Imprimir el numero binario
	mv a1, s0
	jal sprint_bin2

	#-- Imprimir la cadena resultante
	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	#-- Siguiente numero
	addi s0, s0, 1

	#-- Hemos alcanzado el maximo?
	li t1, MAX_BIN2
    blt s0, t1, sprint_test4_next

	#-- Restaurar pila
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16	
	ret

sprint_test3:
 #--------------------------------------
 #-- Pruebas para SPRINT_BIN1
 #-- Imprimiendo numeros binarios de 1 bit
 #--------------------------------------
	.data
 test3_msg1: .string "Bit: "

	.eqv MAX_BIN1 2

	.text
	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)

	PRINT_STRINGI("\n* TEST 3:\n")
    
	li s0, 0  #-- Numero a imprimir

  sprint_test3_next:

	#-- Imprimir mensaje
	la a0, dst
	la a1, test3_msg1
	jal sprint

	mv a1, s0
	jal sprint_bin1

	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	#-- Siguiente numero
	addi s0, s0, 1

	#-- Hemos alcanzado el maximo?
	li t1, MAX_BIN1
    blt s0, t1, sprint_test3_next

	#-- Restaurar pila
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16	
	ret

sprint_test2:
 #--------------------------------------
 #-- Pruebas para SPRINT_UNARY
 #-- Imprimiendo numeros en unario
 #--------------------------------------
	.data
 test2_msg1: .string "Unario: "

	#-- Numero maximo de unarios a imprimir
	.eqv MAX_UNARY 5

	.text
	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)

	PRINT_STRINGI("\n* TEST 2:\n")

	#-- Inicializar contador de unarios
	li s0, 0

 sprint_test2_next:
	#-- Imprimir cadena
	la a0, dst  #-- Puntero a cadena destino
	la a1, test2_msg1
	jal sprint

	#-- Imprimir un numero en unario
	mv a1, s0  #-- Numero a imprimir
	li a2, '1'  #-- Marca a usar
	jal sprint_unary
	
	#-- Imprimir cadena resultante
	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	li t0, MAX_UNARY
    beq s0, t0, sprint_test2_fin

	#-- Incrementar numero unario
	addi s0, s0, 1
	j sprint_test2_next

 sprint_test2_fin:	

	#-- Restaurar pila
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16

	#-- Terminar
	ret

sprint_test1:
 #--------------------------------------
 #-- Prueba para SPRINTS
 #-- Imprimiendo cadenas
 #--------------------------------------
	.data
 test1_msg1:	.string "Holi!"
 test1_msg2:   .string "Manoli!"
 test1_msg3:   .string "--->ok!\n"

	.text	

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("* TEST 1:\n")

	#-- Copiar msg1 en dst
	la a0, dst
	la a1, test1_msg1
	jal sprint

	#-- Cadena 2
	la a1, test1_msg2
	jal sprint
	
	#-- Cadena 3
	la a1, test1_msg3
	jal sprint

	#-- Imprimir la cadena creada
	PRINT_STRINGL(dst)

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16

	#-- Terminar
	ret

sprint_bin2:
 #--------------------------------------------------
 #-- SPRINT_BIN2(dst, n)
 #-- Imprimir un numero binario de 2 bits
 #--
 #--  ENTRADAS:
 #--   - a0 (dst): Puntero a cadena destino
 #--   - a1 (n): Numero a imprimir
 #--  SALIDA:
 #--   - a0: Puntero al final de la cadena destino
 #--   - a1: (Opcional) Nº de bits impresos
 #--------------------------------------------------

	#-- Crear la pila
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)

	#-- Quedarse solo con los 2 bits de menor peso
	#-- Del numero
	andi a1, a1, 0x03

	#-- Guardar agumentos
	mv s0, a1  #-- Numero a imprimir

	#-- Imprimir bit 1
	srli a1, s0, 1
	jal sprint_bin1

	#-- Imprimir bit 0
	mv a1, s0
	jal sprint_bin1

	li a1, 2  #-- Dos bits impresos

	#-- Liberar la pila
	lw ra, 12(sp)
	lw s0, 8(sp)
	addi sp, sp, 16
	ret

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

	
	
