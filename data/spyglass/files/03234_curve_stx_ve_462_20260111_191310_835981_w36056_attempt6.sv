module curve_stx_ve_462_example_6 ();

  // Declare an unpacked array of 3 elements, each 4-bit wide.
  wire [3:0] my_data_vec [0:2];

  // STX_VE_462 violation: Illegal assignment, expecting assignment pattern.
  // Verilog-2001 does not support assigning a replication (or concatenation of values)
  // directly to an unpacked array. This feature is introduced in SystemVerilog (SV09).
  assign my_data_vec = {3{4'hA}};

endmodule
