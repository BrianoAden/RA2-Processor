package ctrl_sig_pkg; 

typedef struct packed {
    logic branch_sig;
    logic load_sig;
    logic store_sig;
    logic jal_sig;
    logic jalr_sig;
    logic ALU_1_op_sig;
    logic ALU_2_op_sig;
    logic reg_write;
    logic auipc_sig;
    logic lui_sig;
} ctrl_sigs_t;

endpackage
