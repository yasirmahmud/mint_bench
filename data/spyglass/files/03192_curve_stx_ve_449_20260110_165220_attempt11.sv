module curve_stx_ve_449_20260110_165220_attempt11 (
  input logic clk,
  input logic reset_n,
  output logic dummy_out
);

  // STX_VE_449: Size of the enumeration constant for enum label S8 is more than the range specified for the enumeration
  // This violation occurs because the implicit value assigned to S8 (which is 8) cannot be represented
  // within the 3-bit range specified for the 'my_state_t' enumeration type (max value 7).
  typedef enum logic [2:0] { // 3-bit enum, allows values 0, 1, ..., 7
    S0, // Value 0 (fits in 3-bit)
    S1, // Value 1 (fits in 3-bit)
    S2, // Value 2 (fits in 3-bit)
    S3, // Value 3 (fits in 3-bit)
    S4, // Value 4 (fits in 3-bit)
    S5, // Value 5 (fits in 3-bit)
    S6, // Value 6 (fits in 3-bit)
    S7, // Value 7 (fits in 3-bit)
    S8  // Value 8 (implicitly assigned, requires 4 bits, violates 3-bit range)
  } my_state_t;

  my_state_t current_state_reg;

  // Minimal sequential logic to use the enum type and avoid unused signals
  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state_reg <= S0; // Initialize to a valid state
    end else begin
      current_state_reg <= S1; // Simple transition to keep it "used"
    end
  end

  // Assign a value to dummy_out to avoid unused port warning
  assign dummy_out = (current_state_reg == S0);

endmodule
