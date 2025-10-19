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

inst = InstrRV(ADDI_X1_X2_3)

print(" 31      20 19   15 14   12 11   7 6      0")
print("├──────────┼───────┼───────┼───────┼────────┤")
print("│ imm12    │ rs1   │ func3 │  rd   │ opcode │")
print(f"│ {inst.imm12:#05x}    │ {inst.rs1:02}    │ {inst.func3}  ", end='')
print(f"   │  {inst.rd:02}   │ {inst.opcode:#04x}   │")
print("├──────────┼───────┼───────┼───────┼────────┤")
print("│ᐊ────────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ─────ᐅ│ᐊ──────ᐅ│")
print("     12        5       3       5         7")
print()
