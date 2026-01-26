module data_memory(input clk, input reset, input write_enable, input read_enable, input [2:0] func_3_bits, input [31:0] address, 
                    input [31:0] data_in, output [31:0] data_out);

// RISC V makes use of 32 bit addressing

// Try clock gating here?
// Need to modify this to work for the different types of loads and stores

// write_enable = store_sig
// read_enable = load_sig

logic [31:0] mem [255:0];

integer i;

always_ff @(posedge clk) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end else if (write_enable) begin // If we are storing data
        case(func_3_bits)
            3'b000: // LB
            3'b001: // LH
            3'b010: // LW
            3'b100: // LBU
            3'b101: // LHU
        endcase
        mem[address] <= data_in;
    end else if (read_enable) begin // If we are loading data\
        case(func_3_bits)
            3'b000: // SB
            3'b001: // SH
            3'b010: // SW
        endcase
        data_out <= mem[address];
    end
end

endmodule