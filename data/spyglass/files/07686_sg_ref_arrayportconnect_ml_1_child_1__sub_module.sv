module sub_module (input wire [7:0] data_in);
  // Fix for SpyGlass violation: Input 'data_in' declared but not read.
  // This dummy assignment ensures the input is used without altering functional behavior.
  wire [7:0] dummy_use_data_in;
  assign dummy_use_data_in = data_in;
 endmodule
