#!/usr/bin/env python3
from InstrRV import InstrRV
import ansi


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
        inst._print_isa_tipo_I()


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


def test_lbu():
    insts = [
        0x10024183,   # lbu x3, 0x100(x4)
        0x20034283,   # lbu x5, 0x200(x6)
        0x40044383,   # lbu x7, 0x400(x8)
        0xfc054483,   # lbu x9, -0x40(x10)
        0xf8064583,   # lbu x11, -0x80(x12)
        0xf0074683,   # lbu x13, -0x100(x14)
    ]
    print_inst(insts, 'LBU')


def test_lhu():
    insts = [
        0x50085783,  # lhu x15, 0x500(x16)
        0x60095883,  # lhu x17, 0x600(x18)
        0x700a5983,  # lhu x19, 0x700(x20)
        0xe00b5a83,  # lhu x21, -0x200(x22)
        0xc00c5b83,  # lhu x23, -0x400(x24)
        0x800d5c83,  # lhu x25, -0x800(x26)
    ]
    print_inst(insts, 'LHU')


def test_add():
    insts = [
        0x00000033,  # add x0, x0, x0
        0x003100b3,  # add x1, x2, x3
        0x00628233,  # add x4, x5, x6
        0x009403b3,  # add x7, x8, x9
        0x00a50533,  # add x10, x10, x10
    ]
    print_inst(insts, 'ADD')


def test_sub():
    insts = [
        0x40d605b3,  # sub x11, x12, x13
        0x41078733,  # sub x14, x15, x16
        0x413908b3,  # sub x17, x18, x19
        0x416a8a33,  # sub x20, x21, x22
        0x419c0bb3,  # sub x23, x24, x25
    ]
    print_inst(insts, 'SUB')


def test_sll():
    insts = [
        0x01cd9d33,  # sll x26, x27, x28
        0x01ff1eb3,  # sll x29, x30, x31
        0x00209033,  # sll x0, x1, x2
        0x005211b3,  # sll x3, x4, x5
        0x00839333,  # sll x6, x7, x8
    ]
    print_inst(insts, 'SLL')


def test_slt():
    insts = [
        0x00b524b3,  # slt x9, x10, x11
        0x00e6a633,  # slt x12, x13, x14
        0x011827b3,  # slt x15, x16, x17
        0x0149a933,  # slt x18, x19, x20
        0x017b2ab3,  # slt x21, x22, x23
    ]
    print_inst(insts, 'SLT')


def test_sltu():
    insts = [
        0x01acbc33,  # sltu x24, x25, x26
        0x01de3db3,  # sltu x27, x28, x29
        0x000fbf33,  # sltu x30, x31, x0
        0x003130b3,  # sltu x1, x2, x3
        0x0062b233,  # sltu x4, x5, x6
    ]
    print_inst(insts, 'SLTU')


def test_srl():
    insts = [
        0x009453b3,  # srl x7, x8, x9
        0x00c5d533,  # srl x10, x11, x12
        0x00f756b3,  # srl x13, x14, x15
        0x0128d833,  # srl x16, x17, x18
        0x015a59b3,  # srl x19, x20, x21
    ]
    print_inst(insts, 'SRL')


def test_sra():
    insts = [
        0x418bdb33,  # sra x22, x23, x24
        0x41bd5cb3,  # sra x25, x26, x27
        0x41eede33,  # sra x28, x29, x30
        0x40105fb3,  # sra x31, x0, x1
        0x4041d133,  # sra x2, x3, x4
    ]
    print_inst(insts, 'SRA')


def test_xor():
    insts = [
        0x007342b3,  # xor x5, x6, x7
        0x00a4c433,  # xor x8, x9, x10
        0x00d645b3,  # xor x11, x12, x13
        0x0107c733,  # xor x14, x15, x16
        0x013948b3,  # xor x17, x18, x19
    ]
    print_inst(insts, 'XOR')


