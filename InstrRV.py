"""
──────────────────────────────────────────────────────
  DOCUMENTACION SOBRE EL FORMATO DEL RISC-V
──────────────────────────────────────────────────────
https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html


 TIPO I: Instrucciones aritméticas y de carga (Ex. addi, lw)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5 4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│      imm12            |   rs1   |func3|   rd      |    opcode   |
├───────────────────────┼─────────┼─────┼───────────┼─────────────┤
|<─────── 12 ──────────>|◀───────▶|<─3─>|<─── 5 ───>|<──── 7 ────>|

* addi rd, rs1, imm12  -->  rd = rs1 + ext(imm12)


 TIPO R: Hay 3 registros (Ex. add, sub)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│    func7    │  rs2    |   rs1   |func3|   rd      |   opcode    |
╰─────────────┴─────────┴─────────┴─────┴───────────┴─────────────╯


TIPO S: Instrucciones store (Ex. sw, sb....)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│ offset[11:5]│  rs2    |   rs1   |func3| off[4:0]  |   opcode    |
╰─────────────┴─────────┴─────────┴─────┴───────────┴─────────────╯


TIPO B: Instrucciones de salto condicional (Ex. beq, blt...)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│ off[12|10:5]│  rs2    |   rs1   |func3|off[4:1|11]|   opcode    |
╰─────────────┴─────────┴─────────┴─────┴───────────┴─────────────╯


TIPO U: Instrucciones de tipo UPPER (Ex. lui, auipc)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│              imm[31:12]               |    rd     |    opcode   |
╰───────────────────────────────────────┴───────────┴─────────────╯


TIPO J: Salto incondicional (Ex. jal)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2│1 0 9 8  7 │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴──┴──┼─┴─┴─┴─┴─┴─┴─┤
│        offset[20|10:1|11|19:12]       |    rd     |    opcode   |
╰───────────────────────────────────────┴───────────┴─────────────╯


TIPO ECALL

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7│6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┤
│    0        │  func5  |    0    | 0   |   0     |   opcode    |
╰─────────────┴─────────┴─────────┴─────┴─────────┴─────────────╯
"""
"""
    //-- TODO
    //----- Modo privilegiado
    //-- csrrw
    //-- csrrs
    //-- csrrc
    //-- csrrwi
    //-- csrrsi
    //-- csrrci
    //-- uret
    //-- sret
    //-- mret
    //-- wfi
    //-- fence
    //-- fence.i
    //-- sfence.vma
    //----RV64I
    //-- addiw
    //-- slliw
    //-- srliw
    //-- sraiw
    //-- addw
    //-- subw
    //-- sllw
    //-- srlw
    //-- sraw
    //-- lwu
"""


# ───────────────────────────────────────────────────────
#   Clase para representar una instruccion del RISCV
# ───────────────────────────────────────────────────────
class InstrRV:

    # ──────── CONSTANTES PARA DEFINIR LOS PARAMETROS DE LA ISA RISC-V
    # ── Las posiciones de los campos indican el numero de bit donde
    # ── se situa el bit de MENOR PESO
    # ── El tamaño se condifica en UNARIO. Si un campo ocupa 3 bits,
    # ── su tamaño en unario es 111

    # ── OPCODE
    OPCODE_POS = 0
    OPCODE_SIZE = 0b111_1111
    OPCODE_MASK = OPCODE_SIZE << OPCODE_POS

    # ── FUNC3
    FUNC3_POS = 12
    FUNC3_SIZE = 0b111
    FUNC3_MASK = FUNC3_SIZE << FUNC3_POS

    # ── RD: Registro destino
    RD_POS = 7
    RD_SIZE = 0b1_1111
    RD_MASK = RD_SIZE << RD_POS

    # ── RS1: Registro fuente 1
    RS1_POS = 15
    RS1_SIZE = 0b1_1111
    RS1_MASK = RS1_SIZE << RS1_POS

    # ── RS2: Registro fuente 2
    RS2_POS = 20
    RS2_SIZE = 0b1_1111
    RS2_MASK = RS2_SIZE << RS2_POS

    # ── IMM12: Inmediato de 12 bits (TIPO I)
    IMM12_POS = 20
    IMM12_SIZE = 0b1111_1111_1111
    IMM12_MASK = IMM12_SIZE << IMM12_POS

    # ─────────────────────────────────────────────
    #   CONSTRUCTOR a partir del codigo maquina
    # ─────────────────────────────────────────────
    def __init__(self, mcode: int) -> None:

        # ── Codigo maquina de la instruccion
        self.mcode = mcode

    # ────────────────────────────────────────────────────────────
    #   opcode de una instrucción en código máquina
    # ────────────────────────────────────────────────────────────
    @property
    def opcode(self) -> int:

        # ── Obtener el codigo de operacion y devolverlo
        opcode = (self.mcode & InstrRV.OPCODE_MASK) >> InstrRV.OPCODE_POS
        return opcode

    # ─────────────────────
    #  Func3
    # ─────────────────────
    @property
    def func3(self) -> int:

        # ── Obtener el campo func3 y devolverlo
        func3 = (self.mcode & InstrRV.FUNC3_MASK) >> InstrRV.FUNC3_POS
        return func3

    # ────────────────────
    #  Registro destino
    # ────────────────────
    @property
    def rd(self) -> int:

        # ── Obtener el registro destino y devolverlo
        rd = (self.mcode & InstrRV.RD_MASK) >> InstrRV.RD_POS
        return rd

    # ─────────────────────
    #  Registro fuente 1
    # ─────────────────────
    @property
    def rs1(self) -> int:

        # ── Obtener el registro fuente 1 y devolverlo
        rs1 = (self.mcode & InstrRV.RS1_MASK) >> InstrRV.RS1_POS
        return rs1

    # ──────────────────────────────
    #  Valor immediato de 12 bits
    # ──────────────────────────────
    @property
    def imm12(self) -> int:

        # ── Obtener el immediato de 12 bits y devolverlo
        imm12 = (self.mcode & InstrRV.IMM12_MASK) >> InstrRV.IMM12_POS
        return imm12

    # ────────────────────────────────
    #  DEBUG! Imprimir la instruccion
    # ────────────────────────────────
    def debug(self):
        print(f"🟢 Instruccion: {self.mcode:#010x}")
        print(f"  • Opcode: {self.opcode:#04x}")
        print(f"  • Func3: {self.func3:#05b}")
        print(f"  • Rd: x{self.rd}")
        print(f"  • Rs1: x{self.rs1}")
        print(f"  • Imm12: {self.imm12:#05x}")
        print()
