#----------------------------------
#-- MACROS
#----------------------------------

.macro PUTS(%str)
     .data
msg: .string %str

     .text
    la a0, msg
    jal puts
.end_macro

