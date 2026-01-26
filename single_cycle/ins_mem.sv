module instruction_memory(input [31:0] pc_value, output [31:0] instruction);

logic [31:0] mem [0:255];
logic [7:0] word_index;

// 1 KiB instruction memory

initial begin
     $readmemb("instruction.list", mem); // Not synthesizable
end

always_comb begin
    word_index = pc_value[9:2];
    instruction = mem[word_index];
end

endmodule