def test_or():
    insts = [
        0x016aea33,  # or x20, x21, x22
        0x019c6bb3,  # or x23, x24, x25
        0x01cded33,  # or x26, x27, x28
        0x01ff6eb3,  # or x29, x30, x31
        0x0020e033,  # or x0, x1, x2
    ]
    print_inst(insts, 'OR')


def test_and():
    insts = [
        0x005271b3,  # and x3, x4, x5
        0x0083f333,  # and x6, x7, x8
        0x00b574b3,  # and x9, x10, x11
        0x00e6f633,  # and x12, x13, x14
        0x011877b3,  # and x15, x16, x17
    ]
    print_inst(insts, 'AND')


def test_sb():
    insts = [
        0x00008023,  # sb x0, 0(x1)
        0x002180a3,  # sb x2, 1(x3)
        0x00428123,  # sb x4, 2(x5)
        0xfe638fa3,  # sb x6, -1(x7)
        0xfe848f23,  # sb x8, -2(x9)
        0xfea58e23,  # sb x10, -4(x11)
    ]
    print_inst(insts, 'SB')


def test_sh():
    insts = [
        0x00c69223,  # sh x12, 4(x13)
        0x00e79423,  # sh x14, 8(x15)
        0x01089823,  # sh x16, 0x10(x17)
        0xff299c23,  # sh x18, -8(x19)
        0xff4a9823,  # sh x20, -0x10(x21)
        0xff6b9023,  # sh x22, -0x20(x23)
    ]
    print_inst(insts, 'SH')


def test_sw():
    insts = [
        0x118ca023,  # sw x24, 0x100(x25)
        0x21ada023,  # sw x26, 0x200(x27)
        0x7fceafa3,  # sw x28, 0x7FF(x29)
        0xf1efa023,  # sw x30, -0x100(x31)
        0xe000a023,  # sw x0, -0x200(x1)
        0x8021a023,  # sw x2, -0x800(x3)
    ]
    print_inst(insts, 'SW')


def test_beq():
    insts = [
        0x00000063,  # beq x0, x0, 0
        0xfe100ee3,  # beq x0, x1, -4
        0xfe208ce3,  # beq x1, x2, -8
        0x00418263,  # beq x3, x4, 4
        0x00628463,  # beq x5, x6, 8
        0x00838663,  # beq x7, x8, 12
    ]
    print_inst(insts, 'BEQ')


def test_bne():
    insts = [
        0xfea498e3,  # bne x9, x10, -16
        0xfec590e3,  # bne x11, x12, -32
        0xfce690e3,  # bne x13, x14, -64
        0x03079063,  # bne x15, x16, 32
        0x05289063,  # bne x17, x18, 64
        0x09499063,  # bne x19, x20, 128
    ]
    print_inst(insts, 'BNE')


def test_blt():
    insts = [
        0xf96ac0e3,  # blt x21, x22, -128
        0xf18bc0e3,  # blt x23, x24, -256
        0xe1acc0e3,  # blt x25, x26, -512
        0x11cdc063,  # blt x27, x28, 256
        0x21de4063,  # blt x28, x29, 512
        0x41ff4063,  # blt x30, x31, 1024
    ]
    print_inst(insts, 'BLT')


def test_bge():
    insts = [
        0xc01050e3,  # bge x0, x1, -1024
        0x803152e3,  # bge x2, x3, -2044
        0x805250e3,  # bge x4, x5, -2048
        0x7e735e63,  # bge x6, x7, 2044
        0x7e945c63,  # bge x8, x9, 2040
        0x7eb55a63,  # bge x10, x11, 2036
    ]
    print_inst(insts, 'BGE')


def test_bltu():
    insts = [
        0x00d66063,  # bltu x12, x13, 0
        0xfef76ee3,  # bltu x14, x15, -4
        0xff186ce3,  # bltu x16, x17, -8
        0x01396263,  # bltu x18, x19, 4
        0x015a6463,  # bltu x20, x21, 8
        0x017b6863,  # bltu x22, x23, 16
    ]
    print_inst(insts, 'BLTU')


