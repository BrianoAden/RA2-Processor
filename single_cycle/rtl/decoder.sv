module decoder
import opcodes_pkg::*;
(input logic [31:0] instruction_in, output logic [4:0] dest_reg_out, output logic [2:0] function_3_bits_out, 
output logic [6:0] function_7_bits_out, output logic [4:0] source_reg_1_out, output logic [4:0] source_reg_2_out, 
output logic [31:0] immediate_out, output ctrl_sig_pkg::ctrl_sigs_t control_sigs);
    

logic [6:0] opcode;

always_comb begin : decoderImplementation
    control_sigs.branch_sig = 1'b0;
    control_sigs.load_sig = 1'b0;
    control_sigs.store_sig = 1'b0;
    control_sigs.jal_sig = 1'b0;
    control_sigs.jalr_sig = 1'b0;
    control_sigs.ALU_1_op_sig = 1'b0;
    control_sigs.ALU_2_op_sig = 1'b0;
    control_sigs.reg_write = 1'b0;
    control_sigs.auipc_sig = 1'b0;
    control_sigs.lui_sig = 1'b0;
    immediate_out = 32'd0;

    opcode = instruction_in [6:0];
    dest_reg_out [4:0] = instruction_in [11:7];
    function_3_bits_out [2:0] = instruction_in [14:12];
    function_7_bits_out [6:0] = instruction_in [31:25];
    source_reg_1_out [4:0] = instruction_in [19:15];
    source_reg_2_out [4:0] = instruction_in [24:20];

// Need to figure out what to do for fence and pause and ecall and ebreak
    case(opcodes_pkg::opcodes_t'(opcode))
        LB_LH_LW_LBU_LHU: begin
            immediate_out[31:0] = {{20{instruction_in[31]}}, instruction_in[31:20]};
            control_sigs.load_sig = 1'b1;
            control_sigs.reg_write = 1'b1;
        end
        ALU_1_OP: begin
            immediate_out[31:0] = {{20{instruction_in[31]}}, instruction_in[31:20]};
            control_sigs.ALU_1_op_sig = 1'b1;
            control_sigs.reg_write = 1'b1;
        end
        ALU_2_OP: begin
            control_sigs.reg_write = 1'b1;
            control_sigs.ALU_2_op_sig = 1'b1;
        end
        JALR: begin
            /*
            rd = PC + 4
            PC = (rs1 + offset) & ~1   i.e. rs1_data + immediate
            */
            immediate_out[31:0] = {{20{instruction_in[31]}}, instruction_in[31:20]};
            control_sigs.jalr_sig = 1'b1;
            control_sigs.reg_write = 1'b1;
        end
        SB_SH_SW: begin
            immediate_out[31:0] = {{20{instruction_in[31]}}, instruction_in[31:25], instruction_in[11:7]};
            control_sigs.store_sig = 1'b1;
        end
        AUIPC: begin // rd = PC + (imm << 12)
            immediate_out[31:0] = {instruction_in[31:12], 12'b0};
            control_sigs.reg_write = 1'b1;
            control_sigs.auipc_sig = 1'b1;
        end
        LUI: begin //rd = imm << 12
            immediate_out[31:0] = {instruction_in[31:12], 12'b0};
            control_sigs.reg_write = 1'b1;
            control_sigs.lui_sig = 1'b1;
        end
        BRANCH: begin
            immediate_out[31:0] = {{19{instruction_in[31]}}, instruction_in[31], instruction_in[7], instruction_in[30:25], instruction_in[11:8], 1'b0};
            control_sigs.branch_sig = 1'b1;
        end
        JAL: begin
            /*
            rd = PC + 4
            PC = PC + offset     i.e. PC + immediate
            */
            immediate_out[31:0] = {{11{instruction_in[31]}}, instruction_in[31], instruction_in[19:12], instruction_in[20], instruction_in[30:21], 1'b0};
            control_sigs.jal_sig = 1'b1;
            control_sigs.reg_write = 1'b1;
        end
        default: begin
            immediate_out[31:0] = 32'd0;
        end
    endcase

end

endmodule
