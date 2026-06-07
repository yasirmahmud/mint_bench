module top_module_ex2 (output top_out);
 nand_tree_cell #(.NUM_INPUTS(2)) u_nand_tree (.in_data(), .out_data(top_out));
 endmodule
