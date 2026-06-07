module nand_tree_cell #(parameter NUM_INPUTS = 2) (input [NUM_INPUTS-1:0] in_data, output out_data);
 assign out_data = ~( &in_data);
 endmodule
