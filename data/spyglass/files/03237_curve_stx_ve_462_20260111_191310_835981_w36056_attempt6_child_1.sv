module curve_stx_ve_462_example_6 ();

  // Declare an unpacked array of 3 elements, each 4-bit wide.
  wire [3:0] my_data_vec [0:2];

  // To resolve STX_VE_462 violation in Verilog-2001, assign each element individually.
  assign my_data_vec[0] = 4'hA;
  assign my_data_vec[1] = 4'hA;
  assign my_data_vec[2] = 4'hA;

endmodule
