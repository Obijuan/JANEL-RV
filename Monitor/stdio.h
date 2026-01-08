#----------------------------------
#-- MACROS
#----------------------------------

.macro PUTSL(%label)
    la a0, %label
    jal puts
.end_macro

.macro PUTS(%str)
     .data
 msg: .string %str

     .text
    la a0, msg
    jal puts
.end_macro

.macro PUTSR(%reg)
    mv a0, %reg
    jal puts
.end_macro

#-------------------------------------------
#-- Llamar a la funcion sprint(dst, cad)
#-------------------------------------------
.macro SPRINT(%dst, %str)
	  .data
 cad: .string %str

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
 cad: .string %str

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

.macro SPRINT_BCD_DIGITR(%reg)
	mv a1, %reg
	jal sprint_bcd_digit
.end_macro