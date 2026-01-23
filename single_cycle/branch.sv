module branch(input logic branch_signal, input logic [2:0] func_3bits, input logic [31:0] immediate, input logic [31:0] source_reg_1_in, input logic [31:0] source_reg_2_in,
             input logic [31:0] current_pc, output logic branch_taken, output logic [31:0] target_address);

// Do I need to compute target address in here? 

always_comb begin: branchUnit

    branch_taken = 1'b0;
    target_address = current_pc + immediate; // should Immediate be signed?

    if (branch_signal) begin
        case (func_3bits)
            3'b000: begin // BEQ
                branch_taken = (source_reg_1_in == source_reg_2_in);
            end
            3'b001: begin // BNE
                branch_taken = (source_reg_1_in != source_reg_2_in);
            end
            3'b100: begin // BLT
                branch_taken = ($signed(source_reg_1_in) < $signed(source_reg_2_in));
            end
            3'b101: begin // BGE
                branch_taken = ($signed(source_reg_1_in) >= $signed(source_reg_2_in));
            end
            3'b110: begin // BLTU
                branch_taken = (source_reg_1_in < source_reg_2_in);
            end
            3'b111: begin // BGEU
                branch_taken = (source_reg_1_in >= source_reg_2_in);
            end
            default: branch_taken = 1'b0;
        endcase
    end
end

endmodule