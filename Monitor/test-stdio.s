

	#-- Longitud maxima de las cadenas
	.eqv MAX 255

	#-- Servicios del sistema operativo del RARs
	.include "rars_so.s"

		.data
dst:	.space MAX
data8:	.word 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
data16: .word 0x0003, 0x000C, 0x0030, 0x00C0, 0x0300, 0x0C00, 0x3000, 0xC000
data32: .word 0x0000000F, 0x000000F0, 0x00000F00, 0x0000F000, 
			  0x000F0000, 0x00F00000, 0x0F000000, 0xF0000000
data_oct3: .word 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7
data_oct6: .word 0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x0F
data_oct9: .word 0x0, 0x7, 0x38, 0x1c0, 0x53, 0xd1, 0xdb, 0x1ff
data_oct12: .word 0x7, 0x38, 0x1c0, 0xe00, 0xe07, 0xe38, 0xfc0, 0xfc7

data_hex4: .word 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7
data_hex4_2: .word 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF
data_hex8: .word 0x00, 0x0A, 0xA0, 0xAA, 0xBE, 0xBA, 0xCA, 0xFE
data_hex16: .word 0x0123, 0x4567, 0x89AB, 0xCDEF, 0xBEBE, 0xCAFE, 0xBACA, 0xCACA
data_hex32: .word 0x01234567, 0x89ABCDEF, 0xCAFEBACA, 0xBEBECAFE, 
            .word 0xCAFECACA, 0xFFFFAAAA, 0xAAAA5555, 0xF0F0EFEF

#-----------
#-- MAIN
#----------- 
	.text   

	#-- Prueba de SPRINT
	jal sprint_test1

	#-- Prueba de SPRINT_UNARY
	jal sprint_test2

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 1 bit
	jal sprint_test3

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 2 bits
	jal sprint_test4

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 3 bits
	jal sprint_test5

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 4 bits
	jal sprint_test6

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 8 bits
	jal sprint_test7

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 16 bits
	jal sprint_test8

	#-- Prueba de SPRINT_BIN
	#-- Numeros binarios de 32 bits
	jal sprint_test9

	#-- Prueba de SPRINT_OCT
	#-- Numeros octales de 1 digito
	jal sprint_test10

	#-- Prueba de SPRINT_OCT
	#-- Numeros octales de 2 digitos
	jal sprint_test11

	#-- Prueba de SPRINT_OCT
	#-- Numeros octales de 3 digitos
	jal sprint_test12

	#-- Prueba de SPRINT_OCT
	#-- Numeros octales de 4 digitos
	jal sprint_test13

    #-- Prueba de SPRINT_HEX
	#-- Numeros hexadecimales de 1 digito
	jal sprint_test14

    #-- Prueba de SPRINT_HEX
	#-- Numeros hexadecimales de 2 digito
	jal sprint_test15

    #-- Prueba de SPRINT_HEX
	#-- Numeros hexadecimales de 4 digito
	jal sprint_test16

    #-- Prueba de SPRINT_HEX
	#-- Numeros hexadecimales de 8 digito
	jal sprint_test17

    #-- Prueba de SPRINT_UINT4
	#-- Numeros decimales de 4 bits
	jal sprint_test18

    #-- Prueba de SPRINT_UINT8
    #-- Numeros decimales de 8 bits
    la a0, dst
    li a1, 0xF0
    jal sprint_uint8

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- TODO
    #-- sprint_uint8
    #-- sprint_uint16
    #-- sprint_uint32

	#-- Terminar
	PRINT_CHARI('\n')
	EXIT


sprint_test18:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_UINT4
 #-- Imprimir numeros DECIMALES de 4 bits
 #------------------------------------------
 	.data
 sprint_test18_msg1:  .string "Dec: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)
    sw s0, 0(sp)

	PRINT_STRINGI("\n* TEST 18:\n")

   #-- Contador
    li s0, 0

 sprint_test18_repeat:

    la a0, dst
    la a1, sprint_test18_msg1
    jal sprint

    mv a1, s0
    jal sprint_uint4

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- Increment counter
    addi s0, s0, 1

    li t0, 16
    blt s0, t0, sprint_test18_repeat

	#-- Restaurar pila
	lw ra, 12(sp)
    lw s0, 0(sp)
	addi sp, sp, 16	
	ret



