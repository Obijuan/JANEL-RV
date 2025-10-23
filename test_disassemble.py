import unittest
from InstrRV import InstrRV


class TestDisassemble(unittest.TestCase):

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
            0xfffa_0513: "addi x10, x20, 0xFFF",
            0x7ff2_0193: "addi x3, x4, 0x7FF",
            0x8003_0293: "addi x5, x6, -2048"
        }

        # ── Recorrer las instrucciones en codigo máquina a probar
        for mcode in mcode_asm.keys():

            # ── Leer la instruccion
            inst = InstrRV(mcode)

            # ── Comprobar la instruccion en ensamblador
            self.assertEqual(inst.to_asm(color=False), mcode_asm[mcode])
            print("😀", end='', flush=True)
            # ✅🟢🔵🔹🔸*️⃣😀


if __name__ == "__main__":
    unittest.main()
