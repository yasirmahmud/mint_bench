module top_module_ex2;
 wire dummy_in;
 assign dummy_in = 1'b0;
 buf U1 (.O(1'b1), .I(dummy_in));
 endmodule
