module curve_stx_ve_605_20260112_000352_363561_w37744_attempt16 (
  // No inputs/outputs needed for this specific violation
);

  // Define a parameter that acts as a static constant
  parameter MAX_COUNT = 100;

  // Declare a register to avoid unused signal warnings
  reg [7:0] data_out;

  initial begin
    // STX_VE_605 violation: Illegal attempt to assign a new value
    // to a parameter (MAX_COUNT) within a procedural block (initial).
    // Parameters are static constants and cannot be modified after elaboration or during simulation.
    MAX_COUNT = 200; // This line should trigger STX_VE_605: "Illegal use of identifier ( MAX_COUNT )"

    // Assign a value to data_out to ensure it is used
    data_out = 8'h5A;
  end

endmodule
