module regfile(input clk, input reset, input [4:0] rs1, input [4:0] rs2, input [4:0] rd,
                input [31:0] write_data, output [31:0] reg1_data, output [31:0] reg2_data, output [31:0] read_rd_data);

logic [31:0] registers [31:0];
logic [31:0] reg1_data, reg2_data, read_rd_data;

always @(posedge clk) begin
    registers[0] <= 32'h00000000; // Register 0 should always be 0
    if (reset) begin
        registers[1] <= 32'h00000000;
        registers[2] <= 32'h00000000;
        registers[3] <= 32'h00000000;
        registers[4] <= 32'h00000000;
        registers[5] <= 32'h00000000;
        registers[6] <= 32'h00000000;
        registers[7] <= 32'h00000000;
        registers[8] <= 32'h00000000;
        registers[9] <= 32'h00000000;
        registers[10] <= 32'h00000000;
        registers[11] <= 32'h00000000;
        registers[12] <= 32'h00000000;
        registers[13] <= 32'h00000000;
        registers[14] <= 32'h00000000;
        registers[15] <= 32'h00000000;
        registers[16] <= 32'h00000000;
        registers[17] <= 32'h00000000;
        registers[18] <= 32'h00000000;
        registers[19] <= 32'h00000000;
        registers[20] <= 32'h00000000;
        registers[21] <= 32'h00000000;
        registers[22] <= 32'h00000000;
        registers[23] <= 32'h00000000;
        registers[24] <= 32'h00000000;
        registers[25] <= 32'h00000000;
        registers[26] <= 32'h00000000;
        registers[27] <= 32'h00000000;
        registers[28] <= 32'h00000000;
        registers[29] <= 32'h00000000;
        registers[30] <= 32'h00000000;
        registers[31] <= 32'h00000000;
    end else begin
    if (write) begin
        registers[rd] <= write_data;
    end

    reg1_data <= registers[rs1];
    reg2_data <= registers[rs2];
    read_rd_data <= registers[rd];
    end
end

assign reg1_data = reg1_data;
assign reg2_data = reg2_data;
assign read_rd_data = read_rd_data;

endmodule