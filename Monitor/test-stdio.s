

	#-- Longitud maxima de las cadenas
	.eqv MAX 255

	#-- Servicios del sistema operativo del RARs
	.include "rars_so.h"

    #-- Macros para funciones y pila
    .include "stack.h"

	#-- Valores para el parametro ini0
	.eqv CON_0s_INICIALES 1
	.eqv SIN_0s_INICIALES 0

#-----------------------------------------------------------------------
#--- MACROS
#-----------------------------------------------------------------------

#---------------------------------------
#-- Imprimir el titulo de testo
#---------------------------------------
.macro TEST_TITTLE(%test_tittle)
	.data
 tittle: .string %test_tittle

	.text
	la a0, tittle
	jal puts
.end_macro

#----------------------------------------
#-- Imprimir el mensaje del test actual 
#-- "TEST %test_num...."
#----------------------------------------
.macro TEST_NAME(%test_num)
   .data
 test_name: .ascii "> TEST "
            .ascii %test_num
			.string "...."
   .text
       la a0, test_name
	   jal puts 
.end_macro

#-------------------------------------------
#-- Llamar a la funcion sprint(dst, cad)
#-------------------------------------------
.macro SPRINT(%dst, %str)
	.data
 cad: %str

	.text
	la a0, %dst
	la a1, cad
	jal sprint
.end_macro

#-----------------------------------------------------
#-- Llamar a la funcion sprint(cad)
#-- No se pasa el buffer. Se toma del registro a0
#-----------------------------------------------------
.macro SPRINT(%str)

	.data
 cad: %str

	.text
	la a1, cad
	jal sprint
.end_macro

#-----------------------------------------
#-- Llamar a la funcion sprint(dst, car)
#-----------------------------------------
.macro SPRINT_CHAR(%dst, %car)
	la a0, %dst
	li a1, %car
	jal sprint_char
.end_macro

#-----------------------------------------
#-- Llamar a la funcion sprint(car)
#-- No se pasa el buffer
#-----------------------------------------
.macro SPRINT_CHAR(%car)
	li a1, %car
	jal sprint_char
.end_macro

#---------------------------------------------------------
#-- Llamar a la funcion sprint_unary(buffer, num, mark)
#---------------------------------------------------------
.macro SPRINT_UNARY(%buffer, %num, %mark)
	la a0, %buffer
	li a1, %num    #-- Una marca
	li a2, %mark   #-- Marca a utilizar
	jal sprint_unary
.end_macro

#---------------------------------------------------------
#-- Llamar a la funcion sprint_unary(num, mark)
#---------------------------------------------------------
.macro SPRINT_UNARY(%num, %mark)
	li a1, %num    #-- Una marca
	li a2, %mark   #-- Marca a utilizar
	jal sprint_unary
.end_macro

#-----------------------------------------
#-- Comparar que dos cadenas son iguales
#-- La cadena izquierda es una etiqueta
#-- La cadena derecha es un literal
#-----------------------------------------
.macro ASSERT_STR_EQUAL(%buffer, %str)
	.data
 result: .string %str

	.text
	la a0, %buffer
	la a1, result
	jal assert_str_equal
.end_macro




		.data
buffer: .space MAX
buff:   .space 8
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
data_dec8:  .word 0, 1, 10, 100, 123, 200, 250, 255 
data_dec16: .word 0, 1, 10, 100, 1000, 10000, 50000, 0xFFFF
data_dec32: .word 0, 1, 10, 0xFFFF, 0xFFFFF, 0xFFFFFF, 0xFFFFFFF, 0xFFFFFFFF
data_bcd1:  .word 0, 0x1, 0x12, 0x123, 0x1234, 0x12345, 0x123456, 0x12345678

#-----------
#-- MAIN
#----------- 
	.text   

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
    jal sprint_test19

    #-- Prueba de SPRINT_UINT16
    #-- Numeros decimales de 16 bits
    jal sprint_test20

    #-- Prueba de SPRINT_UINT32
    #-- Numeros decimales de 32 bits
    jal sprint_test21

    #-- Prueba de SPRINT_BCD
    jal sprint_test22

    #-- Prueba de SPRINT_BCD
    jal sprint_test23

	#-- Prueba de store_bcd()
	la a0, buff
	li a1, 0x0000
	li a2, 4
	jal store_bcd

	li a1, 0x0
	li a2, 4
	jal store_bcd

	#-- Prueba de sprint_bcd_from_mem
	la a0, dst
	la a1, buff
	li a2, 8
	li a3, 1  #-- Ceros iniciales
	jal sprint_bcd_from_mem

	PRINT_STRINGL(dst)
	PRINT_CHARI('\n')


	#-----------------------------
	#-- TESTS UNITARIOS
	#-----------------------------
	jal unittest_sprint
	jal unittest_sprint_char
	jal unittest_sprint_unary
	jal unittest_sprint_bcd_digit
	jal unittest_bcd_copy
	jal unittest_sprint_bin


	#-- Terminar
	PRINT_CHARI('\n')
	EXIT




