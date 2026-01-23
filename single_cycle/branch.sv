module branch(input logic branch_signal, input logic [2:0] func_3bits, input logic [31:0] immediate, input logic [31:0] source_reg_1_in, input logic [31:0] source_reg_2_in,
             input logic [31:0] current_pc, output logic branch_taken, output logic [31:0] target_address);

// Do I need to compute target address in here? 

always_comb begin: branchUnit
    if (branch_signal) begin
        case (func_3bits)
            3'b000: begin // BEQ
                if (source_reg_1_in == source_reg_2_in) begin
                    branch_taken = 1'b1;
                end else begin
                    branch_taken = 1'b0;
                end
            end
            3'b001: begin // BNE
                if (source_reg_1_in != source_reg_2_in) begin
                    branch_taken = 1'b1;
                end else begin
                    branch_taken = 1'b0;
                end
            end
            3'b100: begin // BLT
                if ($signed(source_reg_1_in) < $signed(source_reg_2_in)) begin
                    branch_taken = 1'b1;
                end else begin
                    branch_taken = 1'b0;
                end
            end
            3'b101: begin // BGE
                if ($signed(source_reg_1_in) >= $signed(source_reg_2_in)) begin
                    branch_taken = 1'b1;
                end else begin
                    branch_taken = 1'b0;
                end
            end
            3'b110: begin // BLTU
                if (source_reg_1_in < source_reg_2_in) begin
                    branch_taken = 1'b1;
                end else begin
                    branch_taken = 1'b0;
                end
            end
            3'b111: begin // BGEU
                if (source_reg_1_in >= source_reg_2_in) begin
                    branch_taken = 1'b1;
                end else begin
                    branch_taken = 1'b0;
                end
            end
        endcase
    end else begin
        branch_taken = 1'b0;
    end
end

endmodule