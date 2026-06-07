module curve_stx_ve_605_20260112_000352_363561_w37744_attempt15 (
  // No inputs/outputs needed for this specific violation
);

  localparam INITIAL_VALUE = 10; // Define a localparam

  reg [7:0] dummy_data;

  initial begin
    // STX_VE_605 violation: Illegal attempt to assign a new value
    // to a localparam (INITIAL_VALUE) within a procedural block (initial).
    // Localparams are static constants and cannot be modified after elaboration/during simulation.
    INITIAL_VALUE = 20; // This line should trigger STX_VE_605

    dummy_data = 8'd0; // Assign to avoid unused warning for dummy_data
  end

endmodule