sprint_test23:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BCD
 #------------------------------------------
 	.data
 sprint_test23_msg1:  .string "Bcd: "
	.text

    STACK16
    PUSH3(s0, s1, s2)
	PRINT_STRINGI("\n* TEST 23:\n")

    #-- Puntero a datos
    la s0, data_bcd1

    #-- Cantidad de datos a mostrar
    li s1, 8

    #-- Puntero a cadena destino
    la s2, dst

 sprint_test23_repeat:

    mv a0, s2
    la a1, sprint_test23_msg1
    jal sprint

    #-- Leer dato e imprimirlo
    lw a1, 0(s0)
    li a2, 8  #-- Numero de digitos
    li a3, 0  #-- Ceros iniciales
    jal sprint_bcd

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- Apuntar al siguiente dato
    addi s0, s0, 4

    #-- Decrementar contador
    addi s1, s1, -1

    #-- Repetir mientras queden datos
    bgt s1, zero, sprint_test23_repeat

	#-- Restaurar pila
    POP3(s0, s1, s2)
    UNSTACK16



sprint_test22:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BCD
 #------------------------------------------
 	.data
 sprint_test22_msg1:  .string "Bcd: "
	.text

    STACK16
    PUSH3(s0, s1, s2)
	PRINT_STRINGI("\n* TEST 22:\n")

    #-- Puntero a datos
    la s0, data_bcd1

    #-- Cantidad de datos a mostrar
    li s1, 8

    #-- Puntero a cadena destino
    la s2, dst

 sprint_test22_repeat:

    mv a0, s2
    la a1, sprint_test22_msg1
    jal sprint

    #-- Leer dato e imprimirlo
    lw a1, 0(s0)
    li a2, 8  #-- Numero de digitos
    li a3, 1  #-- Ceros iniciales
    jal sprint_bcd

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- Apuntar al siguiente dato
    addi s0, s0, 4

    #-- Decrementar contador
    addi s1, s1, -1

    #-- Repetir mientras queden datos
    bgt s1, zero, sprint_test22_repeat


	#-- Restaurar pila
    POP3(s0, s1, s2)
    UNSTACK16



sprint_test21:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_UINT32
 #-- Imprimir numeros DECIMALES de 32 bits
 #------------------------------------------
 	.data
 sprint_test21_msg1:  .string "Dec: "
	.text

    STACK16
    PUSH3(s0, s1, s2)
	PRINT_STRINGI("\n* TEST 21:\n")

    #-- Puntero a datos
    la s0, data_dec32

    #-- Cantidad de datos a mostrar
    li s1, 8

    #-- Puntero a cadena destino
    la s2, dst

 sprint_test21_repeat:

    mv a0, s2
    la a1, sprint_test21_msg1
    jal sprint

    #-- Leer dato e imprimirlo
    lw a1, 0(s0)
    jal sprint_uint32

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- Apuntar al siguiente dato
    addi s0, s0, 4

    #-- Decrementar contador
    addi s1, s1, -1

    #-- Repetir mientras queden datos
    bgt s1, zero, sprint_test21_repeat


	#-- Restaurar pila
    POP3(s0, s1, s2)
    UNSTACK16



sprint_test20:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_UINT16
 #-- Imprimir numeros DECIMALES de 16 bits
 #------------------------------------------
 	.data
 sprint_test20_msg1:  .string "Dec: "
	.text

    STACK16
    PUSH3(s0, s1, s2)
	PRINT_STRINGI("\n* TEST 20:\n")

    #-- Puntero a datos
    la s0, data_dec16

    #-- Cantidad de datos a mostrar
    li s1, 8

    #-- Puntero a cadena destino
    la s2, dst

 sprint_test20_repeat:

    mv a0, s2
    la a1, sprint_test20_msg1
    jal sprint

    #-- Leer dato e imprimirlo
    lw a1, 0(s0)
    jal sprint_uint16

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- Apuntar al siguiente dato
    addi s0, s0, 4

    #-- Decrementar contador
    addi s1, s1, -1

    #-- Repetir mientras queden datos
    bgt s1, zero, sprint_test20_repeat


	#-- Restaurar pila
    POP3(s0, s1, s2)
    UNSTACK16



