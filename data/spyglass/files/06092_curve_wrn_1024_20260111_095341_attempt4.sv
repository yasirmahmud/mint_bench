module curve_wrn_1024_20260111_095341_attempt4 (
  input wire [7:0] data_in,
  output wire signed [8:0] processed_out
);

  // Declare an internal wire as signed
  wire signed [7:0] internal_signed_data;
  // Declare an internal wire as unsigned (default)
  wire [7:0] internal_unsigned_data;

  // Assign values to avoid unused signal warnings
  assign internal_signed_data = data_in;
  assign internal_unsigned_data = data_in;

  // WRN_1024: signed argument 'internal_signed_data' passed to $signed system function call
  // The $signed(internal_signed_data) call will trigger the violation because 'internal_signed_data' is already signed.
  assign processed_out = $signed(internal_signed_data) + $signed(internal_unsigned_data);

endmodule
