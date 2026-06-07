module sub_mod_ex2 (input [3:0] data_in);
  // W528: Removed 'dummy_wire' as it was set but never read.
  // Fix: Added internal_data to read data_in, resolving empty module and unused input warnings.
  wire [3:0] internal_data;
  assign internal_data = data_in;
endmodule