sprint_test19:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_UINT8
 #-- Imprimir numeros DECIMALES de 8 bits
 #------------------------------------------
 	.data
 sprint_test19_msg1:  .string "Dec: "
	.text

    STACK16
    PUSH3(s0, s1, s2)
	PRINT_STRINGI("\n* TEST 19:\n")

    #-- Puntero a datos
    la s0, data_dec8

    #-- Cantidad de datos a mostrar
    li s1, 8

    #-- Puntero a cadena destino
    la s2, dst

 sprint_test19_repeat:

    mv a0, s2
    la a1, sprint_test19_msg1
    jal sprint

    #-- Leer dato e imprimirlo
    lw a1, 0(s0)
    jal sprint_uint8

    PRINT_STRINGL(dst)
    PRINT_CHARI('\n')

    #-- Apuntar al siguiente dato
    addi s0, s0, 4

    #-- Decrementar contador
    addi s1, s1, -1

    #-- Repetir mientras queden datos
    bgt s1, zero, sprint_test19_repeat


	#-- Restaurar pila
    POP3(s0, s1, s2)
    UNSTACK16
 



sprint_test18:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_UINT4
 #-- Imprimir numeros DECIMALES de 4 bits
 #------------------------------------------
 	.data
 sprint_test18_msg1:  .string "Dec: "
	.text

	#-- Crear pila
    STACK16
    PUSH1(s0)
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
    POP1(s0)
    UNSTACK16


sprint_test17:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 8 digitos
 #------------------------------------------
	.data
 sprint_test17_msg1:  .string "Hex: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 17:\n")

	la a0, data_hex32
	li a1, 8
	jal test_print_block_hex

	#-- Restaurar pila
    UNSTACK16


sprint_test16:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 4 digitos
 #------------------------------------------
	.data
 sprint_test16_msg1:  .string "Hex: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 16:\n")

	la a0, data_hex16
	li a1, 4
	jal test_print_block_hex

	#-- Restaurar pila
    UNSTACK16


sprint_test15:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 2 digitos
 #------------------------------------------
	.data
 sprint_test15_msg1:  .string "Hex: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 15:\n")

	la a0, data_hex8
	li a1, 2
	jal test_print_block_hex

	#-- Restaurar pila
    UNSTACK16



sprint_test14:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_HEX
 #-- Imprimir numeros HEXADECIMALES de 1 digito
 #------------------------------------------
	.data
 sprint_test14_msg1:  .string "Hex: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 14:\n")

	la a0, data_hex4
	li a1, 1
	jal test_print_block_hex

    la a0, data_hex4_2
	li a1, 1
	jal test_print_block_hex

	#-- Restaurar pila
    UNSTACK16


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

    STACK32
    STACK32_PUSH4(s0, s1, s2, s3)

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
    STACK32_POP4(s0, s1, s2, s3)
    UNSTACK32



sprint_test13:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 4 digitos
 #------------------------------------------
	.data
 sprint_test13_msg1:  .string "Oct: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 13:\n")

	la a0, data_oct12
	li a1, 4
	jal test_print_block_octal

	#-- Restaurar pila
    UNSTACK16


sprint_test12:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 3 digitos
 #------------------------------------------
	.data
 sprint_test12_msg1:  .string "Oct: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 12:\n")

	la a0, data_oct9
	li a1, 3
	jal test_print_block_octal

	#-- Restaurar pila
    UNSTACK16


sprint_test11:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 2 digito
 #------------------------------------------
	.data
 sprint_test11_msg1:  .string "Oct: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 11:\n")

	la a0, data_oct6
	li a1, 2
	jal test_print_block_octal

    UNSTACK16

sprint_test10:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_OCT
 #-- Imprimir numeros OCTALES de 1 digito
 #------------------------------------------
	.data
 sprint_test10_msg1:  .string "Oct: "
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 10:\n")

	la a0, data_oct3
	li a1, 1
	jal test_print_block_octal

	#-- Restaurar pila
    UNSTACK16


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

    STACK32
    STACK32_PUSH4(s0, s1, s2, s3)

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
    STACK32_POP4(s0, s1, s2, s3)
    UNSTACK32


sprint_test9:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 32 bits
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 9:\n")

	#-- Imprimir 8 numeros de 32 bits
	la a0, data32
	li a1, 32
	jal test_print_block_binary

    UNSTACK16

sprint_test8:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 16 bits
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 8:\n")

	#-- Imprimir 8 numeros de 16 bits
	la a0, data16
	li a1, 16
	jal test_print_block_binary

	#-- Restaurar pila
    UNSTACK16


sprint_test7:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 8 bits
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 7:\n")

	#-- Imprimir 8 numeros de 8 bits
	la a0, data8
	li a1, 8
	jal test_print_block_binary

	#-- Restaurar pila
    UNSTACK16

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

    STACK32
    STACK32_PUSH4(s0, s1, s2, s3)

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
    STACK32_POP4(s0, s1, s2, s3)
    UNSTACK32


sprint_test6:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 4 bits
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 6:\n")

	#-- Imprimir 16 numeros de 4 bits
	li a0, 16
	li a1, 4
	jal test_bin1

	#-- Restaurar pila
    UNSTACK16


sprint_test5:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 3 bits
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 5:\n")

	#-- Imprimir 8 numeros de 3 bits
	li a0, 8
	li a1, 3
	jal test_bin1

	#-- Restaurar pila
    UNSTACK16

