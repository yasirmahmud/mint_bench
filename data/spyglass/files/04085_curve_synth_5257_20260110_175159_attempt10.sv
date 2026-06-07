module curve_synth_5257_20260110_175159_attempt10 #(
  // Parameter to define the actual width of the input vector.
  // Set to 1 to make the vector [0:0].
  parameter INPUT_WIDTH = 1,
  // Parameters to define the part-select range that will be out of bounds.
  // Set to 1:1 to trigger the SYNTH_5257 violation for a [0:0] vector.
  parameter SELECT_HIGH = 1,
  parameter SELECT_LOW = 1
) (
  // Input vector whose actual width is INPUT_WIDTH.
  // If INPUT_WIDTH is 1, this becomes input [0:0] data_in.
  input [INPUT_WIDTH - 1 : 0] data_in,
  // Output to capture the result of the part-select.
  // Its width is made 1 (e.g., [0:0]) to prevent other range errors on the output itself,
  // assuming the part-select evaluates to a single bit.
  output [0:0] data_out
);

  // Declare a local wire to consume the valid bit of the input vector.
  // This prevents a W240 (unused input bit) warning.
  wire dummy_use_input_bit;
  assign dummy_use_input_bit = data_in[0];

  // SYNTH_5257: Part Select [SELECT_HIGH:SELECT_LOW] on a Vector data_in[INPUT_WIDTH-1:0] is out of range
  // With INPUT_WIDTH=1, 'data_in' is effectively a 1-bit vector declared as [0:0].
  // With SELECT_HIGH=1 and SELECT_LOW=1, the part-select attempts to access 'data_in[1:1]'.
  // This access is out of the valid range [0:0] for 'data_in', directly triggering the SYNTH_5257 rule.
  assign data_out = data_in[SELECT_HIGH : SELECT_LOW];

endmodule
