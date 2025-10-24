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


def test_xori():
    insts = [
        0x0009c913,  # xori x18, x19, 0
        0x001aca13,  # xori x20, x21, 1
        0x7ffbcb13,  # xori x22, x23, 0x7FF
        0xfffccc13,  # xori x24, x25, -1
        0xc18dcd13,  # xori x26, x27, -1000
        0x830ece13,  # xori x28, x29, -2000
    ]
    print_inst(insts, 'XORI')


def test_ori():
    insts = [
        0x064fef13,  # ori x30, x31, 100
        0x0c80e013,  # ori x0, x1, 200
        0x3e81e113,  # ori x2, x3, 1000
        0xf382e213,  # ori x4, x5, -200
        0xed43e313,  # ori x6, x7, -300
        0xe704e413,  # ori x8, x9, -400
    ]
    print_inst(insts, 'ORI')


def test_andi():
    insts = [
        0x0015f513,  # andi x10, x11, 0x1
        0x0036f613,  # andi x12, x13, 0x3
        0x0077f713,  # andi x14, x15, 0x7
        0xe0c8f813,  # andi x16, x17, -500
        0xda89f913,  # andi x18, x19, -600
        0xd44afa13,  # andi x20, x21, -700
    ]
    print_inst(insts, 'ANDI')


def test_srli():
    insts = [
        0x000bdb13,  # srli x22, x23, 0
        0x001cdc13,  # srli x24, x25, 1
        0x002ddd13,  # srli x26, x27, 2
        0x004ede13,  # srli x28, x29, 4
        0x008fdf13,  # srli x30, x31, 8
        0x01015093,  # srli x1, x2, 16
        0x01f25193,  # srli x3, x4, 31
    ]
    print_inst(insts, 'SRLI')


def test_srai():
    insts = [
        0x40035293,  # srai x5, x6, 0
        0x40145393,  # srai x7, x8, 1
        0x40255493,  # srai x9, x10, 2
        0x40465593,  # srai x11, x12, 4
        0x40875693,  # srai x13, x14, 8
        0x41085793,  # srai x15, x16, 16
        0x41f95893,  # srai x17, x18, 31
    ]
    print_inst(insts, 'SRAI')


def test_lb():
    insts = [
        0x00008003,  # lb x0, 0(x1)
        0x00110083,  # lb x1, 1(x2)
        0x00220183,  # lb x3, 2(x4)
        0xfff30283,  # lb x5, -1(x6)
        0xffe40383,  # lb x7, -2(x8)
        0xffc50483,  # lb x9, -4(x10)
    ]
    print_inst(insts, 'LB')


def test_lw():
    insts = [
        0x00462583,  # lw x11, 4(x12)
        0x00872683,  # lw x13, 8(x14)
        0x01082783,  # lw x15, 16(x16)
        0xff892883,  # lw x17, -8(x18)
        0xff0a2983,  # lw x19, -0x10(x20)
        0xfe0b2a83,  # lw x21, -0x20(x22)
    ]
    print_inst(insts, 'LW')


def test_lh():
    insts = [
        0x020c1b83,  # lh x23, 0x20(x24)
        0x040d1c83,  # lh x25, 0x40(x26)
        0x080e1d83,  # lh x27, 0x80(x28)
        0xff8f1e83,  # lh x29, -8(x30)
        0xff001f83,  # lh x31, -0x10(x0)
        0xfe011083,  # lh x1, -0x20(x2)
    ]
    print_inst(insts, 'LH')


# ─────────────────
#   MAIN
# ─────────────────
print(ansi.CLS)
# test_addi()
# test_slli()
# test_slti()
# test_sltiu()
# test_xori()
# test_ori()
# test_andi()
# test_srli()
# test_srai()
test_lb()
test_lw()
test_lh()

# ld
# lbu
# lhu
# lwu
