module curve_wrn_1023_20260110_190149_attempt9 (
  output reg out_sig
);

  // Target rule: WRN_1023 - "enum directive requires parameter to have size specified"
  // This violation occurs when a 'parameter' declaration, intended as an enumeration,
  // does not explicitly specify a bit-width range (e.g., [1:0]) for the parameter itself.

  // To achieve *only* WRN_1023 and avoid STX_VE_483 (a FATAL error, which takes precedence),
  // the 'synopsys enum' pragma *must* include a size specification.
  // Previous attempts showed that even with a sized pragma, STX_VE_483 could still trigger
  // if the parameter itself lacked a size. This attempt simplifies the context by:
  // 1. Removing the 'fsm' keyword from the pragma.
  // 2. Using minimal I/O and logic.

  // This line is crafted to trigger WRN_1023:
  // - The 'parameter' keyword does NOT include an explicit bit-width range (e.g., [1:0]).
  // This line is crafted to AVOID STX_VE_483:
  // - The 'synopsys enum' pragma DOES include a bit-width specification '[1:0]'.
  parameter /* synopsys enum [1:0] */
    STATUS_IDLE = 2'b00,
    STATUS_BUSY = 2'b01;

  // Minimal logic to prevent 'out_sig' from being an unused signal.
  always @(*) begin
    // Using one of the enum parameters to prevent unused parameter warnings.
    out_sig = (STATUS_IDLE == 2'b00) ? 1'b0 : 1'b1;
  end

endmodule
