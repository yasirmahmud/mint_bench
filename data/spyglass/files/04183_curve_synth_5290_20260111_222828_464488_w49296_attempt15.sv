module curve_synth_5290_20260111_222828_464488_w49296_attempt15 (
  input wire [7:0]  input_val,
  output wire [7:0] output_scaled_val
);

  // Declare a localparam of type real for scaling.
  localparam real SCALING_FACTOR = 0.5;

  // Declare an internal real wire to hold the intermediate scaled value.
  // This declaration of a 'real' type is itself synthesizable only if it does not interact
  // directly with discrete hardware bit-vector types in a synthesizable context.
  real intermediate_scaled_real;

  // Perform a continuous assignment involving a synthesizable bit-vector and a real localparam.
  // The result of this multiplication (bit-vector * real) will be of type 'real'.
  // This operation is typically handled during simulation and usually doesn't trigger SYNTH_5290 itself
  // unless the destination is a bit-vector.
  assign intermediate_scaled_real = input_val * SCALING_FACTOR;

  // Attempt to assign the 'real' intermediate_scaled_real to a synthesizable 'wire' type.
  // This is the core SYNTH_5290 violation. Synthesis tools cannot represent
  // a real number (floating-point) directly as a discrete hardware bit-vector.
  // The implicit conversion or direct assignment of a 'real' value to a 'wire' or 'reg'
  // is considered an unsynthesizable usage of 'real' type.
  assign output_scaled_val = intermediate_scaled_real;

endmodule
