package branch_state_pkg;

typedef enum logic [2:0] {
    BEQ = 3'b000,
    BNE = 3'b001,
    BLT = 3'b100,
    BGE = 3'b101,
    BLTU = 3'b110,
    BGEU = 3'b111
} branch_state_t;

endpackage

package alu_state_pkg;

typedef enum logic [2:0] {
    ADDI_ADD_SUB = 3'b000,
    SLTI_SLT = 3'b010,
    SLTIU_SLTU = 3'b011,
    XORI_XOR = 3'b100,
    ORI_OR = 3'b110,
    ANDI_AND = 3'b111,
    SLLI_SLL = 3'b001,
    SRLI_SRAI_SRL_SRA = 3'b101
} alu_state_t;

endpackage

package d_mem_state_pkg;

typedef enum logic [2:0] {
    SB = 3'b000,
    SH = 3'b001,
    SW = 3'b010
} d_mem_wr_state_t;

typedef enum logic [2:0] {
    LB = 3'b000,
    LH = 3'b001,
    LW = 3'b010,
    LBU = 3'b100,
    LHU = 3'b101
} d_mem_rd_state_t;


endpackage

package opcodes_pkg;

typedef enum logic [6:0] {
LB_LH_LW_LBU_LHU = 7'b0000011,
SB_SH_SW = 7'b0100011,
AUIPC = 7'b0010111,
LUI = 7'b0110111,
JAL = 7'b1101111,
JALR = 7'b1100111,
ALU_1_OP = 7'b0010011,
BRANCH = 7'b1100011,
ALU_2_OP = 7'b0110011
} opcodes_t; 

endpackage
