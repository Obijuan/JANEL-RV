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

.macro SPRINT_HEX(%buffer, %num, %size, %ini0)
	la a0, %buffer
	li a1, %num  #-- Numero
	li a2, %size  #-- Tamaño en digitos
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_hex
.end_macro

.macro SPRINT_HEX(%num, %size, %ini0)
	li a1, %num  #-- Numero 
	li a2, %size  #-- Tamaño en digitos
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_hex
.end_macro

.macro SPRINT_UINT(%buffer, %num, %size, %ini0)
	la a0, %buffer
	li a1, %num  #-- Numero
	li a2, %size  #-- Tamaño en digitos
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_uint
.end_macro

.macro SPRINT_UINT(%num, %size, %ini0)
	li a1, %num  #-- Numero 
	li a2, %size  #-- Tamaño en digitos
	li a3, %ini0  #-- Ceros iniciales
	jal sprint_uint
.end_macro


