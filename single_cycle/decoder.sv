'define LB_LH_LW_LBU_LHU 0000011
'define SB_SH_SW 0100011
'define LUI_AUIPC 0010111
'define JAL 1101111
'define JALR 1100111
'define ADDI_SLTI_SLTIU_XORI_ORI_AND_I 0010011
'define BRANCH 1100011


module decoder(input [31:0] instruction_in, output [6:0] opcode_out, output [4:0] dest_reg_out, output [2:0] function_3_bits_out, output [6:0] function_7_bits_out,
                output [4:0] source_reg_1_out, output [4:0] source_reg_2_out, output [31:0] immediate_out, output write_enable);

// Need to figure out how to make immediate a bit more dynamic and fit the different instruction types better
// Maybe use the opcode to define how the immediate will be represented, seems like theres about 8 different ways of creating the immediate
// Also need to add control signals the other modules based on opcode/instruction type

// Should add a control vector of bits

// Immediate needs to be sign extended

logic branch_sig, load_sig, store_sig, jump_sig;

always_comb begin : decoderImplementation
    opcode_out [6:0] = instruction_in [6:0];
    dest_reg_out [4:0] = instruction_in [11:7];
    function_3_bits_out [2:0] = instruction_in [14:12];
    function_7_bits_out [6:0] = instruction_in [31:25];
    source_reg_1_out [4:0] = instruction_in [19:15];
    source_reg_2_out [4:0] = instruction_in [24:20];

    if (opcode_out[6:0] == LB_LH_LW_LBU_LHU) || (opcode_out[6:0] == ADDI_SLTI_SLTIU_XORI_ORI_AND_I) || (opcode_out[6:0] == JALR) begin
        immediate_out[31:0] = {20{instruction_in[31]}, instruction_in[31:20]};
    end
    else if (opcode_out[6:0] == SB_SH_SW) begin
        immediate_out[31:0] = {20{instruction_in[31]}, instruction_in[31:25], instruction_in[11:7]};
    end
    else if (opcode_out[6:0] == LUI_AUIPC) begin
        immediate_out[31:0] = {instruction_in[31:12], 12'b0};
    end
    else if (opcode_out[6:0] == BRANCH) begin
        immediate_out[31:0] = {19{instruction_in[31]}, instruction_in[31], instruction_in[7], instruction_in[30:25], instruction_in[11:8], 1'b0};
    end 
    else if (opcode_out[6:0] == JAL) begin
        immediate_out[31:0] = {11{instruction_in[31]}, instruction_in[31], instruction_in[19:12], instruction_in[20], instruction_in[30:21]. 1'b0};
    end
    else begin
        immediate_out[31:0] = 32'd0; // Need to figure out a better method of handling no immediate
    end

end

endmodule