sprint_test4:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 2 bits
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 4:\n")

	#-- Imprimir 4 numeros de 2 bits
	li a0, 4
	li a1, 2
	jal test_bin1

	#-- Restaurar pila
    UNSTACK16


sprint_test3:
 #------------------------------------------ 
 #-- Pruebas para SPRINT_BIN
 #-- Imprimir numeros BINARIOS de 1 bit
 #------------------------------------------
	.text

    STACK16
	PRINT_STRINGI("\n* TEST 3:\n")

	#-- Imprimir 2 numeros de 1 bit
	li a0, 2
	li a1, 1
	jal test_bin1

	#-- Restaurar pila
    UNSTACK16

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
	STACK16
    PUSH3(s0, s1, s2)
	
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
	POP3(s0, s1, s2)
    UNSTACK16

#------------------------------------------
#-- Pruebas unitarias de sprint_bin
#-- TEST31-
#------------------------------------------
unittest_sprint_bin:
	.data
 test31_tittle:  .string "----- SPRINT_BIN() ------\n"
 test31_name:    .string "> TEST 31...."
 test31_result:  .string "0"
 test32_name:    .string "> TEST 32...."
 test32_result:  .string "1"
 test33_name:    .string "> TEST 33...."
 test33_result:  .string "00"
 test34_name:    .string "> TEST 34...."
 test34_result:  .string "01"
 test35_name:    .string "> TEST 35...."
 test35_result:  .string "10"
 test36_name:    .string "> TEST 36...."
 test36_result:  .string "11"
 test37_name:    .string "> TEST 37...."
 test37_result:  .string "000"
 test38_name:    .string "> TEST 38...."
 test38_result:  .string "001"
 test39_name:    .string "> TEST 39...."
 test39_result:  .string "010"
 test40_name:    .string "> TEST 40...."
 test40_result:  .string "101"
 test41_name:    .string "> TEST 41...."
 test41_result:  .string "111"
 test42_name:    .string "> TEST 42...."
 test42_result:  .string "0000"
 test43_name:    .string "> TEST 43...."
 test43_result:  .string "0001"
 test44_name:    .string "> TEST 44...."
 test44_result:  .string "0101"
 test45_name:    .string "> TEST 45...."
 test45_result:  .string "1010"
 test46_name:    .string "> TEST 46...."
 test46_result:  .string "1111"
 test47_name:    .string "> TEST 47...."
 test47_result:  .string "00000000"
 test48_name:    .string "> TEST 48...."
 test48_result:  .string "00000001"
 test49_name:    .string "> TEST 49...."
 test49_result:  .string "01010101"
 test50_name:    .string "> TEST 50...."
 test50_result:  .string "10101010"
 test51_name:    .string "> TEST 51...."
 test51_result:  .string "0000000000000000"
 test52_name:    .string "> TEST 52...."
 test52_result:  .string "0000000000000001"
 test53_name:    .string "> TEST 53...."
 test53_result:  .string "0101010101010101"
 test54_name:    .string "> TEST 54...."
 test54_result:  .string "1010101010101010"
 test55_name:    .string "> TEST 55...."
 test55_result:  .string "1111111111111111"
 test56_name:    .string "> TEST 56...."
 test56_result:  .string "00000000000000000000000000000000" 
 test57_name:    .string "> TEST 57...."
 test57_result:  .string "00000000000000000000000000000001"
 test58_name:    .string "> TEST 58...."
 test58_result:  .string "00000000000000001111111111111111"
 test59_name:    .string "> TEST 59...."
 test59_result:  .string "01010101010101010101010101010101"
 test60_name:    .string "> TEST 60...."
 test60_result:  .string "10101010101010101010101010101010"
 test61_name:    .string "> TEST 61...."
 test61_result:  .string "11111111111111111111111111111111"     
 
 .macro TEST_NAME(%test_num)
   .data
 test_name: .ascii "> TEST "
            .ascii %test_num
			.string "...."
   .text
       la a0, test_name
	   jal puts 
 .end_macro

 .macro TEST_BIN(%NTEST)
	.data
test_name:   .string "> TEST %NTEST"
test_result: .string "0000"
	.text
	#--------  41. Imprimir binario "111"
	la a0, test_name
	jal puts

	#-- sprint_bin(buffer, 7, 3, CON_0s)
	la a0, buffer
	li a1, 7  #-- Numero binario
	li a2, 3  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "111"
	la a0, buffer
	la a1, test_result
	jal assert_str_equal
