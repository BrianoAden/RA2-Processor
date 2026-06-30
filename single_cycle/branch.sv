import branch_state_pkg::*;

module branch(input logic branch_signal, input logic [2:0] func_3bits, input logic [31:0] source_reg_1_in, input logic [31:0] source_reg_2_in, output logic branch_taken);

always_comb begin: branchUnit

    branch_taken = 1'b0;

    if (branch_signal) begin
        case (branch_state_pkg::branch_state_t'(func_3bits))
            BEQ: begin // BEQ
                branch_taken = (source_reg_1_in == source_reg_2_in);
            end
            BNE: begin // BNE
                branch_taken = (source_reg_1_in != source_reg_2_in);
            end
            BLT: begin // BLT
                branch_taken = ($signed(source_reg_1_in) < $signed(source_reg_2_in));
            end
            BGE: begin // BGE
                branch_taken = ($signed(source_reg_1_in) >= $signed(source_reg_2_in));
            end
            BLTU: begin // BLTU
                branch_taken = (source_reg_1_in < source_reg_2_in);
            end
            BGEU: begin // BGEU
                branch_taken = (source_reg_1_in >= source_reg_2_in);
            end
            default: branch_taken = 1'b0;
        endcase
    end
end

endmodule
