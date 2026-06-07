module top_module_ex2;
 wire dummy_in;
 wire out_pin; // Declare a wire for the output
 assign dummy_in = 1'b0;
 buf U1 (.O(out_pin), .I(dummy_in)); // Connect the output to a declared wire
 endmodule
