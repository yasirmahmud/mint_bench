module curve_stx_ve_810_20260111_105321_attempt5 (
  input real input_real_val, // A non-constant real input value
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // SpyGlass STX_VE_810 violation: A 'localparam' declaration requires its
  // expression to be constant at elaboration time. Here, $rtoi is called
  // with 'input_real_val', which is a module input and thus a non-constant
  // value, leading to the violation.
  localparam integer CONVERTED_INT_VAL = $rtoi(input_real_val);

  // Using the localparam to ensure it's not optimized away as unused
  assign data_out = data_in + CONVERTED_INT_VAL;

endmodule
