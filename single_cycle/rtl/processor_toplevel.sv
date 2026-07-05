module processor_toplevel
import ctrl_sig_pkg::*;
(input clk, input reset);

logic branch_taken, jump;
logic [31:0] pc_value, pc_output;
logic [31:0] alu_result;

ctrl_sigs_t control_sigs;

// should add To and From convention for ports

programCounter myPC(
    .clk         (clk),
    .reset       (reset),
    .branch_taken (branch_taken),
    .jump (jump),
    .incoming_pc    (alu_result), // From 
    .pc_output (pc_output)
);

logic [31:0] instruction; 

instruction_memory myInstructionMemory(
    .pc_value   (pc_output),
    .instruction(instruction)
);

logic [4:0] source_register_1, source_register_2, dest_register;

logic [2:0] function_3_bits_out;
logic [6:0] function_7_bits_out;

logic [31:0] immediate_out;

decoder myDecoder(
    .instruction_in     (instruction),
    .dest_reg_out       (dest_register),
    .function_3_bits_out(function_3_bits_out),
    .function_7_bits_out(function_7_bits_out),
    .source_reg_1_out   (source_register_1),
    .source_reg_2_out   (source_register_2),
    .immediate_out      (immediate_out),
    .control_sigs       (control_sigs)
);

logic [31:0] reg1_data, reg2_data, write_data;

regfile myRegfile(
    .clk       (clk),
    .reset     (reset),
    .rs1       (source_register_1),
    .rs2       (source_register_2),
    .rd        (dest_register),
    .write_data(write_data),
    .reg_write (control_sigs.reg_write),
    .reg1_data (reg1_data),
    .reg2_data (reg2_data)
);

// need to add logic to decide whether operand is from register or immediate

logic [31:0] operand_2;

assign operand_2 = (control_sigs.ALU_2_op_sig) ? reg2_data : immediate_out;

alu myALU(
    .operand_1   (reg1_data),
    .operand_2   (operand_2), // need to be able to switch between reg2_data and immediate_out
    .shift_amount(shift_amount), // need to remember what this comes from
    .control_sigs(control_sigs),
    .func_3_bits (function_3_bits_out),
    .func_7_bit  (function_7_bits_out[0]), // need to figure out which bit this needs to be
    .result      (alu_result)
);

branch myBranch(
    .branch_signal  (control_sigs.branch_sig), // comes from control signals 
    .func_3bits     (function_3_bits_out),
    .source_reg_1_in(reg1_data),
    .source_reg_2_in(reg2_data),
    .branch_taken   (branch_taken)
);

data_memory myDataMemory(
    .clk         (clk),
    .reset       (reset),
    .write_enable(control_sigs.store_sig), // comes from control signals
    .read_enable (control_sigs.load_sig),
    .func_3_bits (function_3_bits_out),
    .address     (alu_result), // Should be the output of the ALU, which is the effective address
    .data_in     (reg2_data), // Need to figure out what data_in should be, probably from reg2_data
    .data_out    (write_data)
);


endmodule