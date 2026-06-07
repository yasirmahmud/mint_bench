module curve_wrn_1024_20260111_225654_562626_w28836_attempt12 (
  input signed [15:0] signed_data_in,
  output reg signed [15:0] processed_data_out
);

  // Declare an intermediate signed wire
  wire signed [15:0] internal_signed_wire;

  // Assign the input to the intermediate wire
  assign internal_signed_wire = signed_data_in;

  // WRN_1024: 'internal_signed_wire' is already declared as signed,
  // so passing it to $signed() is redundant. This line triggers the violation.
  always @* begin
    processed_data_out = $signed(internal_signed_wire);
  end

endmodule
