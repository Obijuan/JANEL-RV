

	#-- Longitud maxima de las cadenas
	.eqv MAX 255

	#-- Servicios del sistema operativo del RARs
	.include "rars_so.h"

    #-- Macros para funciones y pila
    .include "stack.h"

	#-- Macros para los tests
	.include "test-stdio.h"
	.include "unittest.h"

	#-- Valores para el parametro ini0
	.eqv CON_0s_INICIALES 1
	.eqv SIN_0s_INICIALES 0


		.data
buffer: .space MAX


#-----------
#-- MAIN
#----------- 
	.text   

	#-- Configurar la E/S
	jal io_init

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
	jal unittest_sprint_hex
	jal unittest_sprint_uint


	#-- Terminar
	PRINT_CHARI('\n')
	EXIT


#------------------------------------------
#-- Pruebas unitarias de sprint_oct
#-- TEST78-TEST99
#------------------------------------------
unittest_sprint_uint:
	STACK16
	TEST_TITTLE("----- SPRINT_UINT() ------\n")

	#-- Imprimir un digito decimal
	TEST_NAME("78")
	SPRINT_UINT(buffer, 0, 1, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	TEST_NAME("79")
	SPRINT_UINT(buffer, 1, 1, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1")

	TEST_NAME("80")
	SPRINT_UINT(buffer, 9, 1, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "9")

	#-- Imprimir numeros de 2 digitos
	TEST_NAME("81")
	SPRINT_UINT(buffer, 0x10, 2, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "16")

	TEST_NAME("82")
	SPRINT_UINT(buffer, 99, 2, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "99")

	#-- Imprimir numeros de 3 digitos
	TEST_NAME("83")
	SPRINT_UINT(buffer, 0x100, 3, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "256")

	TEST_NAME("84")
	SPRINT_UINT(buffer, 999, 3, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "999")

	#-- Imprimir numeros de 4 digitos
	TEST_NAME("85")
	SPRINT_UINT(buffer, 0x1000, 4, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "4096")

	TEST_NAME("86")
	SPRINT_UINT(buffer, 9999, 4, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "9999")

	#-- Imprimir numeros de 5 digitos
	TEST_NAME("87")
	SPRINT_UINT(buffer, 0x10000, 5, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "65536")

	TEST_NAME("88")
	SPRINT_UINT(buffer, 99999, 5, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "99999")

	#-- Imprimir numeros de 6 digitos
	TEST_NAME("89")
	SPRINT_UINT(buffer, 0x1a000, 6, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "106496")

	TEST_NAME("90")
	SPRINT_UINT(buffer, 999999, 6, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "999999")

	#-- Imprimir numeros de 7 digitos
	TEST_NAME("91")
	SPRINT_UINT(buffer, 0x100000, 7, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "1048576")

	TEST_NAME("92")
	SPRINT_UINT(buffer, 9999999, 7, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "9999999")

	#-- Imprimir numeros de 8 digitos
	TEST_NAME("93")
	SPRINT_UINT(buffer, 0x1000000, 8, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "16777216")

	TEST_NAME("94")
	SPRINT_UINT(buffer, 99999999, 8, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "99999999")

	#-- Imprimir numeros de 9 digitos
	TEST_NAME("95")
	SPRINT_UINT(buffer, 0x10000000, 9, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "268435456")

	TEST_NAME("96")
	SPRINT_UINT(buffer, 999999999, 9, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "999999999")

	#-- Imprimir numeros de 10 digitos
	TEST_NAME("97")
	SPRINT_UINT(buffer, 0xFFFFFFFF, 10, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "4294967295")

	#-- Imprimir cadena + numero
	TEST_NAME("98")
	SPRINT(buffer, "Dec: ")
	SPRINT_UINT(12345678, 10, SIN_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "Dec: 12345678")

	#-- Imprimir cadena + numero + cadena
	TEST_NAME("99")
	SPRINT(buffer, "--->")
	SPRINT_UINT(987654321, 10, SIN_0s_INICIALES)
	SPRINT("<---")
	ASSERT_STR_EQUAL(buffer, "--->987654321<---")

	#-- Pruebas con 0s iniciales
	TEST_NAME("100")
	SPRINT_UINT(buffer, 0, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000000")

	TEST_NAME("101")
	SPRINT_UINT(buffer, 9, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000009")

	TEST_NAME("102")
	SPRINT_UINT(buffer, 16, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000016")

	TEST_NAME("103")
	SPRINT_UINT(buffer, 256, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000256")

	TEST_NAME("104")
	SPRINT_UINT(buffer, 4096, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000004096")

	TEST_NAME("105")
	SPRINT_UINT(buffer, 65536, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000065536")

	TEST_NAME("106")
	SPRINT_UINT(buffer, 106496, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000106496")

	TEST_NAME("107")
	SPRINT_UINT(buffer, 1048576, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0001048576")

	TEST_NAME("108")
	SPRINT_UINT(buffer, 16777216, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0016777216")

	TEST_NAME("109")
	SPRINT_UINT(buffer, 268435456, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0268435456")

	TEST_NAME("110")
	SPRINT_UINT(buffer, 0xFFFFFFFF, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "4294967295")

	#--- Pruebas con digitos 0
	TEST_NAME("111")
	SPRINT_UINT(buffer, 0, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00")

	TEST_NAME("112")
	SPRINT_UINT(buffer, 0, 3, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "000")

	TEST_NAME("113")
	SPRINT_UINT(buffer, 0, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000")

	TEST_NAME("114")
	SPRINT_UINT(buffer, 0, 5, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000")

	TEST_NAME("115")
	SPRINT_UINT(buffer, 0, 6, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "000000")

	TEST_NAME("116")
	SPRINT_UINT(buffer, 0, 7, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000")

	TEST_NAME("117")
	SPRINT_UINT(buffer, 0, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000000")

	TEST_NAME("118")
	SPRINT_UINT(buffer, 0, 9, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "000000000")

	TEST_NAME("119")
	SPRINT_UINT(buffer, 0, 10, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0000000000")

	UNSTACK16

#------------------------------------------
#-- Pruebas unitarias de sprint_oct
#-- TEST70-TEST77
#------------------------------------------
unittest_sprint_hex:
	STACK16
	TEST_TITTLE("----- SPRINT_HEX() ------\n")

	#-- Imprimir un digito hexa
	TEST_NAME("70")
	SPRINT_HEX(buffer, 0, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0")

	#-- Imprimir un digito hexa
	TEST_NAME("71")
	SPRINT_HEX(buffer, 10, 1, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "A")

	#-- Imprimir un numero hexa
	TEST_NAME("72")
	SPRINT_HEX(buffer, 0x5A, 2, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "5A")

	#-- Imprimir un numero hexa
	TEST_NAME("73")
	SPRINT_HEX(buffer, 0xBACA, 4, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "BACA")

	#-- Imprimir un numero hexa
	TEST_NAME("74")
	SPRINT_HEX(buffer, 0, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "00000000")

	#-- Imprimir un numero hexa
	TEST_NAME("75")
	SPRINT_HEX(buffer, 0xBEBECAFE, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "BEBECAFE")

	#-- Imprimir cadena + numero hexa
	TEST_NAME("76")
	SPRINT(buffer, "0x")
	SPRINT_HEX(0xCAFEBACA, 8, CON_0s_INICIALES)
	ASSERT_STR_EQUAL(buffer, "0xCAFEBACA")

	#-- Imprimir cadena + numero hexa + cadena
	TEST_NAME("77")
	SPRINT(buffer, "--->")
	SPRINT_HEX(0x12345678, 8, CON_0s_INICIALES)
	SPRINT("<---")
	ASSERT_STR_EQUAL(buffer, "--->12345678<---")

	UNSTACK16


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


