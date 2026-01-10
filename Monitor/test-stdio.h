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