.end_macro

	.text
	STACK16

	#--- Imprimir titulo
	la a0, test31_tittle
	jal puts

	#--------  31. Imprimir bit 0
	la a0, test31_name
	jal puts

	#-- sprint_bin(buffer, 0)
	la a0, buffer
	li a1, 0  #-- Numero binario
	li a2, 1  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "0"
	la a0, buffer
	la a1, test31_result
	jal assert_str_equal

	#--------  32. Imprimir bit 1
	la a0, test32_name
	jal puts

	#-- sprint_bin(buffer, 1)
	la a0, buffer
	li a1, 1  #-- Numero binario
	li a2, 1  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "1"
	la a0, buffer
	la a1, test32_result
	jal assert_str_equal

	#--------  33. Imprimir binario "00"
	la a0, test33_name
	jal puts

	#-- sprint_bin(buffer, 0, 2, CON_0s)
	la a0, buffer
	li a1, 0  #-- Numero binario
	li a2, 2  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "00"
	la a0, buffer
	la a1, test33_result
	jal assert_str_equal

	#--------  34. Imprimir binario "01"
	la a0, test34_name
	jal puts

	#-- sprint_bin(buffer, 1, 2, CON_0s)
	la a0, buffer
	li a1, 1  #-- Numero binario
	li a2, 2  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "01"
	la a0, buffer
	la a1, test34_result
	jal assert_str_equal

	#--------  35. Imprimir binario "10"
	la a0, test35_name
	jal puts

	#-- sprint_bin(buffer, 2, 2, CON_0s)
	la a0, buffer
	li a1, 2  #-- Numero binario
	li a2, 2  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "10"
	la a0, buffer
	la a1, test35_result
	jal assert_str_equal

	#--------  36. Imprimir binario "11"
	la a0, test36_name
	jal puts

	#-- sprint_bin(buffer, 3, 2, CON_0s)
	la a0, buffer
	li a1, 3  #-- Numero binario
	li a2, 2  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "11"
	la a0, buffer
	la a1, test36_result
	jal assert_str_equal

	#--------  37. Imprimir binario "000"
	la a0, test37_name
	jal puts

	#-- sprint_bin(buffer, 0, 3, CON_0s)
	la a0, buffer
	li a1, 0  #-- Numero binario
	li a2, 3  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "000"
	la a0, buffer
	la a1, test37_result
	jal assert_str_equal

	#--------  38. Imprimir binario "001"
	la a0, test38_name
	jal puts

	#-- sprint_bin(buffer, 1, 3, CON_0s)
	la a0, buffer
	li a1, 1  #-- Numero binario
	li a2, 3  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "001"
	la a0, buffer
	la a1, test38_result
	jal assert_str_equal

	#--------  39. Imprimir binario "010"
	la a0, test39_name
	jal puts

	#-- sprint_bin(buffer, 2, 3, CON_0s)
	la a0, buffer
	li a1, 2  #-- Numero binario
	li a2, 3  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "010"
	la a0, buffer
	la a1, test39_result
	jal assert_str_equal

	#--------  40. Imprimir binario "101"
	la a0, test40_name
	jal puts

	#-- sprint_bin(buffer, 5, 3, CON_0s)
	la a0, buffer
	li a1, 5  #-- Numero binario
	li a2, 3  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "101"
	la a0, buffer
	la a1, test40_result
	jal assert_str_equal

	#--------  41. Imprimir binario "111"
	la a0, test41_name
	jal puts

	#-- sprint_bin(buffer, 7, 3, CON_0s)
	la a0, buffer
	li a1, 7  #-- Numero binario
	li a2, 3  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "111"
	la a0, buffer
	la a1, test41_result
	jal assert_str_equal

	#--------  42. Imprimir binario "0000"
	TEST_NAME("42")

	#-- sprint_bin(buffer, 0, 4, CON_0s)
	la a0, buffer
	li a1, 0  #-- Numero binario
	li a2, 4  #-- Tamaño en bits
	li a3, CON_0s_INICIALES
	jal sprint_bin

	#-- assert buffer == "0000"
	la a0, buffer
	la a1, test42_result
	jal assert_str_equal


	UNSTACK16

 #test42_name:    .string "> TEST 42...."
 #test42_result:  .string "0000"
 #test43_name:    .string "> TEST 43...."
 #test43_result:  .string "0001"
 #test44_name:    .string "> TEST 44...."
 #test44_result:  .string "0101"
 #test45_name:    .string "> TEST 45...."
 #test45_result:  .string "1010"
 #test46_name:    .string "> TEST 46...."
 #test46_result:  .string "1111"
 #test47_name:    .string "> TEST 47...."
 #test47_result:  .string "00000000"
 #test48_name:    .string "> TEST 48...."
 #test48_result:  .string "00000001"
 #test49_name:    .string "> TEST 49...."
 #test49_result:  .string "01010101"
 #test50_name:    .string "> TEST 50...."
 #test50_result:  .string "10101010"
 #test51_name:    .string "> TEST 51...."
 #test51_result:  .string "0000000000000000"
 #test52_name:    .string "> TEST 52...."
 #test52_result:  .string "0000000000000001"
 #test53_name:    .string "> TEST 53...."
 #test53_result:  .string "0101010101010101"
 #test54_name:    .string "> TEST 54...."
 #test54_result:  .string "1010101010101010"
 #test55_name:    .string "> TEST 55...."
 #test55_result:  .string "1111111111111111"
 #test56_name:    .string "> TEST 56...."
 #test56_result:  .string "00000000000000000000000000000000" 
 #test57_name:    .string "> TEST 57...."
 #test57_result:  .string "00000000000000000000000000000001"
 #test58_name:    .string "> TEST 58...."
 #test58_result:  .string "00000000000000001111111111111111"
 #test59_name:    .string "> TEST 59...."
 #test59_result:  .string "01010101010101010101010101010101"
 #test60_name:    .string "> TEST 60...."
 #test60_result:  .string "10101010101010101010101010101010"
 #test61_name:    .string "> TEST 61...."
 #test61_result:  .string "11111111111111111111111111111111"     
 



