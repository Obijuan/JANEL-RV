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


# ── INSTRUCCIONES para hacer pruebas
ADDI_X0_X0_0 = 0x0000_0013
ADDI_X1_X2_3 = 0x0031_0093

# ─────────────────
#   MAIN
# ─────────────────
print()

# -- Instruccion de prueba
inst1 = InstrRV(ADDI_X0_X0_0)
inst1.debug()
print_inst_tipo_I(inst1)

inst2 = InstrRV(ADDI_X1_X2_3)
inst2.debug()
print_inst_tipo_I(inst2)
