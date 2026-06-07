module my_module_ex2;
 genvar i;
 generate for (i = 0; i < 1; i = i + 1) begin : gen_block_1
   mod_a instance_a();
 end
 endgenerate
 generate for (i = 0; i < 1; i = i + 1) begin : gen_block_2
   mod_b instance_b();
 end
 endgenerate
 endmodule
