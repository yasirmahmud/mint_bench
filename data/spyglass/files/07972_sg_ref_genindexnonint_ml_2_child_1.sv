module my_module_ex2;
 genvar i;
 generate
  for (i=0; i<2; i=i+1) begin: gen_block
   wire [0:0] my_wire = 1'b0;
  end
 endgenerate
endmodule
