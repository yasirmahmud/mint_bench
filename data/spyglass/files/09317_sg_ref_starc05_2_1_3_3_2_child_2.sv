module my_module_ex2 (data);
  input data;
  // Resolve W240: Input 'data' declared but not read.
  wire unused_data = data;
endmodule
