module curve_stx_ve_810_20260111_193749_882554_w47100_attempt7 (
  input [7:0] data_in,
  input enable,
  output [7:0] data_out
);

  // Declare a real variable. This variable will hold a value that depends on module inputs.
  real dynamic_real_val;
  
  // Assign a value to the real variable using an always_comb block.
  // Since 'data_in' and 'enable' are module inputs, their values are not constant at elaboration time.
  // Therefore, 'dynamic_real_val' becomes a non-constant expression.
  always @* begin
    if (enable) begin
      dynamic_real_val = $itor(data_in) * 1.5;
    end else begin
      dynamic_real_val = $itor(data_in) * 0.5;
    end
  end

  // Attempt to define a localparam using the $rtoi system function.
  // The argument to $rtoi, 'dynamic_real_val', is a non-constant expression
  // because its value depends on module inputs 'data_in' and 'enable'.
  // This directly violates STX_VE_810, as localparam declarations require
  // constant expressions for their initial values.
  localparam integer SCALED_INT_VAL = $rtoi(dynamic_real_val);

  // Use the output and localparam to avoid unused warnings and ensure connectivity.
  assign data_out = data_in + SCALED_INT_VAL;

endmodule
