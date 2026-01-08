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
