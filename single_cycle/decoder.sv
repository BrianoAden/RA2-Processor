module decoder(input [31:0] instruction_in, output [6:0] opcode_out, output [4:0] dest_reg_out, output [2:0] function_3bits_out, output [6:0] function_7_bits_out,
                output [4:0] source_reg_1_out, output [4:0] source_reg_2_out, output [31:0] immediate_out);

// Need to figure out how to make immediate a bit more dynamic and fit the different instruction types better
// Maybe use the opcode to define how the immediate will be represented, seems like theres about 8 different ways of creating the immediate
// Also need to add control signals the other modules based on opcode/instruction type

always_comb begin : decoderImplementation
    opcode_out [6:0] = instruction_in [6:0];
    dest_reg_out [4:0] = instruction_in [11:7];
    function_3bits_out [2:0] = instruction_in [14:12];
    function_7_bits_out [6:0] = instruction_in [31:25];
    source_reg_1_out [4:0] = instruction_in [19:15];
    source_reg_2_out [4:0] = instruction_in [24:20];

end

endmodule