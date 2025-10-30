import unittest
from InstrRV import InstrRV


class TestDisassemble(unittest.TestCase):

    # ───────────────────────────────────────────────────────
    #  Funcion auxiliar para comprobar instrucciones
    #  ENTRADAS:
    #    insts: diccionario con las instrucciones a probar
    #           clave: codigo maquina
    #           valor: ensamblador esperado
    # ───────────────────────────────────────────────────────
    def check_instructions(self, insts: dict):

        # ── Recorrer las instrucciones en codigo máquina a probar
        for mcode in insts.keys():

            # ── Leer la instruccion
            inst = InstrRV(mcode)

            # ── Comprobar la instruccion en ensamblador
            self.assertEqual(inst.to_asm(color=False), insts[mcode])
            print("😀", end='', flush=True)

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones ADDI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_addi(self):

        # ── INSTRUCCIONES para hacer pruebas
        # ── Codigo maquina --- ensamblador
        mcode_asm = {
            # Cod. Maq:  Ensamblador
            0x0000_0013: "addi x0, x0, 0",
            0x0031_0093: "addi x1, x2, 3",
            0xfffa_0513: "addi x10, x20, -1",
            0x7ff2_0193: "addi x3, x4, 2047",
            0x8003_0293: "addi x5, x6, -2048"
        }
        print("ADDI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SLLI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_slli(self):

        mcode_asm = {
            # Cod. Maq:  Ensamblador
            0x00009013: "slli x0, x1, 0",
            0x00119113: "slli x2, x3, 1",
            0x00329213: "slli x4, x5, 3",
            0x010a1513: "slli x10, x20, 16",
            0x01ff9f13: "slli x30, x31, 31",
        }
        print("SLLI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SLTI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_slti(self):

        mcode_asm = {
            0x0000a013: "slti x0, x1, 0",
            0x0011a113: "slti x2, x3, 1",
            0x0032a213: "slti x4, x5, 3",
            0x7ff62593: "slti x11, x12, 2047",
            0x80072693: "slti x13, x14, -2048",
            0xfff82793: "slti x15, x16, -1",
        }
        print("SLTI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SLTIU  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_sltiu(self):

        mcode_asm = {
            0x0073b313: "sltiu x6, x7, 7",
            0x00f4b413: "sltiu x8, x9, 15",
            0x0ff5b513: "sltiu x10, x11, 255",
            0xff66b613: "sltiu x12, x13, -10",
            0xf9c7b713: "sltiu x14, x15, -100",
            0xfff8b813: "sltiu x16, x17, -1",
        }
        print("SLTIU: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones XORI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_xori(self):

        mcode_asm = {
            0x0073b313: "sltiu x6, x7, 7",
            0x00f4b413: "sltiu x8, x9, 15",
            0x0ff5b513: "sltiu x10, x11, 255",
            0xff66b613: "sltiu x12, x13, -10",
            0xf9c7b713: "sltiu x14, x15, -100",
            0xfff8b813: "sltiu x16, x17, -1",
        }
        print("XORI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones ORI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_ori(self):

        mcode_asm = {
            0x064fef13:  "ori x30, x31, 100",
            0x0c80e013:  "ori x0, x1, 200",
            0x3e81e113:  "ori x2, x3, 1000",
            0xf382e213:  "ori x4, x5, -200",
            0xed43e313:  "ori x6, x7, -300",
            0xe704e413:  "ori x8, x9, -400",
        }
        print("ORI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones ANDI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_andi(self):

        mcode_asm = {
            0x0015f513:  "andi x10, x11, 1",
            0x0036f613:  "andi x12, x13, 3",
            0x0077f713:  "andi x14, x15, 7",
            0xe0c8f813:  "andi x16, x17, -500",
            0xda89f913:  "andi x18, x19, -600",
            0xd44afa13:  "andi x20, x21, -700",
        }
        print("ANDI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SRLI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_srli(self):

        mcode_asm = {
            0x000bdb13:  "srli x22, x23, 0",
            0x001cdc13:  "srli x24, x25, 1",
            0x002ddd13:  "srli x26, x27, 2",
            0x004ede13:  "srli x28, x29, 4",
            0x008fdf13:  "srli x30, x31, 8",
            0x01015093:  "srli x1, x2, 16",
            0x01f25193:  "srli x3, x4, 31",
        }
        print("SRLI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SRAI  (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_srai(self):

        mcode_asm = {
            0x40035293:  "srai x5, x6, 0",
            0x40145393:  "srai x7, x8, 1",
            0x40255493:  "srai x9, x10, 2",
            0x40465593:  "srai x11, x12, 4",
            0x40875693:  "srai x13, x14, 8",
            0x41085793:  "srai x15, x16, 16",
            0x41f95893:  "srai x17, x18, 31",
        }
        print("SRAI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones LB (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_lb(self):

        mcode_asm = {
            0x00008003:  "lb x0, 0(x1)",
            0x00110083:  "lb x1, 1(x2)",
            0x00220183:  "lb x3, 2(x4)",
            0xfff30283:  "lb x5, -1(x6)",
            0xffe40383:  "lb x7, -2(x8)",
            0xffc50483:  "lb x9, -4(x10)",
        }
        print("LB: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones LH (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_lh(self):

        mcode_asm = {
            0x020c1b83: "lh x23, 32(x24)",
            0x040d1c83: "lh x25, 64(x26)",
            0x080e1d83: "lh x27, 128(x28)",
            0xff8f1e83: "lh x29, -8(x30)",
            0xff001f83: "lh x31, -16(x0)",
            0xfe011083: "lh x1, -32(x2)",
        }
        print("LH: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones LW (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_lw(self):

        mcode_asm = {
            0x00462583:  "lw x11, 4(x12)",
            0x00872683:  "lw x13, 8(x14)",
            0x01082783:  "lw x15, 16(x16)",
            0xff892883:  "lw x17, -8(x18)",
            0xff0a2983:  "lw x19, -16(x20)",
            0xfe0b2a83:  "lw x21, -32(x22)",
        }
        print("LW: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones LBU (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_lbu(self):

        mcode_asm = {
            0x10024183:  "lbu x3, 256(x4)",
            0x20034283:  "lbu x5, 512(x6)",
            0x40044383:  "lbu x7, 1024(x8)",
            0xfc054483:  "lbu x9, -64(x10)",
            0xf8064583:  "lbu x11, -128(x12)",
            0xf0074683:  "lbu x13, -256(x14)",
        }
        print("LBU: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones LHU (TIPO I)
    # ───────────────────────────────────────────────────────
    def test_lhu(self):

        mcode_asm = {
            0x50085783:  "lhu x15, 1280(x16)",
            0x60095883:  "lhu x17, 1536(x18)",
            0x700a5983:  "lhu x19, 1792(x20)",
            0xe00b5a83:  "lhu x21, -512(x22)",
            0xc00c5b83:  "lhu x23, -1024(x24)",
            0x800d5c83:  "lhu x25, -2048(x26)",
        }
        print("LHU: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones ADD (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_add(self):

        mcode_asm = {
            0x00000033:  "add x0, x0, x0",
            0x003100b3:  "add x1, x2, x3",
            0x00628233:  "add x4, x5, x6",
            0x009403b3:  "add x7, x8, x9",
            0x00a50533:  "add x10, x10, x10",
        }
        print("ADD: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SUB (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_sub(self):

        mcode_asm = {
            0x40d605b3:  "sub x11, x12, x13",
            0x41078733:  "sub x14, x15, x16",
            0x413908b3:  "sub x17, x18, x19",
            0x416a8a33:  "sub x20, x21, x22",
            0x419c0bb3:  "sub x23, x24, x25",
        }
        print("SUB: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SLL (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_sll(self):

        mcode_asm = {
            0x01cd9d33:  "sll x26, x27, x28",
            0x01ff1eb3:  "sll x29, x30, x31",
            0x00209033:  "sll x0, x1, x2",
            0x005211b3:  "sll x3, x4, x5",
            0x00839333:  "sll x6, x7, x8",
        }
        print("SLL: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SLT (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_slt(self):

        mcode_asm = {
            0x00b524b3:  "slt x9, x10, x11",
            0x00e6a633:  "slt x12, x13, x14",
            0x011827b3:  "slt x15, x16, x17",
            0x0149a933:  "slt x18, x19, x20",
            0x017b2ab3:  "slt x21, x22, x23",
        }
        print("SLT: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SLTU (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_sltu(self):

        mcode_asm = {
            0x01acbc33:  "sltu x24, x25, x26",
            0x01de3db3:  "sltu x27, x28, x29",
            0x000fbf33:  "sltu x30, x31, x0",
            0x003130b3:  "sltu x1, x2, x3",
            0x0062b233:  "sltu x4, x5, x6",
        }
        print("SLTU: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SRL (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_srl(self):

        mcode_asm = {
            0x009453b3:  "srl x7, x8, x9",
            0x00c5d533:  "srl x10, x11, x12",
            0x00f756b3:  "srl x13, x14, x15",
            0x0128d833:  "srl x16, x17, x18",
            0x015a59b3:  "srl x19, x20, x21",
        }
        print("SRL: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SRA (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_sra(self):

        mcode_asm = {
            0x418bdb33:  "sra x22, x23, x24",
            0x41bd5cb3:  "sra x25, x26, x27",
            0x41eede33:  "sra x28, x29, x30",
            0x40105fb3:  "sra x31, x0, x1",
            0x4041d133:  "sra x2, x3, x4",
        }
        print("SRA: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones XOR (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_xor(self):

        mcode_asm = {
            0x007342b3:  "xor x5, x6, x7",
            0x00a4c433:  "xor x8, x9, x10",
            0x00d645b3:  "xor x11, x12, x13",
            0x0107c733:  "xor x14, x15, x16",
            0x013948b3:  "xor x17, x18, x19",
        }
        print("XOR: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones OR (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_or(self):

        mcode_asm = {
            0x016aea33:  "or x20, x21, x22",
            0x019c6bb3:  "or x23, x24, x25",
            0x01cded33:  "or x26, x27, x28",
            0x01ff6eb3:  "or x29, x30, x31",
            0x0020e033:  "or x0, x1, x2",
        }
        print("OR: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones AND (TIPO R)
    # ───────────────────────────────────────────────────────
    def test_and(self):

        mcode_asm = {
            0x005271b3:  "and x3, x4, x5",
            0x0083f333:  "and x6, x7, x8",
            0x00b574b3:  "and x9, x10, x11",
            0x00e6f633:  "and x12, x13, x14",
            0x011877b3:  "and x15, x16, x17",
        }
        print("AND: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SB (TIPO S)
    # ───────────────────────────────────────────────────────
    def test_sb(self):

        mcode_asm = {
            0x00008023:  "sb x0, 0(x1)",
            0x002180a3:  "sb x2, 1(x3)",
            0x00428123:  "sb x4, 2(x5)",
            0xfe638fa3:  "sb x6, -1(x7)",
            0xfe848f23:  "sb x8, -2(x9)",
            0xfea58e23:  "sb x10, -4(x11)",
        }
        print("SB: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SH (TIPO S)
    # ───────────────────────────────────────────────────────
    def test_sh(self):

        mcode_asm = {
            0x00c69223:  "sh x12, 4(x13)",
            0x00e79423:  "sh x14, 8(x15)",
            0x01089823:  "sh x16, 16(x17)",
            0xff299c23:  "sh x18, -8(x19)",
            0xff4a9823:  "sh x20, -16(x21)",
            0xff6b9023:  "sh x22, -32(x23)",
        }
        print("SH: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones SW (TIPO S)
    # ───────────────────────────────────────────────────────
    def test_sw(self):

        mcode_asm = {
            0x118ca023:  "sw x24, 256(x25)",
            0x21ada023:  "sw x26, 512(x27)",
            0x7fceafa3:  "sw x28, 2047(x29)",
            0xf1efa023:  "sw x30, -256(x31)",
            0xe000a023:  "sw x0, -512(x1)",
            0x8021a023:  "sw x2, -2048(x3)",
        }
        print("SW: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones BEQ (TIPO B)
    # ───────────────────────────────────────────────────────
    def test_beq(self):

        mcode_asm = {
            0x00000063:  "beq x0, x0, 0",
            0xfe100ee3:  "beq x0, x1, -4",
            0xfe208ce3:  "beq x1, x2, -8",
            0x00418263:  "beq x3, x4, 4",
            0x00628463:  "beq x5, x6, 8",
            0x00838663:  "beq x7, x8, 12",
        }
        print("BEQ: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones BNE (TIPO B)
    # ───────────────────────────────────────────────────────
    def test_bne(self):

        mcode_asm = {
            0xfea498e3:  "bne x9, x10, -16",
            0xfec590e3:  "bne x11, x12, -32",
            0xfce690e3:  "bne x13, x14, -64",
            0x03079063:  "bne x15, x16, 32",
            0x05289063:  "bne x17, x18, 64",
            0x09499063:  "bne x19, x20, 128",
        }
        print("BNE: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones BLT (TIPO B)
    # ───────────────────────────────────────────────────────
    def test_blt(self):

        mcode_asm = {
            0xf96ac0e3:  "blt x21, x22, -128",
            0xf18bc0e3:  "blt x23, x24, -256",
            0xe1acc0e3:  "blt x25, x26, -512",
            0x11cdc063:  "blt x27, x28, 256",
            0x21de4063:  "blt x28, x29, 512",
            0x41ff4063:  "blt x30, x31, 1024",
        }
        print("BLT: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones BGE (TIPO B)
    # ───────────────────────────────────────────────────────
    def test_bge(self):

        mcode_asm = {
            0xc01050e3:  "bge x0, x1, -1024",
            0x803152e3:  "bge x2, x3, -2044",
            0x805250e3:  "bge x4, x5, -2048",
            0x7e735e63:  "bge x6, x7, 2044",
            0x7e945c63:  "bge x8, x9, 2040",
            0x7eb55a63:  "bge x10, x11, 2036",
        }
        print("BGE: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones BLTU (TIPO B)
    # ───────────────────────────────────────────────────────
    def test_bltu(self):

        mcode_asm = {
            0x00d66063:  "bltu x12, x13, 0",
            0xfef76ee3:  "bltu x14, x15, -4",
            0xff186ce3:  "bltu x16, x17, -8",
            0x01396263:  "bltu x18, x19, 4",
            0x015a6463:  "bltu x20, x21, 8",
            0x017b6863:  "bltu x22, x23, 16",
        }
        print("BLTU: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instrucciones BGEU (TIPO B)
    # ───────────────────────────────────────────────────────
    def test_bgeu(self):

        mcode_asm = {
            0xff9c78e3:  "bgeu x24, x25, -16",
            0xffbd70e3:  "bgeu x26, x27, -32",
            0xfdde70e3:  "bgeu x28, x29, -64",
            0x03ff7063:  "bgeu x30, x31, 32",
            0x04107063:  "bgeu x0, x1, 64",
            0x08317063:  "bgeu x2, x3, 128",
        }
        print("BGEU: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion LUI (TIPO U)
    # ───────────────────────────────────────────────────────
    def test_lui(self):

        mcode_asm = {
            0x00000037:  "lui x0, 0x0",
            0x0000f0b7:  "lui x1, 0xF",
            0x000ff137:  "lui x2, 0xFF",
            0x00fff1b7:  "lui x3, 0xFFF",
            0x0ffff237:  "lui x4, 0xFFFF",
            0xfffff2b7:  "lui x5, 0xFFFFF",
        }
        print("LUI: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion AUIPC (TIPO U)
    # ───────────────────────────────────────────────────────
    def test_auipc(self):

        mcode_asm = {
            0x00000317:  "auipc x6, 0x0",
            0x0000a397:  "auipc x7, 0xA",
            0x000aa417:  "auipc x8, 0xAA",
            0x00aaa497:  "auipc x9, 0xAAA",
            0x0aaaa517:  "auipc x10, 0xAAAA",
            0xaaaaa597:  "auipc x11, 0xAAAAA",
        }
        print("AUIPC: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion JAL (TIPO J)
    # ───────────────────────────────────────────────────────
    def test_jal(self):

        mcode_asm = {
            0xffdff0ef:  "jal x1, -4",
            0xff9ff16f:  "jal x2, -8",
            0xff1ff1ef:  "jal x3, -16",
            0xfe1ff26f:  "jal x4, -32",
            0xfc1ff2ef:  "jal x5, -64",
            0xf81ff36f:  "jal x6, -128",
            0xf01ff3ef:  "jal x7, -256",
            0xe01ff46f:  "jal x8, -512",
            0xc01ff4ef:  "jal x9, -1024",
            0x801ff56f:  "jal x10, -2048",
            0x800ff5ef:  "jal x11, -4096",
            0x800fe66f:  "jal x12, -8192",
            0x000026ef:  "jal x13, 8192",
            0x0000176f:  "jal x14, 4096",
            0x001007ef:  "jal x15, 2048",
            0x4000086f:  "jal x16, 1024",
            0x200008ef:  "jal x17, 512",
            0x1000096f:  "jal x18, 256",
            0x080009ef:  "jal x19, 128",
            0x04000a6f:  "jal x20, 64",
            0x02000aef:  "jal x21, 32",
            0x01000b6f:  "jal x22, 16",
            0x00800bef:  "jal x23, 8",
            0x00400c6f:  "jal x24, 4",
        }
        print("JAL: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion JALR (TIPO J)
    # ───────────────────────────────────────────────────────
    def test_jalr(self):

        mcode_asm = {
            0x00000067:  "jalr x0, 0(x0)",
            0x00408067:  "jalr x0, 4(x1)",
            0x00818167:  "jalr x2, 8(x3)",
            0x01028267:  "jalr x4, 16(x5)",
            0x02038367:  "jalr x6, 32(x7)",
            0x04048467:  "jalr x8, 64(x9)",
            0x08058567:  "jalr x10, 128(x11)",
            0x10068667:  "jalr x12, 256(x13)",
            0x20078767:  "jalr x14, 512(x15)",
            0x40088867:  "jalr x16, 1024(x17)",
            0x7ff98967:  "jalr x18, 2047(x19)",
            0xffca8a67:  "jalr x20, -4(x21)",
            0xff8b8b67:  "jalr x22, -8(x23)",
            0xff0c8c67:  "jalr x24, -16(x25)",
            0xfe0d8d67:  "jalr x26, -32(x27)",
            0xfc0e8e67:  "jalr x28, -64(x29)",
            0xf80f8f67:  "jalr x30, -128(x31)",
            0xf0008067:  "jalr x0, -256(x1)",
            0xe0018167:  "jalr x2, -512(x3)",
            0xc0028267:  "jalr x4, -1024(x5)",
            0x80038367:  "jalr x6, -2048(x7)",
        }
        print("JALR: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion ECALL
    # ───────────────────────────────────────────────────────
    def test_ecall(self):

        mcode_asm = {
            0x00000073:   "ecall",
            0x00100073:   "ebreak",
            0x00200073:   "uret",
            0x10200073:   "sret",
            0x30200073:   "mret",
            0x10500073:   "wfi",
        }
        print("ECALL: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion CSRRW
    # ───────────────────────────────────────────────────────
    def test_csrrw(self):

        mcode_asm = {
            0x00001073:  "csrrw x0, 0x000, x0",
            0x001110f3:  "csrrw x1, 0x001, x2",
            0x002211f3:  "csrrw x3, 0x002, x4",
            0x004312f3:  "csrrw x5, 0x004, x6",
            0x008413f3:  "csrrw x7, 0x008, x8",
            0x010514f3:  "csrrw x9, 0x010, x10",
            0x040615f3:  "csrrw x11, 0x040, x12",
            0x080716f3:  "csrrw x13, 0x080, x14",
            0x100817f3:  "csrrw x15, 0x100, x16",
            0x400918f3:  "csrrw x17, 0x400, x18",
            0x800a19f3:  "csrrw x19, 0x800, x20",
            0xc00b1af3:  "csrrw x21, 0xC00, x22",
            0xfffc1bf3:  "csrrw x23, 0xFFF, x24",
        }
        print("CSRRW: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion CSRRS
    # ───────────────────────────────────────────────────────
    def test_csrrs(self):

        mcode_asm = {
            0x001d2cf3:  "csrrs x25, 0x001, x26",
            0x010e2df3:  "csrrs x27, 0x010, x28",
            0x100faf73:  "csrrs x30, 0x100, x31",
            0x2000a073:  "csrrs x0, 0x200, x1",
            0x4001a173:  "csrrs x2, 0x400, x3",
            0x8002a273:  "csrrs x4, 0x800, x5",
        }
        print("CSRRS: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion CSRRC
    # ───────────────────────────────────────────────────────
    def test_csrrc(self):

        mcode_asm = {
            0x8013b373:  "csrrc x6, 0x801, x7",
            0x8024b473:  "csrrc x8, 0x802, x9",
            0x8035b573:  "csrrc x10, 0x803, x11",
            0xc016b673:  "csrrc x12, 0xC01, x13",
            0xc027b773:  "csrrc x14, 0xC02, x15",
            0xc038b873:  "csrrc x16, 0xC03, x17",
        }
        print("CSRRC: ", end='')
        self.check_instructions(mcode_asm)
        print()

    # ───────────────────────────────────────────────────────
    #  Probar instruccion CSRRWI
    # ───────────────────────────────────────────────────────
    def test_csrrwi(self):

        mcode_asm = {
            0x00005073:  "csrrwi x0, 0x000, 0x00",
            0x0010d0f3:  "csrrwi x1, 0x001, 0x01",
            0x00215173:  "csrrwi x2, 0x002, 0x02",
            0x003251f3:  "csrrwi x3, 0x003, 0x04",
            0x00445273:  "csrrwi x4, 0x004, 0x08",
            0x005852f3:  "csrrwi x5, 0x005, 0x10",
            0x006fd373:  "csrrwi x6, 0x006, 0x1F",
        }
        print("CSRRWI: ", end='')
        self.check_instructions(mcode_asm)
        print()


if __name__ == "__main__":
    unittest.main()
