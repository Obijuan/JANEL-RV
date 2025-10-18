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
╰───────────────────────┼─────────┼─────┼───────────┼─────────────┤
<─────── 12 ───────────>|<── 5 ──>|<─3─>|<─── 5 ───>|<──── 7 ────>|


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

    # ── RD: Registro destino
    RD_POS = 7
    RD_SIZE = 0b1_1111
    RD_MASK = RD_SIZE << RD_POS

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

    # ────────────────────
    #  Registro destino
    # ────────────────────
    @property
    def rd(self) -> int:

        # ── Obtener el registro destino y devolverlo
        rd = (self.mcode & InstrRV.RD_MASK) >> InstrRV.RD_POS
        return rd

    # ────────────────────────────────
    #  DEBUG! Imprimir la instruccion
    # ────────────────────────────────
    def debug(self):
        print(f"* Instruccion: {self.mcode:#010x}")
        print(f"  * Opcode: {self.opcode:#04x}")
        print(f"  * Rd: x{self.rd}")
        print()
