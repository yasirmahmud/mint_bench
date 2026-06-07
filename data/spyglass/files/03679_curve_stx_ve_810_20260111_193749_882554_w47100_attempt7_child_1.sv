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

  // Declare a wire to hold the dynamically scaled integer value.
  // This replaces the localparam, as its value is not constant and must be evaluated dynamically.
  wire integer scaled_int_val_wire;

  // Assign the value to the wire using the $rtoi system function.
  // This calculation now happens dynamically during simulation/synthesis, not at elaboration,
  // resolving the STX_VE_810 violation.
  assign scaled_int_val_wire = $rtoi(dynamic_real_val);

  // Use the output and the dynamically calculated integer value.
  assign data_out = data_in + scaled_int_val_wire;

endmodule