def test_bgeu():
    insts = [
        0xff9c78e3,  # bgeu x24, x25, -16
        0xffbd70e3,  # bgeu x26, x27, -32
        0xfdde70e3,  # bgeu x28, x29, -64
        0x03ff7063,  # bgeu x30, x31, 32
        0x04107063,  # bgeu x0, x1, 64
        0x08317063,  # bgeu x2, x3, 128
    ]
    print_inst(insts, 'BGEU')


def test_lui():
    insts = [
        0x00000037,  # lui x0, 0x0
        0x0000f0b7,  # lui x1, 0xF
        0x000ff137,  # lui x2, 0xFF
        0x00fff1b7,  # lui x3, 0xFFF
        0x0ffff237,  # lui x4, 0xFFFF
        0xfffff2b7,  # lui x5, 0xFFFFF
    ]
    print_inst(insts, 'LUI')


def test_auipc():
    insts = [
        0x00000317,  # auipc x6, 0x0
        0x0000a397,  # auipc x7, 0xA
        0x000aa417,  # auipc x8, 0xAA
        0x00aaa497,  # auipc x9, 0xAAA
        0x0aaaa517,  # auipc x10, 0xAAAA
        0xaaaaa597,  # auipc x11, 0xAAAAA
    ]
    print_inst(insts, 'AUIPC')


def test_jal():
    insts = [
        0xffdff0ef,  # jal x1, -4
        0xff9ff16f,  # jal x2, -8
        0xff1ff1ef,  # jal x3, -16
        0xfe1ff26f,  # jal x4, -32
        0xfc1ff2ef,  # jal x5, -64
        0xf81ff36f,  # jal x6, -128
        0xf01ff3ef,  # jal x7, -256
        0xe01ff46f,  # jal x8, -512
        0xc01ff4ef,  # jal x9, -1024
        0x801ff56f,  # jal x10, -2048
        0x800ff5ef,  # jal x11, -4096
        0x800fe66f,  # jal x12, -8192
        0x000026ef,  # jal x13, 8192
        0x0000176f,  # jal x14, 4096
        0x001007ef,  # jal x15, 2048
        0x4000086f,  # jal x16, 1024
        0x200008ef,  # jal x17, 512
        0x1000096f,  # jal x18, 256
        0x080009ef,  # jal x19, 128
        0x04000a6f,  # jal x20, 64
        0x02000aef,  # jal x21, 32
        0x01000b6f,  # jal x22, 16
        0x00800bef,  # jal x23, 8
        0x00400c6f,  # jal x24, 4
    ]
    print_inst(insts, 'JAL')


def test_jalr():
    insts = [
        0x00000067,  # jalr x0, x0, 0
        0x00408067,  # jalr x0, x1, 4
        0x00818167,  # jalr x2, x3, 8
        0x01028267,  # jalr x4, x5, 0x10
        0x02038367,  # jalr x6, x7, 0x20
        0x04048467,  # jalr x8, x9, 0x40
        0x08058567,  # jalr x10, x11, 0x80
        0x10068667,  # jalr x12, x13, 0x100
        0x20078767,  # jalr x14, x15, 0x200
        0x40088867,  # jalr x16, x17, 0x400
        0x7ff98967,  # jalr x18, x19, 0x7FF
        0xffca8a67,  # jalr x20, x21, -4
        0xff8b8b67,  # jalr x22, x23, -8
        0xff0c8c67,  # jalr x24, x25, -0x10
        0xfe0d8d67,  # jalr x26, x27, -0x20
        0xfc0e8e67,  # jalr x28, x29, -0x40
        0xf80f8f67,  # jalr x30, x31, -0x80
        0xf0008067,  # jalr x0, x1, -0x100
        0xe0018167,  # jalr x2, x3, -0x200
        0xc0028267,  # jalr x4, x5, -0x400
        0x80038367,  # jalr x6, x7, -0x800
    ]
    print_inst(insts, 'JALR')


