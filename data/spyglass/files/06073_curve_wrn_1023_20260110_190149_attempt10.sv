module curve_wrn_1023_20260110_190149_attempt10 (
  output reg out_valid
);

  // Target rule: WRN_1023 - "enum directive requires parameter to have size specified"
  // This violation occurs when a 'parameter' declaration, intended as an enumeration,
  // does not explicitly specify a bit-width range (e.g., [1:0]) for the parameter itself.

  // To achieve *only* WRN_1023 and avoid STX_VE_483 (a FATAL error),
  // the 'synopsys enum' pragma *must* include a size specification to avoid STX_VE_483.
  // The challenge is that previous attempts, and context examples, show STX_VE_483 still fires
  // when the 'parameter' itself is unsized, even if the pragma has a size.

  // This line is crafted to trigger WRN_1023:
  // - The 'parameter' keyword does NOT include an explicit bit-width range (e.g., [1:0]).
  // This line is crafted to AVOID STX_VE_483, assuming '/* synopsys enum [2] */' is sufficient for the pragma:
  // - The 'synopsys enum' pragma DOES include a bit-width specification '[2]'.
  parameter /* synopsys enum [2] */
    logic_state_start   = 2'b00,
    logic_state_process = 2'b01,
    logic_state_done    = 2'b10;

  // Minimal logic to prevent 'out_valid' from being an unused signal and parameters from being unused.
  always @(*) begin
    out_valid = (logic_state_start == 2'b00) ? 1'b0 : 1'b1;
  end

endmodule
