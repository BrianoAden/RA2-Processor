typedef struct packed {
    logic branch_sig;
    logic load_sig;
    logic store_sig;
    logic jal_sig;
    logic jalr_sig;
    logic ALU_1_op_sig;
    logic ALU_2_op_sig;
} alu_control_signals_struct;

module alu(input [31:0] operand_1, input [31:0] operand_2, input [4:0] shift_amount, input alu_control_signals_struct control_sigs, input [2:0] func_3_bits, input func_7_bit, output logic [31:0] result);

// default RV32I only uses the 6th bit for a few instructions, could likely use that single bit to minimize bus widths instead of using func_7_bits

// rs2 is used for shifts

// Need to compute the effective addresses in the ALU

always_comb begin : ALU
    result = 32'd0;
    if (control_sigs.load_sig || control_sigs.store_sig || control_sigs.branch_sig || control_sigs.jal_sig || control_sigs.jalr_sig) begin // all are signed
        result = operand_1 + operand_2; // computes the offset 
    end else begin
        case(func_3_bits)
            3'b000: begin // ADDI, and ADD & SUB
                if (func_7_bit) begin
                    result = operand_1 - operand_2;
                end
                else begin
                    result = operand_1 + operand_2;
                end
            end
            3'b010: begin // SLTI and SLT
                result = ($signed(operand_1) < $signed(operand_2)) ? 32'd1 : 32'd0;
            end
            3'b011: begin // SLTIU and SLTU
                result = (operand_1 < operand_2) ? 32'd1 : 32'd0;
            end
            3'b100: begin // XORI & XOR
                result = operand_1 ^ operand_2;
            end 
            3'b110: begin // ORI and OR
                result = operand_1 | operand_2;
            end 
            3'b111: begin // ANDI and AND 
                result = operand_1 & operand_2;
            end 
            3'b001: begin // SLLI and SLL: logical left shift
                result = operand_1 << shift_amount; // need to add zeros
            end
            3'b101: begin // SRLI, SRAI and SRL and SRA: logical right shift and arithmetic right shift
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