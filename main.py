#!/usr/bin/env python3
from InstrRV import InstrRV


# ── INSTRUCCIONES para hacer pruebas
ADDI_X0_X0_0 = 0x0000_0013
ADDI_X1_X2_3 = 0x0031_0093


# ─────────────────
#   MAIN
# ─────────────────

print()

# -- Instruccion de prueba
InstrRV(ADDI_X0_X0_0).debug()
InstrRV(ADDI_X1_X2_3).debug()
