module processor_toplevel(input clk, input reset);

module alu alu (
    .operand_1   (operand_1),
    .operand_2   (operand_2),
    .shift_amount(shift_amount),
    .control_sigs(control_sigs),
    .func_3_bits (func_3_bits),
    .func_7_bit  (func_7_bit),
    .result      (result)
); (
    ports
);
    
endmodule

module branch branch (
    .branch_signal  (branch_signal),
    .func_3bits     (func_3bits),
    .immediate      (immediate),
    .source_reg_1_in(source_reg_1_in),
    .source_reg_2_in(source_reg_2_in),
    .branch_taken   (branch_taken)
); (
    ports
);
    
endmodule

module data_memory data_memory (
    .clk         (clk),
    .reset       (reset),
    .write_enable(write_enable),
    .read_enable (read_enable),
    .func_3_bits (func_3_bits),
    .address     (address),
    .data_in     (data_in),
    .data_out    (data_out)
); (
    ports
);
    
endmodule

module decoder decoder (
    .instruction_in     (instruction_in),
    .opcode_out         (opcode_out),
    .dest_reg_out       (dest_reg_out),
    .function_3_bits_out(function_3_bits_out),
    .function_7_bits_out(function_7_bits_out),
    .source_reg_1_out   (source_reg_1_out),
    .source_reg_2_out   (source_reg_2_out),
    .immediate_out      (immediate_out),
    .control_sigs       (control_sigs)
); (
    ports
);
    
endmodule

module instruction_memory instruction_memory (
    .pc_value   (pc_value),
    .instruction(instruction)
); (
    ports
);
    
endmodule

module decoder decoder (
    .instruction_in     (instruction_in),
    .opcode_out         (opcode_out),
    .dest_reg_out       (dest_reg_out),
    .function_3_bits_out(function_3_bits_out),
    .function_7_bits_out(function_7_bits_out),
    .source_reg_1_out   (source_reg_1_out),
    .source_reg_2_out   (source_reg_2_out),
    .immediate_out      (immediate_out),
    .control_sigs       (control_sigs)
); (
    ports
);
    
endmodule

module regfile regfile (
    .clk       (clk),
    .reset     (reset),
    .rs1       (rs1),
    .rs2       (rs2),
    .rd        (rd),
    .write_data(write_data),
    .reg_write (reg_write),
    .reg1_data (reg1_data),
    .reg2_data (reg2_data)
); (
    ports
);
    
endmodule

endmodule