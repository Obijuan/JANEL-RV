

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
#-- No se pasa el buffer
#---------------------------------------------------------
.macro SPRINT_UNARY(%num, %mark)
	li a1, %num    #-- Una marca
	li a2, %mark   #-- Marca a utilizar
	jal sprint_unary
.end_macro

#------------------------------------------------------
#-- Llamar a la funcion sprint_bcd_digit(buffer, bcd)
#------------------------------------------------------
.macro SPRINT_BCD_DIGIT(%buffer, %bcd)
	la a0, %buffer
	li a1, %bcd
	jal sprint_bcd_digit
.end_macro


#------------------------------------------------------
#-- Llamar a la funcion sprint_bcd_digit(bcd)
#-- No se pasa el buffer
#------------------------------------------------------
.macro SPRINT_BCD_DIGIT(%bcd)
	li a1, %bcd
	jal sprint_bcd_digit
.end_macro

#-------------------------------------------------------------
#-- Llamar a la funcion bcd_copy(buff, buff_bcd, ndig, ini0)
#-------------------------------------------------------------
.macro BCD_COPY(%buff, %buff_bcd, %ndig,  %ini0)
	la a0, %buff       #-- Cadena destino
	la a1, %buff_bcd   #-- Buffer bcd
	li a2, %ndig       #-- Un digito
	li a3, %ini0
	jal bcd_copy
.end_macro

.macro SPRINT_BIN(%buffer, %num, %size, %ini0)
	la a0, %buffer
	li a1, %num  #-- Numero binario
	li a2, %size  #-- Tamaño en bits
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_bin
.end_macro

.macro SPRINT_BIN(%num, %size, %ini0)
	li a1, %num  #-- Numero binario
	li a2, %size  #-- Tamaño en bits
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_bin
.end_macro

.macro SPRINT_OCT(%buffer, %num, %size, %ini0)
	la a0, %buffer
	li a1, %num  #-- Numero binario
	li a2, %size  #-- Tamaño en bits
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_oct
.end_macro

.macro SPRINT_OCT(%num, %size, %ini0)
	li a1, %num  #-- Numero binario
	li a2, %size  #-- Tamaño en bits
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_oct
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
	jal unittest_sprint_oct


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


