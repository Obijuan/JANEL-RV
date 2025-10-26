import ansi
"""
──────────────────────────────────────────────────────
  DOCUMENTACION SOBRE EL FORMATO DEL RISC-V
──────────────────────────────────────────────────────
https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html


 TIPO I: Instrucciones aritméticas y de carga
 * addi, slli, slti, sltiu, xori, srli, srai, ori, andi
 * lb, lh, lw, ld, lbu, lhu, lwu

 * addi rd, rs1, imm12  -->  rd = rs1 + ext(imm12)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5 4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│      imm12            |   rs1   |func3|   rd      |    opcode   |
├───────────────────────┼─────────┼─────┼───────────┼─────────────┤
|<─────────────────────>|<───────>|<───>|<─────────>|<───────────>|
          12                 5       3        5           7



 TIPO R: Hay 3 registros
* add, sub, sll, slt, sltu, srl, sra, xor, or, and

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│    func7    │  rs2    |   rs1   |func3|   rd      |   opcode    |
├─────────────┼─────────┴─────────┴─────┴───────────┴─────────────┤
|<───────────>|<───────>|<───────>|<───>|<─────────>|<───────────>|
       7           5         5       3        5            7

* add rd, rs1, rs2  -->  rd = rs1 + rs2


TIPO S: Instrucciones store (Ex. sw, sb....)
* sw, sh, sb, sd

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│ offset[11:5]│  rs2    |   rs1   |func3| off[4:0]  |   opcode    |
│ offset1     │         |         |     | offset0   |             |
├─────────────┼─────────┼─────────┼─────┼───────────┼─────────────┤
|<───────────>|<───────>|<───────>|<───>|<─────────>|<───────────>|
       7           5         5       3        5            7


TIPO B: Instrucciones de salto condicional (Ex. beq, blt...)

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
│1 0 9 8 7 6 5│4 3 2 1 0│9 8 7 6 5│4 3 2│1 0 9 8 7  │6 5 4 3 2 1 0│
├─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴───┼─┴─┴─┴─┴─┴─┴─┤
│ off[12|10:5]│  rs2    |   rs1   |func3|off[4:1|11]|   opcode    |
│ offset1     │         |         |     | offset0   |             |
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

    # ── FUNC7
    FUNC7_POS = 25
    FUNC7_SIZE = 0b111_1111
    FUNC7_MASK = FUNC7_SIZE << FUNC7_POS

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

    # ──────── CONSTANTES PARA DEFINIR EL TIPO DE INSTRUCCION
    TYPE_I_ARITH = 'I_ARITH'  # Instrucciones tipo I aritmeticas
    TYPE_I_LOAD = 'I_LOAD'    # Instrucciones tipo I de carga
    TYPE_R = 'R'              # Instrucciones tipo R
    TYPE_S = 'S'              # Instrucciones tipo S
    TYPE_B = 'B'              # Instrucciones tipo B
    TYPE_U_LUI = 'U_LUI'      # Instrucciones tipo U LUI
    TYPE_U_AUIPC = 'U_AUIPC'  # Instrucciones tipo U AUIPC
    TYPE_J_JAL = 'J_JAL'      # Instrucciones tipo J JAL
    TYPE_J_JALR = 'J_JALR'    # Instrucciones tipo J JALR
    TYPE_ECALL_EBREAK = 'ECALL'  # Instrucciones ECALL y EBREAK
    TYPE_UNKNOWN = 'UNKNOWN'  # Tipo desconocido
    TYPE = {
        0b_00100_11: TYPE_I_ARITH,  # ADDI, ANDI, XORI, ORI,
                                    # SLTI, SLTIU, SLLI, SRLI, SRAI
        0b_00000_11: TYPE_I_LOAD,   # LB, LH, LW, LD, LBU, LHU, LWU
        0b_01100_11: TYPE_R,        # ADD, SUB, AND, OR, XOR,
                                    # SLT, SLTU, SLL, SRL, SRA
        0b_01000_11: TYPE_S,           # SW, SH, SB, SD
        0b_11000_11: TYPE_B,           # BEQ, BNE, BLT, BGE, BLTU, BGEU
        0b_01101_11: TYPE_U_LUI,       # LUI
        0b_00101_11: TYPE_U_AUIPC,     # AUIPC
        0b_11011_11: TYPE_J_JAL,       # JAL
        0b_11001_11: TYPE_J_JALR,      # JALR
        0b_11100_11: TYPE_ECALL_EBREAK,  # ECALL, EBREAK
    }

    # ──────── DICCIONARIO PARA OBTENER el nemonico de las instrucciones
    # ──────── de typo I aritmeticas a partir de func3
    type_i_arith_nemonic = {
        0b000: 'addi',
        0b001: 'slli',
        0b010: 'slti',
        0b011: 'sltiu',
        0b100: 'xori',
        0b101: 'srli',  # -- y srai
        0b110: 'ori',
        0b111: 'andi',
    }

    # ──────── DICCIONARIO PARA OBTENER el nemonico de las instrucciones
    # ──────── de typo I LOAD a partir de func3
    type_i_load_nemonic = {
        0b000: 'lb',
        0b001: 'lh',
        0b010: 'lw',
        0b011: 'ld',
        0b100: 'lbu',
        0b101: 'lhu',
        0b110: 'lwu',
        0b111: 'UNKNOWN2'
    }

    # ──────── DICCIONARIO PARA OBTENER el nemonico de las instrucciones
    # ──────── de typo R a partir de func3
    type_r_nemonic = {
        0b000: 'add',    # -- sub
        0b001: 'sll',
        0b010: 'slt',
        0b011: 'sltu',
        0b100: 'xor',
        0b101: 'srl',    # -- sra
        0b110: 'or',
        0b111: 'and'
    }

    # ──────── DICCIONARIO PARA OBTENER el nemonico de las instrucciones
    # ──────── de typo S a partir de func3
    type_s_nemonic = {
        0b000: 'sb',
        0b001: 'sh',
        0b010: 'sw',
        0b011: 'sd',
    }

    # ──────── DICCIONARIO PARA OBTENER el nemonico de las instrucciones
    # ──────── de typo S a partir de func3
    type_b_nemonic = {
        0b000: 'beq',
        0b001: 'bne',
        0b100: 'blt',
        0b101: 'bge',
        0b110: 'bltu',
        0b111: 'bgeu',
    }

    # ─────────────────────────────────────────────
    #   CONSTRUCTOR a partir del codigo maquina
    # ─────────────────────────────────────────────
    def __init__(self, mcode: int) -> None:

        # ── Codigo maquina de la instruccion
        self.mcode = mcode

        # ── Determinar el Tipo de instrucción
        self.opcode = self.get_opcode()
        try:
            self.type = InstrRV.TYPE[self.opcode]
        except KeyError:
            self.type = 'UNKNOWN'

        # ── Obtener el resto de propiedades en funcion del
        # ── tipo de instrucción
        match self.type:
            case InstrRV.TYPE_I_ARITH:

                # ── Obtener el campo func3
                self.func3 = self.get_func3()

                # ── Obtener el campo imm12
                self.imm12 = self.get_imm12()

                # ── Obtener el bit 10 del valor inmediato
                imm12_bit10 = (self.imm12 >> 10) & 0b1

                # ── Obtener el nemonico
                self.nemonic = self.get_type_i_arith_nemonic(self.func3,
                                                             imm12_bit10)

                # ── Obtener el registro destino
                self.rd = self.get_rd()

                # ── Obtener el registro fuente 1
                self.rs1 = self.get_rs1()

                # ── Obtener el valor inmediato como una palabra del sistema
                self.imm = self.ext_sign12(self.imm12)

            case InstrRV.TYPE_I_LOAD:

                # ── Obtener el campo func3
                self.func3 = self.get_func3()

                # ── Obtener el campo imm12
                self.imm12 = self.get_imm12()

                # ── Obtener el nemonico
                self.nemonic = self.type_i_load_nemonic[self.func3]

                # ── Obtener el registro destino
                self.rd = self.get_rd()

                # ── Obtener el registro fuente 1
                self.rs1 = self.get_rs1()

                # ── Obtener el valor inmediato como una palabra del sistema
                self.imm = self.ext_sign12(self.imm12)

            case InstrRV.TYPE_R:

                # ── Obtener el campo func7
                self.func7 = self.get_func7()

                # ── Obtener el campo func3
                self.func3 = self.get_func3()

                # ── Obtener el registro destino
                self.rd = self.get_rd()

                # ── Obtener el registro fuente 1
                self.rs1 = self.get_rs1()

                # ── Obtener el registro fuente 2
                self.rs2 = self.get_rs2()

                # ── Obtener el nemonico
                self.nemonic = self.get_type_r_nemonic(self.func3, self.func7)

            case InstrRV.TYPE_S:

                # ── Obtener el campo func3
                self.func3 = self.get_func3()

                # ── Obtener el nemonico
                self.nemonic = self.type_s_nemonic[self.func3]

                # ── Obtener el registro fuente 1
                self.rs1 = self.get_rs1()

                # ── Obtener el registro fuente 2
                self.rs2 = self.get_rs2()

                # ── Obtener el campo offset1
                # ── (que ocupa los mismos bits que func7)
                self.offset1 = self.get_func7()

                # ── Obtener el campo offset0
                # ─ (que ocupa los mismos bits que rd)
                self.offset0 = self.get_rd()

                # ── Calcular el offset completo
                offset = self.offset1 << 5 | self.offset0
                self.offset = self.ext_sign12(offset)

            case InstrRV.TYPE_B:

                # ── Obtener el campo func3
                self.func3 = self.get_func3()

                # ── Obtener el nemonico
                self.nemonic = self.type_b_nemonic[self.func3]

                # ── Obtener el registro fuente 1
                self.rs1 = self.get_rs1()

                # ── Obtener el registro fuente 2
                self.rs2 = self.get_rs2()

                # ── Obtener el campo offset1
                # ── (que ocupa los mismos bits que func7)
                self.offset1 = self.get_func7()

                # ── Obtener el campo offset0
                # ─ (que ocupa los mismos bits que rd)
                self.offset0 = self.get_rd()

                # ── Construir el offset final a partir de las partes
                self.offset = self.get_offset_b()

            case _:
                print("-----> TODO <-------------")

    # ────────────────────────────────────────────────────────────
    #   Obtener el campo offset de las instrucciones B
    # ────────────────────────────────────────────────────────────
    def get_offset_b(self) -> int:

        # ── Extraer el bit de signo
        sign = (self.offset1 & 0b100_0000) >> 6

        # ── Extraer el bit 11 (bit 0 de offset0)
        b11 = (self.offset0 & 0b0000_0001) >> 0

        # ── Extraer bits 10:5 (6 bits)
        bit10_5 = (self.offset1 & 0b011_1111)

        # ── Extraer bits 4:1 (4 bits)
        bit4_1 = self.offset0 >> 1

        # ── Construir el offset final
        offset = (sign << 12) | (b11 << 11) | (bit10_5 << 5) | (bit4_1) << 1

        # ── Extender el signo
        offset = self.ext_sign13(offset)

        return offset

    # ────────────────────────────────────────────────────────────
    #   Obtener el nemonico de la instruccion aritmetica de tipo I
    # ────────────────────────────────────────────────────────────
    def get_type_i_arith_nemonic(self, func3: int, imm12_bit10: int) -> str:

        # ── Obtener el nemonico
        nemonic = self.type_i_arith_nemonic[func3]

        # ── Caso especial: Instructiones SRLI y SRAI
        # ── Solo importan los 5 bits de menor peso
        if func3 == 0b101:
            self.imm12 = self.imm12 & 0x1F

        # ── Caso especial: SRAI
        if func3 == 0b101 and imm12_bit10 == 1:
            nemonic = 'srai'

        return nemonic

    # ────────────────────────────────────────────────────────────
    #   Obtener el nemonico de la instruccion de tipo R
    # ────────────────────────────────────────────────────────────
    def get_type_r_nemonic(self, func3: int, func7: int) -> str:

        # ── Obtener el nemonico
        nemonic = self.type_r_nemonic[self.func3]

        # ── Obtener el bit 5 de func7
        especial = (func7 & (1 << 5)) >> 5

        # ── Instrucciones definidas por func7
        if especial == 1:
            nemonic = 'sub' if func3 == 0b_000 else \
                      'sra' if func3 == 0b_101 else \
                      'UNKNOWN'

        return nemonic

    # ────────────────────────────────────────────────────────────
    #   Extension de signo del imm12
    # ────────────────────────────────────────────────────────────
    def ext_sign12(self, imm12) -> int:

        # ─── Obtener el bit de signo (bit 11)
        sign = imm12 & (1 << 11)
        if sign == 0:
            return imm12
        else:
            return imm12 - (2 ** 12)

    # ────────────────────────────────────────────────────────────
    #   Extension de signo de un numero de 13 bits
    # ────────────────────────────────────────────────────────────
    def ext_sign13(self, value13) -> int:

        # ─── Obtener el bit de signo (bit 12)
        sign = value13 & (1 << 12)
        if sign == 0:
            return value13
        else:
            return value13 - (2 ** 13)

    # ────────────────────────────────────────────────────────────
    #   opcode de una instrucción en código máquina
    # ────────────────────────────────────────────────────────────
    def get_opcode(self) -> int:

        # ── Obtener el codigo de operacion y devolverlo
        opcode = (self.mcode & InstrRV.OPCODE_MASK) >> InstrRV.OPCODE_POS
        return opcode

    # ─────────────────────
    #  Func3
    # ─────────────────────
    def get_func3(self) -> int:

        # ── Obtener el campo func3 y devolverlo
        func3 = (self.mcode & InstrRV.FUNC3_MASK) >> InstrRV.FUNC3_POS
        return func3

    # ─────────────────────
    #  Func7
    # ─────────────────────
    def get_func7(self) -> int:

        # ── Obtener el campo func7 y devolverlo
        func7 = (self.mcode & InstrRV.FUNC7_MASK) >> InstrRV.FUNC7_POS
        return func7

    # ────────────────────
    #  Registro destino
    # ────────────────────
    def get_rd(self) -> int:

        # ── Obtener el registro destino y devolverlo
        rd = (self.mcode & InstrRV.RD_MASK) >> InstrRV.RD_POS
        return rd

    # ─────────────────────
    #  Registro fuente 1
    # ─────────────────────
    def get_rs1(self) -> int:

        # ── Obtener el registro fuente 1 y devolverlo
        rs1 = (self.mcode & InstrRV.RS1_MASK) >> InstrRV.RS1_POS
        return rs1

    # ─────────────────────
    #  Registro fuente 2
    # ─────────────────────
    def get_rs2(self) -> int:

        # ── Obtener el registro fuente 2 y devolverlo
        rs2 = (self.mcode & InstrRV.RS2_MASK) >> InstrRV.RS2_POS
        return rs2

    # ──────────────────────────────
    #  Valor immediato de 12 bits
    # ──────────────────────────────
    def get_imm12(self) -> int:

        # ── Obtener el immediato de 12 bits y devolverlo
        imm12 = (self.mcode & InstrRV.IMM12_MASK) >> InstrRV.IMM12_POS
        return imm12

    # ───────────────────────────────────────────────────────
    #  Devolver la cadena con la instruccion en ensamblador
    # ───────────────────────────────────────────────────────
    def to_asm(self, color=True) -> str:

        match self.type:

            case InstrRV.TYPE_I_ARITH:
                asm = f"{ansi.YELLOW}{self.nemonic} "\
                    f"{ansi.CYAN}x{self.rd}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.CYAN}x{self.rs1}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.GREEN}{self.imm}{ansi.RESET}"
                asm_bw = f"{self.nemonic} x{self.rd}, x{self.rs1}, {self.imm}"

            case InstrRV.TYPE_I_LOAD:
                asm = f"{ansi.YELLOW}{self.nemonic} "\
                    f"{ansi.CYAN}x{self.rd}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.GREEN}{self.imm}"\
                    f"{ansi.RESET}("\
                    f"{ansi.CYAN}x{self.rs1}"\
                    f"{ansi.RESET})"

                asm_bw = f"{self.nemonic} x{self.rd}, {self.imm}(x{self.rs1})"

            case InstrRV.TYPE_R:
                asm = f"{ansi.YELLOW}{self.nemonic} "\
                    f"{ansi.CYAN}x{self.rd}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.CYAN}x{self.rs1}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.CYAN}x{self.rs2}"\
                    f"{ansi.RESET}"
                asm_bw = f"{self.nemonic} x{self.rd}, x{self.rs1}, x{self.rs2}"

            case InstrRV.TYPE_S:
                asm = f"{ansi.YELLOW}{self.nemonic} "\
                    f"{ansi.CYAN}x{self.rs2}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.GREEN}{self.offset}"\
                    f"{ansi.RESET}("\
                    f"{ansi.CYAN}x{self.rs1}"\
                    f"{ansi.RESET})"
                asm_bw = f"{self.nemonic} x{self.rs2}, "\
                         f"{self.offset}(x{self.rs1})"

            case InstrRV.TYPE_B:
                asm = f"{ansi.YELLOW}{self.nemonic} "\
                    f"{ansi.CYAN}x{self.rs1}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.CYAN}x{self.rs2}"\
                    f"{ansi.RESET}, "\
                    f"{ansi.GREEN}{self.offset}"\
                    f"{ansi.RESET}"
                asm_bw = f"{self.nemonic} x{self.rs1}, "\
                         f"x{self.rs2}, {self.offset}"

            case _:
                return "UNKNOWN"

        return asm if color else asm_bw

    # ────────────────────────────────
    #  DEBUG! Imprimir la instruccion
    # ────────────────────────────────
    def debug(self, color=True) -> None:
        print(f"🔸 {self.mcode:#010x}  {self.to_asm(color=color)}")
