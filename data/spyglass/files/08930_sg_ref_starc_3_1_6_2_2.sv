module my_module_ex2();
 genvar i;
 generate for (i = 0; i < 4; i = i + 1) begin : gen_block wire w_i;
 assign w_i = 1'b0;
 end endgenerate endmodule