#------------------------------------------
#-- Pruebas unitarias de bcd_copy
#-- TEST22-30
#------------------------------------------
unittest_bcd_copy:

	.data
 test22_tittle:  .string "----- BCD_COPY() ------\n"
 test22_name:    .string "> TEST 22...."
 test22_bcd:     .byte 0
 test22_result:  .string "0"
 test23_name:    .string "> TEST 23...."
 test23_bcd:     .byte 0, 1
 test23_result:  .string "01"
 test24_name:    .string "> TEST 24...."
 test24_bcd:     .byte 0, 0, 2
 test24_result:  .string "002"
 test25_name:    .string "> TEST 25...."
 test25_bcd:     .byte 0, 1, 2, 3, 4, 5, 6, 7
				 .byte 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF
 test25_result:  .string "0123456789ABCDEF"
 test26_name:    .string "> TEST 26...."
 test26_bcd:     .byte 0
 test26_result:  .string "0"
 test27_name:    .string "> TEST 27...."
 test27_bcd:     .byte 0, 2
 test27_result:  .string "2"
 test28_name:    .string "> TEST 28...."
 test28_bcd:     .byte 0, 0, 3
 test28_result:  .string "3"
 test29_name:    .string "> TEST 29...."
 test29_bcd:     .byte 0, 0, 0, 0, 0xB, 0xA, 0xC, 0xA
 test29_result:  .string "BACA"
 test30_name:    .string "> TEST 30...."
 test30_bcd:     .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 test30_result:  .string "0"

	.text
	STACK16

	#--- Imprimir titulo
	la a0, test22_tittle
	jal puts

	#--------  22. Imprimir un digito bcd
	la a0, test22_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 1)
	la a0, buffer  #-- Cadena destino
	la a1, test22_bcd   #-- Buffer bcd
	li a2, 1            #-- Un digito
	li a3, CON_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "0"
	la a0, buffer
	la a1, test22_result
	jal assert_str_equal

	#-------- 23. Imprimir dos digitos bcd
	la a0, test23_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 2)
	la a0, buffer
	la a1, test23_bcd
	li a2, 2
	li a3, CON_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "01"
	la a0, buffer
	la a1, test23_result
	jal assert_str_equal

	#-------- 24. Imprimir tres digitos bcd
	la a0, test24_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 2)
	la a0, buffer
	la a1, test24_bcd
	li a2, 3
	li a3, CON_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "002"
	la a0, buffer
	la a1, test24_result
	jal assert_str_equal

	#--------- 25. Imprimir 16 digitos bcd
	la a0, test25_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 16)
	la a0, buffer
	la a1, test25_bcd
	li a2, 16
	li a3, CON_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "0123456789ABCDEF"
	la a0, buffer
	la a1, test25_result
	jal assert_str_equal

	#--------- 26. Imprimir un '0' sin ceros iniciales
	#------------  Caso especial
	la a0, test26_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 1)
	la a0, buffer
	la a1, test26_bcd
	li a2, 1
	li a3, SIN_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "0"
	la a0, buffer
	la a1, test26_result
	jal assert_str_equal

	#--------- 27. Imprimir un digito con  1 cero iniciales
	la a0, test27_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 2)
	la a0, buffer
	la a1, test27_bcd
	li a2, 2
	li a3, SIN_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "2"
	la a0, buffer
	la a1, test27_result
	jal assert_str_equal

	#--------- 28. Imprimir un digito con 2 ceros iniciales
	la a0, test28_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 3)
	la a0, buffer
	la a1, test28_bcd
	li a2, 3
	li a3, SIN_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "3"
	la a0, buffer
	la a1, test28_result
	jal assert_str_equal

	#--------- 29. Imprimir un numero con muchos ceros iniciales
	la a0, test29_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 8)
	la a0, buffer
	la a1, test29_bcd
	li a2, 8
	li a3, SIN_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "BACA"
	la a0, buffer
	la a1, test29_result
	jal assert_str_equal

	#--------- 30. Imprimir un numero con muchos ceros
	la a0, test30_name
	jal puts

	#-- bcd_copy(buffer, buffer_bcd, 10)
	la a0, buffer
	la a1, test30_bcd
	li a2, 10
	li a3, SIN_0s_INICIALES
	jal bcd_copy

	#-- assert buffer == "0"
	la a0, buffer
	la a1, test30_result
	jal assert_str_equal

	UNSTACK16


