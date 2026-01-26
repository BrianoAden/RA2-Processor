module data_memory(input logic clk, input logic reset, input logic write_enable, input logic read_enable, input logic [2:0] func_3_bits, input logic [31:0] address, 
                    input logic [31:0] data_in, output logic [31:0] data_out);

// RISC V makes use of 32 bit addressing

// Try clock gating here?

// 1 KiB data memory

// write_enable = store_sig
// read_enable = load_sig

logic [31:0] mem [0:255];
logic [31:0] word;
logic [7:0] byte_logic;
logic [15:0] half_word;
logic [7:0] address_word;
logic [1:0] address_byte;

logic [31:0] word_next;
integer i;

always_comb begin
    address_word = address[9:2]; // only need 8 bits to index all of the current data mem
    address_byte = address[1:0];
    word = mem[address_word];
    word_next = word;
    byte_logic = 8'd0;
    half_word = 16'd0;
    if (read_enable) begin
        byte_logic = word >> (address_byte * 8);
        half_word = word >> (address_byte[1] * 16);
    end 
    else if (write_enable) begin
        case(func_3_bits)
            3'b000: begin // SB
                word_next[address_byte*8 +: 8] = data_in[7:0];
            end
            3'b001: begin // SH
                word_next[address_byte[1]*16 +: 16] = data_in[15:0];
            end
            3'b010: begin // SW
                word_next = data_in;
            end
        endcase
    end
end

always_ff @(posedge clk) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] <= 32'h00000000;
        end
    end else if (read_enable) begin // If we are loading data
        case(func_3_bits)
            3'b000: begin // LB
                data_out <= {{24{byte_logic[7]}}, byte_logic};
            end
            3'b001: begin // LH
                data_out <= {{16{half_word[15]}}, half_word};
            end
            3'b010: begin // LW
                data_out <= mem[address_word];
            end
            3'b100: begin // LBU
                data_out <= {24'd0, byte_logic};
            end
            3'b101: begin // LHU
                data_out <= {16'd0, half_word};
            end
        endcase
    end else if (write_enable) begin // If we are storing data
        mem[address_word] <= word_next;
    end
end

endmodule