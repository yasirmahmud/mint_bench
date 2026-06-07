module curve_stx_ve_462_20260111_191310_835981_w36056_attempt7 (
  input [7:0] input_data
);

  // Declare an unpacked array of 2 elements, each 8-bit wide.
  // In Verilog-2001, continuous assignments to unpacked arrays require
  // assigning to individual elements, not the entire array with a replication.
  wire [7:0] data_unpacked_array [0:1];

  // STX_VE_462 violation: Illegal assignment, expecting assignment pattern.
  // Assigning a replication of 'input_data' directly to the unpacked array 'data_unpacked_array'
  // is not allowed in Verilog-2001 and triggers this violation. SystemVerilog (SV09)
  // supports such assignments with assignment patterns.
  assign data_unpacked_array = {2{input_data}};

endmodule
