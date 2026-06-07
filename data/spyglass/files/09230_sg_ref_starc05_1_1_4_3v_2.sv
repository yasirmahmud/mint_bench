module my_module_ex2;
 parameter MY_CONST = 10;
 wire [3:0] top_val;
 assign top_val = MY_CONST;
 generate if (1) begin : gen_block parameter MY_CONST = 20;
 wire [3:0] gen_val;
 assign gen_val = MY_CONST;
 end endgenerate endmodule