#------------------------------------------
#-- Pruebas unitarias de sprint_bcd_digit
#-- TEST14-TEST21
#------------------------------------------
unittest_sprint_bcd_digit:

	.data
 test14_tittle:  .string "----- SPRINT_BCD_DIGIT()-----\n"
 test14_name:    .string "> TEST 14...."
 test14_result1: .string "0"
 test15_name:    .string "> TEST 15...."
 test15_result2: .string "1"
 test16_name:    .string "> TEST 16...."
 test16_result3: .string "01234567"
 test17_name:    .string "> TEST 17...."
 test17_result4: .string "0123456789"
 test18_name:    .string "> TEST 18...."
 test18_result5: .string "0123456789ABCDEF"
 test19_name:    .string "> TEST 19...."
 test19_cad:     .string "Bit: "
 test19_result6: .string "Bit: 0"
 test20_name:    .string "> TEST 20...."
 test20_cad:     .string "Bin: "
 test20_result6: .string "Bin: 10"
 test21_name:    .string "> TEST 21...."
 test21_cad1:    .string "Digito: "
 test21_cad2:    .string "-----\n"
 test21_result7: .string "Digito: 9-----\n"
 
	.text
	STACK16

	#--- Imprimir titulo
	la a0, test14_tittle
	jal puts


	#--------  14. Imprimir Bit 0
	la a0, test14_name
	jal puts

	#-- sprint_bcd_digit(buffer, 0)
	la a0, buffer
	li a1, 0
	jal sprint_bcd_digit

	#-- assert buffer == '0'
	la a0, buffer
	la a1, test14_result1
	jal assert_str_equal


	#--------  15. Imprimir Bit 1
	la a0, test15_name
	jal puts

	#-- sprint_bcd_digit(buffer, 1)
	la a0, buffer
	li a1, 1
	jal sprint_bcd_digit

	#-- assert buffer == '1'
	la a0, buffer
	la a1, test15_result2
	jal assert_str_equal


	#--------  16. Imprimir todos los digitos octales
	la a0, test16_name
	jal puts

	#-- Contador de digitos
	li s0, 0

	#-- Direccion del buffer
	la a0, buffer

 next16:
	#-- sprint_bcd_digit(buffer, dig)
	mv a1, s0
	jal sprint_bcd_digit

	#-- Incrementar contador
	addi s0, s0, 1

	#-- Mientras digito actual sea menor a 8, repetir
	li t0, 8
	blt s0, t0, next16

	#-- assert buffer == '01234567'
	la a0, buffer
	la a1, test16_result3
	jal assert_str_equal


	#--------  17. Imprimir todos los digitos decimales
	la a0, test17_name
	jal puts

	#-- Contador de digitos
	li s0, 0

	#-- Direccion del buffer
	la a0, buffer

 next17:
	#-- sprint_bcd_digit(buffer, dig)
	mv a1, s0
	jal sprint_bcd_digit

	#-- Incrementar contador
	addi s0, s0, 1

	#-- Mientras digito actual sea menor a 10, repetir
	li t0, 10
	blt s0, t0, next17

	#-- assert buffer == '0123456789'
	la a0, buffer
	la a1, test17_result4
	jal assert_str_equal


	#--------  18. Imprimir todos los digitos hexadecimales
	la a0, test18_name
	jal puts

	#-- Contador de digitos
	li s0, 0

	#-- Direccion del buffer
	la a0, buffer

 next18:
	#-- sprint_bcd_digit(buffer, dig)
	mv a1, s0
	jal sprint_bcd_digit

	#-- Incrementar contador
	addi s0, s0, 1

	#-- Mientras digito actual sea menor a 16, repetir
	li t0, 16
	blt s0, t0, next18

	#-- assert buffer == '0123456789'
	la a0, buffer
	la a1, test18_result5
	jal assert_str_equal


	#--------- 19. Imprimir Cadena+Digito BCD
	la a0, test19_name
	jal puts

	#-- sprint(buffer, "Bit: ")
	la a0, buffer
	la a1, test19_cad
	jal sprint

	#-- sprint_bcd_digit(buffer, 0)
	li a1, 0
	jal sprint_bcd_digit

	#-- assert buffer == '0'
	la a0, buffer
	la a1, test19_result6
	jal assert_str_equal


	#--------- 20. Imprimir Cadena+Digito+Digito
	la a0, test20_name
	jal puts

	#-- sprint(buffer, "Bin: ")
	la a0, buffer
	la a1, test20_cad
	jal sprint

	#-- sprint_bcd_digit(buffer, 1)
	li a1, 1
	jal sprint_bcd_digit

	#-- sprint_bcd_digit(buffer, 0)
	li a1, 0
	jal sprint_bcd_digit

	#-- assert buffer == 'Bin: 10'
	la a0, buffer
	la a1, test20_result6
	jal assert_str_equal


	#---------- 21. Imprimir Cadena + Digito + Cadena
	la a0, test21_name
	jal puts

	#-- sprint(buffer, "Digito: ")
	la a0, buffer
	la a1, test21_cad1
	jal sprint

	#-- sprint_bcd_digit(buffer, 9)
	li a1, 9
	jal sprint_bcd_digit

	#-- sprint(buffer, "-----\n")
	la a1, test21_cad2
	jal sprint

	#-- assert_str_equal(buffer, "Digito: 9-----\n")
	la a0, buffer
	la a1, test21_result7
	jal assert_str_equal

	UNSTACK16
	ret


