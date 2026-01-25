module regfile(input clk, input reset, input [4:0] rs1, input [4:0] rs2, input [4:0] rd,
                input [31:0] write_data, input reg_write, output [31:0] reg1_data, output [31:0] reg2_data, output [31:0] read_rd_data);

logic [31:0] registers [31:0];
logic [31:0] reg1_data, reg2_data, read_rd_data;

integer i;

always_ff @(posedge clk) begin
    registers[0] <= 32'h00000000; // Register 0 should always be 0
    if (reset) begin
        for (i = 1; i < 32; i = i +1) begin
            registers[i] <= 32'h00000000;
        end
    end else begin
    if (reg_write) begin
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