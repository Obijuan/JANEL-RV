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


if __name__ == "__main__":
    unittest.main()
