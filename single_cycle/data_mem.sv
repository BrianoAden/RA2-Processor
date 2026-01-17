module data_memory(input clk, input reset, input write_enable, input read_enable, input [31:0] address, 
                    input [31:0] data_in, output [31:0] data_out);

// RISC V makes use of 32 bit addressing

// Try clock gating here?

logic [31:0] mem [255:0];

integer i;

always_ff @(posedge clk) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end else if (write_enable) begin // If we are storing data
        mem[address] <= data_in;
    end else if (read_enable) begin // If we are loading data
        data_out <= mem[address];
    end
end

endmodule