#---------------------------------------
#-- Pruebas unitarias de sprint_unary()
#-- TEST8-TEST13
#---------------------------------------
unittest_sprint_unary:

	.text
	STACK16

	TEST_TITTLE("----- SPRINT_UNARY()-----\n")

	#-------- Numero unario 1
	TEST_NAME("8")
	SPRINT_UNARY(buffer, 1, '1')
	ASSERT_STR_EQUAL(buffer, "1")

	#--------- Numero unario 11
	TEST_NAME("9")
	SPRINT_UNARY(buffer, 2, '1')
	ASSERT_STR_EQUAL(buffer, "11")

	#--------- Numero unario 111
	TEST_NAME("10")
	SPRINT_UNARY(buffer, 3, '1')
	ASSERT_STR_EQUAL(buffer, "111")

	#---------- Barra de progreso ****
	TEST_NAME("11")
	SPRINT_UNARY(buffer, 4, '*')
	ASSERT_STR_EQUAL(buffer, "****")

	#----------- 12. Cadena + unario: "Unary: 11111"
	TEST_NAME("12")
	SPRINT(buffer, "Unary: ")
	SPRINT_UNARY(5, '1')
	ASSERT_STR_EQUAL(buffer, "Unary: 11111")

	#----------- 13. Cadena + unario + cadena: "->111111<-"
	TEST_NAME("13")
	SPRINT(buffer, "->")
	SPRINT_UNARY(6, '1')
	SPRINT("<-\n")
	ASSERT_STR_EQUAL(buffer, "->111111<-\n")

	UNSTACK16



#---------------------------------------
#-- Pruebas unitarios de sprint_char()
#-- TEST4-TEST7
#---------------------------------------
unittest_sprint_char:

	.text
	STACK16

	TEST_TITTLE("----- SPRINT_CHAR()------\n")

	#-------- Impresion de un caracter
	TEST_NAME("4")
	SPRINT_CHAR(buffer, 'A')
	ASSERT_STR_EQUAL(buffer, "A")

	#--------- Impresion de dos caracteres
	TEST_NAME("5")
	SPRINT_CHAR(buffer, 'X')
	SPRINT_CHAR('Y')
	ASSERT_STR_EQUAL(buffer, "XY")

	#---------- Impresion de cadena + caracter
	TEST_NAME("6")
	SPRINT(buffer, "TEST-")
	SPRINT_CHAR('Z')
	ASSERT_STR_EQUAL(buffer, "TEST-Z")

	#----------- Impresion de cadena + caracter + cadena
	TEST_NAME("7")
	SPRINT(buffer, "CUBE")
	SPRINT_CHAR('-')
	SPRINT("CUBE")
	ASSERT_STR_EQUAL(buffer, "CUBE-CUBE")

	UNSTACK16



#---------------------------------
#-- Pruebas unitarias de sprint()
#-- TEST1-TEST3
#---------------------------------
unittest_sprint:

	.text
	STACK16

	TEST_TITTLE("----- SPRINT()--------\n")

	#-------- Impresion de una cadena
	TEST_NAME("1")
	SPRINT(buffer, "Cadena de prueba")
	ASSERT_STR_EQUAL(buffer, "Cadena de prueba")

	#-------- Impresion de dos cadenas
	TEST_NAME("2")
	SPRINT(buffer, "MSG1-")
	SPRINT("MSG2")
	ASSERT_STR_EQUAL(buffer, "MSG1-MSG2")

	#--------- Impresion de tres cadenas
	TEST_NAME("3")
	SPRINT(buffer, "ABCD-")
	SPRINT("EFGH-")
	SPRINT("IJKL")
	ASSERT_STR_EQUAL(buffer, "ABCD-EFGH-IJKL")

	UNSTACK16


