module curve_stx_ve_810_20260111_105321_attempt5 (
  input real input_real_val, // A non-constant real input value
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // SpyGlass STX_VE_810 violation: A 'localparam' declaration requires its
  // expression to be constant at elaboration time. Here, $rtoi is called
  // with 'input_real_val', which is a module input and thus a non-constant
  // value, leading to the violation.
  // 
  // Fix: Removed the localparam. The $rtoi conversion is now performed
  // directly in the continuous assignment, as $rtoi can be used with
  // non-constant values in procedural or continuous assignments.

  // Using the converted real value in the assignment
  assign data_out = data_in + $rtoi(input_real_val);

endmodule
