#!/usr/bin/env python3
from InstrRV import InstrRV
import ansi


# -- Imprimir las instrucciones de tipo I
# -- NO se usan colores
def print_inst_tipo_I_BW(inst: InstrRV):
    print(" 31      20 19   15 14   12 11   7 6      0")
    print("├──────────┼───────┼───────┼───────┼────────┤")
    print("│ imm12    │ rs1   │ func3 │  rd   │ opcode │")
    print(f"│ {inst.imm12:#05x}    │ {inst.rs1:02}    │ ", end='')
    print(f"{inst.func3}  ", end='')
    print(f"   │  {inst.rd:02}   │ {inst.opcode:#04x}   │")
    print("├──────────┼───────┼───────┼───────┼────────┤")
    print("│ᐊ────────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ──────ᐅ│")
    print("     12        5       3       5         7")
    print()


# -- Imprimir las instrucciones de tipo R
# -- NO se usan colores
def print_inst_tipo_R_BW(inst: InstrRV):
    print(" 31      25 24   20 19   15 14   12 11    7 6      0")
    print("├──────────┼───────┼───────┼───────┼───────┼────────┤")
    print("│ func7    │  rs2  │  rs1  │ func3 │  rd   │ opcode │")
    print(f"│ {inst.func7:#04x}     ", end='')
    print(f"│  {inst.rs2:02}   ", end='')
    print(f"│  {inst.rs1:02}   ", end='')
    print(f"│  {inst.func3}    ", end='')
    print(f"│  {inst.rd:02}   ", end='')
    print(f"│  {inst.opcode:#04x}  │")
    print("├──────────┼───────┼───────┼───────┼───────┼────────┤")
    print("│ᐊ────────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ──────ᐅ│")
    print("      7        5       5       3       5       7")
    print()


# -- Imprimir las instrucciones de tipo I
# -- en colores
def print_inst_tipo_I(inst: InstrRV):
    # ----- Alias para los colores
    # -- Color para los numeros de bits y tamaños
    C0 = ansi.LWHITE

    # -- Color para las líneas
    C1 = ansi.BLUE

    # -- Color para los campos
    C2 = ansi.LYELLOW

    print(f"{C0} 31      20 19   15 14   12 11   7 6      0")
    print(f"{C1}├──────────┼───────┼───────┼───────┼────────┤")
    print("│ imm12    │ rs1   │ func3 │  rd   │ opcode │")
    print(f"{C1}│ ", end='')
    print(f"{C2}{inst.imm12:#05x}    ", end='')
    print(f"{C1}│ ", end='')
    print(f"{C2}{inst.rs1:02}    ", end='')
    print(f"{C1}│ ", end='')
    print(f"{C2}{inst.func3}     ", end='')
    print(f"{C1}│", end='')
    print(f"{C2}  {inst.rd:02}   ", end='')
    print(f"{C1}│", end='')
    print(f"{C2} {inst.opcode:#04x}   ", end='')
    print(f"{C1}│")
    print("├──────────┼───────┼───────┼───────┼────────┤")
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ────────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ──────ᐅ", end='')
    print(f"{C1}│")
    print(f"{C0}     12        5       3       5        7")
    print(ansi.RESET, end='')
    print()


# -- Imprimir las instrucciones de tipo I
# -- en colores
def print_inst_tipo_R(inst: InstrRV):
    # ----- Alias para los colores
    # -- Color para los numeros de bits y tamaños
    C0 = ansi.LWHITE

    # -- Color para las líneas
    C1 = ansi.BLUE

    # -- Color para los campos
    C2 = ansi.LYELLOW

    print(f"{C0} 31      25 24   20 19   15 14   12 11    7 6      0")
    print(f"{C1}├──────────┼───────┼───────┼───────┼───────┼────────┤")
    print("│ ", end='')
    print("func7    │  rs2  │  rs1  │ func3 │  rd   │ opcode │")
    print("│ ", end='')
    print(f"{C2}{inst.func7:#04x}     ", end='')
    print(f"{C1}│{C2}  {inst.rs2:02}   ", end='')
    print(f"{C1}│{C2}  {inst.rs1:02}   ", end='')
    print(f"{C1}│{C2}  {inst.func3}    ", end='')
    print(f"{C1}│{C2}  {inst.rd:02}   ", end='')
    print(f"{C1}│{C2}  {inst.opcode:#04x}  {C1}│")
    print("├──────────┼───────┼───────┼───────┼───────┼────────┤")
    print("│", end='')
    print(f"{C0}ᐊ────────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ─────ᐅ", end='')
    print(f"{C1}│", end='')
    print(f"{C0}ᐊ──────ᐅ", end='')
    print(f"{C1}│")
    print(f"{C0}      7        5       5       3       5       7")
    print()


def test1():
    # ── INSTRUCCIONES para hacer pruebas
    ADDI_X0_X0_0 = 0x0000_0013
    ADDI_X1_X2_3 = 0x0031_0093
    ADDI_X10_X20_0xFFF = 0xfffa0513

    insts = [ADDI_X0_X0_0,
             ADDI_X1_X2_3,
             ADDI_X10_X20_0xFFF]

    # -- Instruccion de prueba
    for mcode in insts:
        inst = InstrRV(mcode)
        inst.debug()
        print_inst_tipo_I(inst)


# ─────────────────
#   MAIN
# ─────────────────
print(ansi.CLS)
# test1()
ADD_X1_X2_X3 = 0x003100b3

inst = InstrRV(ADD_X1_X2_X3)
inst.debug()
print_inst_tipo_R_BW(inst)
print_inst_tipo_R(inst)
print()
