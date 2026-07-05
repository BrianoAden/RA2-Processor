module data_memory
import d_mem_state_pkg::*;
#(parameter int data_width = 32)
(input logic clk, input logic reset, input logic write_enable, input logic read_enable, 
input logic [2:0] func_3_bits, input logic [data_width-1:0] address, input logic [data_width-1:0] data_in, output logic [data_width-1:0] data_out);

// RISC V makes use of 32 bit addressing

// Try clock gating here?

// 1 KiB data memory

// write_enable = store_sig
// read_enable = load_sig

logic [data_width-1:0] mem [0:255];
logic [data_width-1:0] word;
logic [7:0] byte_logic;
logic [15:0] half_word;
logic [7:0] address_word;
logic [1:0] address_byte;

logic [data_width-1:0] word_next;
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
        case(d_mem_state_pkg::d_mem_wr_state_t'(func_3_bits))
            SB: begin // SB
                word_next[address_byte*8 +: 8] = data_in[7:0];
            end
            SH: begin // SH
                word_next[address_byte[1]*16 +: 16] = data_in[15:0];
            end
            SW: begin // SW
                word_next = data_in;
            end
            default:address_byte = 2'b00; // need to figure out what default should be
        endcase
    end
end

always_ff @(posedge clk) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] <= {data_width{1'b0}};
        end
    end else if (read_enable) begin // If we are loading data
        case(d_mem_state_pkg::d_mem_rd_state_t'(func_3_bits))
            LB: begin // LB
                data_out <= {{(data_width - 8){byte_logic[7]}}, byte_logic};
            end
            LH: begin // LH
                data_out <= {{(data_width - 16){half_word[15]}}, half_word};
            end
            LW: begin // LW
                data_out <= mem[address_word];
            end
            LBU: begin // LBU
                data_out <= {{(data_width - 8){1'b0}}, byte_logic};
            end
            LHU: begin // LHU
                data_out <= {{(data_width - 16){1'b0}}, half_word};
            end
            default: data_out <= {data_width{1'b0}}; // need to figure out what default should be
        endcase
    end else if (write_enable) begin // If we are storing data
        mem[address_word] <= word_next;
    end
end

endmodule