def test_ecall():
    insts = [
        0x00000073,   # ecall
        0x00100073,   # ebreak
    ]
    print_inst(insts, 'ECALL')


# ────────────────────────────────────────────
#   PROBAR TODAS LAS INSTRUCCIONES DE TIPO I
# ────────────────────────────────────────────
def test_tipo_I():
    print(f"{ansi.LCYAN}", end='')
    print("─────────────────────────────────────────")
    print("──       INSTRUCCIONES TIPO I         ───")
    print("─────────────────────────────────────────")
    print(ansi.RESET, end='')
    test_addi()
    test_slli()
    test_slti()
    test_sltiu()
    test_xori()
    test_ori()
    test_andi()
    test_srli()
    test_srai()
    test_lb()
    test_lw()
    test_lh()
    test_lbu()
    test_lhu()


# ────────────────────────────────────────────
#   PROBAR TODAS LAS INSTRUCCIONES DE TIPO R
# ────────────────────────────────────────────
def test_tipo_R():
    print(f"{ansi.LCYAN}", end='')
    print("─────────────────────────────────────────")
    print("──       INSTRUCCIONES TIPO R         ───")
    print("─────────────────────────────────────────")
    print(ansi.RESET, end='')
    test_add()
    test_sub()
    test_sll()
    test_slt()
    test_sltu()
    test_srl()
    test_sra()
    test_xor()
    test_or()
    test_and()


# ────────────────────────────────────────────
#   PROBAR LAS INSTRUCCIONES DE TIPO S
# ────────────────────────────────────────────
def test_tipo_S():
    print(f"{ansi.LCYAN}", end='')
    print("─────────────────────────────────────────")
    print("──       INSTRUCCIONES TIPO S         ───")
    print("─────────────────────────────────────────")
    print(ansi.RESET, end='')
    test_sb()
    test_sh()
    test_sw()


# ────────────────────────────────────────────
#   PROBAR LAS INSTRUCCIONES DE TIPO B
# ────────────────────────────────────────────
def test_tipo_B():
    print(f"{ansi.LCYAN}", end='')
    print("─────────────────────────────────────────")
    print("──       INSTRUCCIONES TIPO B         ───")
    print("─────────────────────────────────────────")
    print(ansi.RESET, end='')
    test_beq()
    test_bne()
    test_blt()
    test_bge()
    test_bltu()
    test_bgeu()


# ────────────────────────────────────────────
#   PROBAR LAS INSTRUCCIONES DE TIPO U
# ────────────────────────────────────────────
def test_tipo_U():
    print(f"{ansi.LCYAN}", end='')
    print("─────────────────────────────────────────")
    print("──       INSTRUCCIONES TIPO U         ───")
    print("─────────────────────────────────────────")
    print(ansi.RESET, end='')
    test_lui()
    test_auipc()


# ────────────────────────────────────────────
#   PROBAR LAS INSTRUCCIONES DE TIPO J
# ────────────────────────────────────────────
def test_tipo_J():
    print(f"{ansi.LCYAN}", end='')
    print("─────────────────────────────────────────")
    print("──       INSTRUCCIONES TIPO J         ───")
    print("─────────────────────────────────────────")
    print(ansi.RESET, end='')
    test_jal()
    test_jalr()


# ─────────────────
#   MAIN
# ─────────────────
print(ansi.CLS)
# test_tipo_I()
# test_tipo_R()
# test_tipo_S()
# test_tipo_B()
# test_tipo_U()
# test_tipo_J()
# test_ecall()

# test1()

i = InstrRV(0x0000_0013)
i.debug()
i.print_isa()
i.print_isa(color=False)

i = InstrRV(0x00008003)
i.debug()
i.print_isa()
i.print_isa(color=False)
