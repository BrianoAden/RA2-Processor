module regfile(input clk, input reset, input [4:0] rs1, input [4:0] rs2, input [4:0] rd,
                input [31:0] write_data, input reg_write, output logic [31:0] reg1_data, output logic [31:0] reg2_data);

logic [31:0] registers [31:0];

integer i;

always_ff @(posedge clk) begin
    registers[0] <= 32'h00000000; // Register 0 should always be 0
    if (reset) begin
        for (i = 1; i < 32; i = i +1) begin
            registers[i] <= 32'h00000000;
        end
    end else begin
    if (reg_write && rd != 5'd0) begin
        registers[rd] <= write_data;
    end
    end
end

always_comb begin
    reg1_data = registers[rs1];
    reg2_data = registers[rs2];
end

endmodule