sprint_test17:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 8 digitos
 #------------------------------------------
	.data
 sprint_test17_msg1:  .string "Hex: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 17:\n")

	la a0, data_hex32
	li a1, 8
	jal test_print_block_hex

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret



sprint_test16:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 4 digitos
 #------------------------------------------
	.data
 sprint_test16_msg1:  .string "Hex: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 16:\n")

	la a0, data_hex16
	li a1, 4
	jal test_print_block_hex

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test15:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 2 digitos
 #------------------------------------------
	.data
 sprint_test15_msg1:  .string "Hex: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 15:\n")

	la a0, data_hex8
	li a1, 2
	jal test_print_block_hex

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret



sprint_test14:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 1 digito
 #------------------------------------------
	.data
 sprint_test14_msg1:  .string "Hex: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 14:\n")

	la a0, data_hex4
	li a1, 1
	jal test_print_block_hex

    la a0, data_hex4_2
	li a1, 1
	jal test_print_block_hex

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


test_print_block_hex:
 #------------------------------------------- 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir un bloque de 8 numeros HEXADECIMALES
 #-- 
 #-- ENTRADAS:
 #--   - a0: Puntero al bloque de datos
 #--   - a1: Tamaño del numero hexadecimal (en digitos)
 #-------------------------------------------
	.data
 base_hex: .string "Hex: "

	.text

	#-- Crear pila
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)

	#-- Guardar los parametros
	mv s0, a0  #-- Puntero al bloque de datos
	mv s1, a1  #-- Tamaño del numero hexa (en digitos)
	li s2, 8  #-- Contador de numeros a imprimir

 test_print_block_hex_next:
	beq s2, zero, test_print_block_hex_fin

	#-- Leer dato
	lw s3, 0(s0)

	#-- Incrementar puntero
	addi s0, s0, 4

	#-- Decrementar contador
	addi s2, s2, -1

	#----- Imprimir numero
	#-- 1: Cadena "Oct: "
	la a0, dst
	la a1, base_hex
	jal sprint

	#-- 2: Numero octal
	mv a1, s3  #-- Numero a imprimir
	mv a2, s1  #-- Tamaño en digitos
	jal sprint_hex

	#-- 3: Sacar por la consola
	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	j test_print_block_hex_next

 test_print_block_hex_fin:
	#-- Restaurar pila
	lw ra, 28(sp)
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	addi sp, sp, 32	
	ret


sprint_test13:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 4 digitos
 #------------------------------------------
	.data
 sprint_test13_msg1:  .string "Oct: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 13:\n")

	la a0, data_oct12
	li a1, 4
	jal test_print_block_octal

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test12:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 3 digitos
 #------------------------------------------
	.data
 sprint_test12_msg1:  .string "Oct: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 12:\n")

	la a0, data_oct9
	li a1, 3
	jal test_print_block_octal

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test11:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 2 digito
 #------------------------------------------
	.data
 sprint_test11_msg1:  .string "Oct: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 11:\n")

	la a0, data_oct6
	li a1, 2
	jal test_print_block_octal

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret

sprint_test10:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 1 digito
 #------------------------------------------
	.data
 sprint_test10_msg1:  .string "Oct: "
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 10:\n")

	la a0, data_oct3
	li a1, 1
	jal test_print_block_octal

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


test_print_block_octal:
 #------------------------------------------- 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir un bloque de 8 numeros OCTALES
 #-- 
 #-- ENTRADAS:
 #--   - a0: Puntero al bloque de datos
 #--   - a1: Tamaño del numero octal (en digitos)
 #-------------------------------------------
	.data
 base_oct: .string "Oct: "

	.text

	#-- Crear pila
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)

	#-- Guardar los parametros
	mv s0, a0  #-- Puntero al bloque de datos
	mv s1, a1  #-- Tamaño del numero octal (en digitos)
	li s2, 8  #-- Contador de numeros a imprimir

 test_print_block_octal_next:
	beq s2, zero, fin

	#-- Leer dato
	lw s3, 0(s0)

	#-- Incrementar puntero
	addi s0, s0, 4

	#-- Decrementar contador
	addi s2, s2, -1

	#----- Imprimir numero
	#-- 1: Cadena "Oct: "
	la a0, dst
	la a1, base_oct
	jal sprint

	#-- 2: Numero octal
	mv a1, s3  #-- Numero a imprimir
	mv a2, s1  #-- Tamaño en digitos
	jal sprint_oct

	#-- 3: Sacar por la consola
	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	j test_print_block_octal_next

 fin:
	#-- Restaurar pila
	lw ra, 28(sp)
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	addi sp, sp, 32	
	ret


