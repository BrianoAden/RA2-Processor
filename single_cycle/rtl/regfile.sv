module regfile
#(parameter int data_width = 32)
(input clk, input reset, input [4:0] rs1, input [4:0] rs2, input [4:0] rd,
input [data_width-1:0] write_data, input reg_write, output logic [data_width-1:0] reg1_data, output logic [data_width-1:0] reg2_data);

logic [data_width-1:0] registers [31:0];

integer i;

always_ff @(posedge clk) begin
    registers[0] <= {data_width{1'b0}}; // Register 0 should always be 0 based on RV standard
    if (reset) begin
        for (i = 1; i < 32; i = i +1) begin
            registers[i] <= {data_width{1'b0}};
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
