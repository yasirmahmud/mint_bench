module nand_tree_cell (input a, input b, output out);
 assign out = ~(a & b);
 endmodule