sprint_test9:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 32 bits
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 9:\n")

	#-- Imprimir 8 numeros de 32 bits
	la a0, data32
	li a1, 32
	jal test_print_block_binary

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret

sprint_test8:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 16 bits
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 8:\n")

	#-- Imprimir 8 numeros de 16 bits
	la a0, data16
	li a1, 16
	jal test_print_block_binary

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test7:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 8 bits
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 7:\n")

	#-- Imprimir 8 numeros de 8 bits
	la a0, data8
	li a1, 8
	jal test_print_block_binary

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret
test_print_block_binary:
 #------------------------------------------- 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir un bloque de 8 numeros BINARIOS
 #-- 
 #-- ENTRADAS:
 #--   - a0: Puntero al bloque de datos
 #--   - a1: Tamaño del numero binario (en bits)
 #-------------------------------------------
	.data
 base_bin: .string "Bin: "

	.text

	#-- Crear pila
	addi sp, sp, -32
	sw ra, 28(sp)
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	sw s3, 12(sp)

	#-- Guardar los parametros
	mv s0, a0  #-- Puntero al bloque de datos
	mv s1, a1  #-- Tamaño del numero binario (en bits)
	li s2, 8  #-- Contador de numeros a imprimir

 test_print_block_binary_next:
	beq s2, zero, test_print_block_binary_fin

	#-- Leer dato
	lw s3, 0(s0)

	#-- Incrementar puntero
	addi s0, s0, 4

	#-- Decrementar contador
	addi s2, s2, -1

	#----- Imprimir numero
	#-- 1: Cadena "Bin: "
	la a0, dst
	la a1, base_bin
	jal sprint

	#-- 2: Numero binario
	mv a1, s3  #-- Numero a imprimir
	mv a2, s1  #-- Tamaño en bits
	jal sprint_bin

	#-- 3: Sacar por la consola
	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	j test_print_block_binary_next

 test_print_block_binary_fin:
	#-- Restaurar pila
	lw ra, 28(sp)
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	lw s3, 12(sp)
	addi sp, sp, 32	
	ret


sprint_test6:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 4 bits
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 6:\n")

	#-- Imprimir 16 numeros de 4 bits
	li a0, 16
	li a1, 4
	jal test_bin1

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test5:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 3 bits
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 5:\n")

	#-- Imprimir 8 numeros de 3 bits
	li a0, 8
	li a1, 3
	jal test_bin1

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test4:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 2 bits
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 4:\n")

	#-- Imprimir 4 numeros de 2 bits
	li a0, 4
	li a1, 2
	jal test_bin1

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


sprint_test3:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 1 bit
 #------------------------------------------
	.text

	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)

	PRINT_STRINGI("\n* TEST 3:\n")

	#-- Imprimir 2 numeros de 1 bit
	li a0, 2
	li a1, 1
	jal test_bin1

	#-- Restaurar pila
	lw ra, 12(sp)
	addi sp, sp, 16	
	ret


test_bin1:
 #-----------------------------------------------------
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros en binario desde 0 
 #--   hasta el valor maximo indicado (max)
 #--
 #-- ENTRADAS:
 #--   - a0: Valor maximo a imprimir
 #--   - a1: Tamaño en bits de los numeros a imprimir
 #-----------------------------------------------------
	.data
 test_bin1_msg: .string "Bin: "	

	.text

 	#-- Crear pila
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	sw a1, 4(sp)
	sw a2, 0(sp)
	
	#-- Contador de numeros
	li s0, 0

	#-- Valor maximo del numero a mostrar
	mv s1, a0

	#-- Tamaño en bits
	mv s2, a1

 test_bin1_next:	
	#-- Imprimir mensaje
	la a0, dst
	la a1, test_bin1_msg
	jal sprint

	#-- Imprimir el numero binario
	mv a1, s0
	mv a2, s2
	jal sprint_bin

	#-- Imprimir la cadena resultante
	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')

	#-- Siguiente numero
	addi s0, s0, 1

	#-- Hemos alcanzado el maximo?
    blt s0, s1, test_bin1_next

	#-- Restaurar pila
	lw ra, 12(sp)
	lw s0, 8(sp)
	lw s1, 4(sp)
	lw s2, 0(sp)
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

	
	
