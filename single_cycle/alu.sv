import alu_state_pkg::*;

module alu(input signed [31:0] operand_1, input signed [31:0] operand_2, input [4:0] shift_amount, input ctrl_sig_pkg::ctrl_sigs_t control_sigs, input [2:0] func_3_bits, input logic func_7_bit, output logic signed [31:0] result);
// default RV32I only uses the 6th bit for a few instructions, could likely use that single bit to minimize bus widths instead of using func_7_bits

// rs2 is used for shifts

// Need to compute the effective addresses in the ALU

// Need to decide whether operands and output should be signed or unsigned

always_comb begin : ALU
    result = 32'd0;
    if (control_sigs.load_sig || control_sigs.store_sig || control_sigs.branch_sig || control_sigs.jal_sig || control_sigs.jalr_sig || control_sigs.auipc_sig) begin // all are signed
        result = operand_1 + operand_2; // computes the offset 
        // branch and JAL use PC + immediate
        // store and load use the base address plus the offset
        if (control_sigs.jalr_sig) begin
            result = result & ~32'd1;
        end // Need to implement the PC + 4 for JAL and JALR
    end 
    else begin
        case(alu_state_pkg::alu_state_t'(func_3_bits))
            ADDI_ADD_SUB: begin // ADDI, and ADD & SUB
                if (func_7_bit) begin
                    result = operand_1 - operand_2;
                end
                else begin
                    result = operand_1 + operand_2;
                end
            end
            SLTI_SLT: begin // SLTI and SLT
                result = ($signed(operand_1) < $signed(operand_2)) ? 32'd1 : 32'd0;
            end
            SLTIU_SLTU: begin // SLTIU and SLTU, may need to change this to unsigned comparison
                result = (operand_1 < operand_2) ? 32'd1 : 32'd0;
            end
            XORI_XOR: begin // XORI & XOR
                result = operand_1 ^ operand_2;
            end 
            ORI_OR: begin // ORI and OR
                result = operand_1 | operand_2;
            end 
            ANDI_AND: begin // ANDI and AND 
                result = operand_1 & operand_2;
            end 
            SLLI_SLL: begin // SLLI and SLL: logical left shift
                result = operand_1 << shift_amount; // need to add zeros
            end
            SRLI_SRAI_SRL_SRA: begin // SRLI, SRAI and SRL and SRA: logical right shift and arithmetic right shift
                if (func_7_bit) begin // SRAI and SRA
                    result = $signed(operand_1) >>> shift_amount; // need to replicate the sign bit
                end 
                else begin // SRLI and SRL
                    result = operand_1 >> shift_amount; // need to add zeros
                end
            end
            default: result = 32'd0;
        endcase
    end
end


endmodule
