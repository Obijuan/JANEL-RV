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
    ADDI_X3_X4_0x7FF = 0x7ff20193
    ADDI_X5_X6_neg2048 = 0x80030293

    insts = [ADDI_X0_X0_0,
             ADDI_X1_X2_3,
             ADDI_X10_X20_0xFFF,
             ADDI_X3_X4_0x7FF,
             ADDI_X5_X6_neg2048]

    # -- Instruccion de prueba
    for mcode in insts:
        inst = InstrRV(mcode)
        inst.debug()
        print_inst_tipo_I(inst)


def test2():
    ADD_X1_X2_X3 = 0x003100b3
    inst = InstrRV(ADD_X1_X2_X3)
    inst.debug()
    print_inst_tipo_R_BW(inst)
    print_inst_tipo_R(inst)
    print()


def print_inst(insts: list, name: str):

    print(ansi.BLUE, end='')
    print(f"─────── {name} ───────{ansi.RESET}")
    for mcode in insts:
        inst = InstrRV(mcode)
        inst.debug()
    print()


def test_addi():
    inst_addi = [
        0x0000_0013,  # addi x0, x0, 0
        0x0031_0093,  # addi x1, x2, 3
        0xfffa_0513,  # addi x10, x20, 0xFFF
        0x7ff2_0193,  # addi x3, x4, 0x7FF
        0x8003_0293,  # addi x5, x6, -2048
    ]
    print_inst(inst_addi, 'ADDI')


def test_slli():
    inst_slli = [
        0x00009013,  # slli x0, x1, 0
        0x00119113,  # slli x2, x3, 1
        0x00329213,  # slli x4, x5, 3
        0x010a1513,  # slli x10, x20, 16
        0x01ff9f13,  # slli x30, x31, 31
    ]
    print_inst(inst_slli, 'SLLI')


def test_slti():
    insts = [
        0x0000a013,  # slti x0, x1, 0
        0x0011a113,  # slti x2, x3, 1
        0x0032a213,  # slti x4, x5, 3
        0x7ff62593,  # slti x11, x12, 2047
        0x80072693,  # slti x13, x14, -2048
        0xfff82793,  # slti x15, x16, -1
    ]
    print_inst(insts, 'SLTI')


def test_sltiu():
    insts = [
        0x0073b313,  # sltiu x6, x7, 7
        0x00f4b413,  # sltiu x8, x9, 15
        0x0ff5b513,  # sltiu x10, x11, 255
        0xff66b613,  # sltiu x12, x13, -10
        0xf9c7b713,  # sltiu x14, x15, -100
        0xfff8b813,  # sltiu x16, x17, -1
    ]
    print_inst(insts, 'SLTIU')


# ─────────────────
#   MAIN
# ─────────────────
print(ansi.CLS)
test_addi()
test_slli()
test_slti()
test_sltiu()
