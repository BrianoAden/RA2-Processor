module alu(input [31:0] operand_1, input [31:0] operand_2, input alu_1_op, input alu_2_op, input [2:0] func_3_bits, input [6:0] func_7_bits, output [31:0] result);

//default RV32I only uses the 6th bit for a few instructions, could likely use that single bit to minimize bus widths instead of using func_7_bits

always_comb begin : ALU
    if (alu_1_op) begin
        case()


        endcase
    end 
    else if (alu_2_op) begin
        case()

        endcase
    end 
    else begin
        case()

        endcase
    end
end


endmodule