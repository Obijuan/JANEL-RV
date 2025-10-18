#!/usr/bin/env python3
from InstrRV import InstrRV


# ── INSTRUCCIONES para hacer pruebas
ADDI_X0_X0_0 = 0x0000_0013
NOP = ADDI_X0_X0_0


# ─────────────────
#   MAIN
# ─────────────────

# -- Instruccion de prueba
inst = InstrRV(ADDI_X0_X0_0)

# -- Imprimir la instruccion
print(f"* Instruccion: {inst.mcode:#010x}")
print(f"  * Opcode: {inst.opcode:#04x}")