#------------------------------------------
#-- Pruebas unitarias de sprint_oct
#-- TEST64-TEST69
#------------------------------------------
unittest_sprint_oct:

	STACK16
	TEST_TITTLE("----- SPRINT_OCT() ------\n")

	#-- Imprimir un digito octal
	TEST_NAME("64")
	SPRINT_OCT(buffer, 0, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	#-- Imprmir un digito octal
	TEST_NAME("65")
	SPRINT_OCT(buffer, 3, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "3")

	#-- Imprimir Numero octal
	TEST_NAME("66")
	SPRINT_OCT(buffer, 0x17, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "27")

	#-- Imprimir Numero octal
	TEST_NAME("67")
	SPRINT_OCT(buffer, 0x3FFFF, 6, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "777777")

	#-- Imprimir cadena + numero octal
	TEST_NAME("68")
	SPRINT(buffer, "Oct: ")
	SPRINT_OCT(0x53, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "Oct: 123")

	#-- Imprimir cadena + numero octal + cadena
	TEST_NAME("69")
	SPRINT(buffer, "Oct: ")
	SPRINT_OCT(0x29c, 4, CON_0s_INICIALES)
	SPRINT("<---")
	ASSERT_STR_EQUAL(buffer, "Oct: 1234<---")

	UNSTACK16


#------------------------------------------
#-- Pruebas unitarias de sprint_bin
#-- TEST31-TEST63
#------------------------------------------
unittest_sprint_bin:
 
	STACK16
	TEST_TITTLE("----- SPRINT_BIN() ------\n")

	#-------- Imprimir bit 0
	TEST_NAME("31")
	SPRINT_BIN(buffer, 0, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	#--------  Imprimir bit 1
	TEST_NAME("32")
	SPRINT_BIN(buffer, 1, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1")

	#--------  Imprimir binario "00"
	TEST_NAME("33")
	SPRINT_BIN(buffer, 0, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00")

	#--------  Imprimir binario "01"
	TEST_NAME("34")
	SPRINT_BIN(buffer, 1, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "01")

	#--------  Imprimir binario "10"
	TEST_NAME("35")
	SPRINT_BIN(buffer, 2, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "10")

	#--------  Imprimir binario "11"
	TEST_NAME("36")
	SPRINT_BIN(buffer, 3, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "11")

	#--------  Imprimir binario "000"
	TEST_NAME("37")
	SPRINT_BIN(buffer, 0, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "000")

	#--------  Imprimir binario "001"
	TEST_NAME("38")
	SPRINT_BIN(buffer, 1, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "001")

	#--------  Imprimir binario "010"
	TEST_NAME("39")
	SPRINT_BIN(buffer, 2, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "010")

	#--------  Imprimir binario "101"
	TEST_NAME("40")
	SPRINT_BIN(buffer, 5, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "101")

	#--------  Imprimir binario "111"
	TEST_NAME("41")
	SPRINT_BIN(buffer, 7, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "111")

	#--------  Imprimir binario "0000"
	TEST_NAME("42")
	SPRINT_BIN(buffer, 0, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000")

	TEST_NAME("43")
	SPRINT_BIN(buffer, 1, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0001")

	TEST_NAME("44")
	SPRINT_BIN(buffer, 5, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0101")

	TEST_NAME("45")
	SPRINT_BIN(buffer, 10, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1010")

	TEST_NAME("46")
	SPRINT_BIN(buffer, 15, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1111")

	TEST_NAME("47")
	SPRINT_BIN(buffer, 0, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000000")

	TEST_NAME("48")
	SPRINT_BIN(buffer, 1, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000001")

	TEST_NAME("49")
	SPRINT_BIN(buffer, 85, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "01010101")

	TEST_NAME("50")
	SPRINT_BIN(buffer, 170, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "10101010")

	TEST_NAME("51")
	SPRINT_BIN(buffer, 0, 16, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000000000000")

	TEST_NAME("52")
	SPRINT_BIN(buffer, 1, 16, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000000000001")

	TEST_NAME("53")
	SPRINT_BIN(buffer, 0x5555, 16, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0101010101010101")

	TEST_NAME("54")
	SPRINT_BIN(buffer, 0xAAAA, 16, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1010101010101010")

	TEST_NAME("55")
	SPRINT_BIN(buffer, 0xFFFF, 16, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1111111111111111")

	TEST_NAME("56")
	SPRINT_BIN(buffer, 0, 32, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000000000000000000000000000000")

	TEST_NAME("57")
	SPRINT_BIN(buffer, 1, 32, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000000000000000000000000000001")

	TEST_NAME("58")
	SPRINT_BIN(buffer, 0x0000FFFF, 32, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000000000000001111111111111111")

	TEST_NAME("59")
	SPRINT_BIN(buffer, 0x55555555, 32, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "01010101010101010101010101010101")

	TEST_NAME("60")
	SPRINT_BIN(buffer, 0xAAAAAAAA, 32, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "10101010101010101010101010101010")

	TEST_NAME("61")
	SPRINT_BIN(buffer, 0xFFFFFFFF, 32, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "11111111111111111111111111111111")

	#---- Imprimir cadena + numero binario
	TEST_NAME("62")
	SPRINT(buffer, "Bin: ")
	SPRINT_BIN(0xF0, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "Bin: 11110000")

	#---- Imprimir cadena + numero binario + cadena
	TEST_NAME("63")
	SPRINT(buffer, "Bin: ")
	SPRINT_BIN(0xAA55, 16, CON_0s_INICIALES)
	SPRINT("<---")
	ASSERT_STR_EQUAL(buffer, "Bin: 1010101001010101<---")
	
	UNSTACK16



#------------------------------------------
#-- Pruebas unitarias de bcd_copy
#-- TEST22-30
#------------------------------------------
unittest_bcd_copy:

	.data
 test22_bcd:     .byte 0
 test23_bcd:     .byte 0, 1
 test24_bcd:     .byte 0, 0, 2
 test25_bcd:     .byte 0, 1, 2, 3, 4, 5, 6, 7
				 .byte 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF
 test26_bcd:     .byte 0
 test27_bcd:     .byte 0, 2
 test28_bcd:     .byte 0, 0, 3
 test29_bcd:     .byte 0, 0, 0, 0, 0xB, 0xA, 0xC, 0xA
 test30_bcd:     .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	.text
	STACK16
	TEST_TITTLE("----- BCD_COPY() ------\n")

	#--------  Imprimir un digito bcd
	TEST_NAME("22")
	BCD_COPY(buffer, test22_bcd, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	#-------- Imprimir dos digitos bcd
	TEST_NAME("23")
	BCD_COPY(buffer, test23_bcd, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "01")

	#-------- Imprimir tres digitos bcd
	TEST_NAME("24")
	BCD_COPY(buffer, test24_bcd, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "002")

	#--------- Imprimir 16 digitos bcd
	TEST_NAME("25")
	BCD_COPY(buffer, test25_bcd, 16, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0123456789ABCDEF")

	#--------- Imprimir un '0' sin ceros iniciales
	#--------  Caso especial
	TEST_NAME("26")
	BCD_COPY(buffer, test26_bcd, 1, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	#--------- Imprimir un digito con  1 cero iniciales
	TEST_NAME("27")
	BCD_COPY(buffer, test27_bcd, 2, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "2")

	#--------- Imprimir un digito con 2 ceros iniciales
	TEST_NAME("28")
	BCD_COPY(buffer, test28_bcd, 3, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "3")

	#--------- Imprimir un numero con muchos ceros iniciales
	TEST_NAME("29")
	BCD_COPY(buffer, test29_bcd, 8, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "BACA")

	#--------- 30. Imprimir un numero con muchos ceros
	TEST_NAME("30")
	BCD_COPY(buffer, test30_bcd, 10, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	UNSTACK16


#------------------------------------------
#-- Pruebas unitarias de sprint_bcd_digit
#-- TEST14-TEST21
#------------------------------------------
unittest_sprint_bcd_digit:

	.text
	STACK16

	TEST_TITTLE("----- SPRINT_BCD_DIGIT()-----\n")

	#--------  Imprimir Bit 0
	TEST_NAME("14")
	SPRINT_BCD_DIGIT(buffer, 0)
	ASSERT_STR_EQUAL(buffer, "0")

	#--------  Imprimir Bit 1
	TEST_NAME("15")
	SPRINT_BCD_DIGIT(buffer, 1)
	ASSERT_STR_EQUAL(buffer, "1")

	#--------  Imprimir todos los digitos octales
	TEST_NAME("16")

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

	ASSERT_STR_EQUAL(buffer, "01234567")

	#--------  Imprimir todos los digitos decimales
	TEST_NAME("17")

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

	ASSERT_STR_EQUAL(buffer, "0123456789")


	#--------  Imprimir todos los digitos hexadecimales
	TEST_NAME("18")

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

	ASSERT_STR_EQUAL(buffer, "0123456789ABCDEF")

	#--------- Imprimir Cadena+Digito BCD
	TEST_NAME("19")
	SPRINT(buffer, "Bit: ")
	SPRINT_BCD_DIGIT(0)
	ASSERT_STR_EQUAL(buffer, "Bit: 0")

	#--------- Imprimir Cadena+Digito+Digito
	TEST_NAME("20")
	SPRINT(buffer, "Bin: ")
	SPRINT_BCD_DIGIT(1)
	SPRINT_BCD_DIGIT(0)
	ASSERT_STR_EQUAL(buffer, "Bin: 10")

	#---------- Imprimir Cadena + Digito + Cadena
	TEST_NAME("21")
	SPRINT(buffer, "Digito: ")
	SPRINT_BCD_DIGIT(9)
	SPRINT("-----\n")
	ASSERT_STR_EQUAL(buffer, "Digito: 9-----\n")

	UNSTACK16


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

	#----------- Cadena + unario: "Unary: 11111"
	TEST_NAME("12")
	SPRINT(buffer, "Unary: ")
	SPRINT_UNARY(5, '1')
	ASSERT_STR_EQUAL(buffer, "Unary: 11111")

	#----------- Cadena + unario + cadena: "->111111<-"
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


