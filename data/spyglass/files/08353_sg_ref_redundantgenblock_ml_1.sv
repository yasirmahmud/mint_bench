module redundant_gen_block_ex1();
 wire a;
 generate begin: my_gen_block assign a = 1'b0;
 end endgenerate endmodule
