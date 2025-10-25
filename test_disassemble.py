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


if __name__ == "__main__":
    unittest.main()
