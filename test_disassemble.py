import unittest
from InstrRV import InstrRV


class TestDisassemble(unittest.TestCase):

    def check_instructions(self, insts: dict):

        # ── Recorrer las instrucciones en codigo máquina a probar
        for mcode in insts.keys():

            # ── Leer la instruccion
            inst = InstrRV(mcode)

            # ── Comprobar la instruccion en ensamblador
            self.assertEqual(inst.to_asm(color=False), insts[mcode])
            print("😀", end='', flush=True)
            # ✅🟢🔵🔹🔸*️⃣😀

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


if __name__ == "__main__":
    unittest.main()
