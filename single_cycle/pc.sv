module programCounter(input clk, input reset, input branch_taken, input jump, input logic [31:0] incoming_pc, output logic [31:0] pc_output);

logic [31:0] PC; 

always_ff @(posedge clk) begin: programCounter
    if (reset) begin
        PC <= 32'd0;
    end
    else if (branch_taken || jump) begin
        PC <= incoming_pc;
    end 
    else begin
        PC <= PC + 4;
    end
end 

always_comb begin
    pc_output = PC;
end

endmodule