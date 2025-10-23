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


if __name__ == "__main__":
    unittest.main()
