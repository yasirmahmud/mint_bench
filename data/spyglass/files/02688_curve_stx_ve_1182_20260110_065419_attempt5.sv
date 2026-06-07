module curve_stx_ve_1182_20260110_065419_attempt5 ();

  // Declare 'idx' as an integer. According to Verilog-2001 rules, a 'genvar'
  // is expected as the loop variable in a generate for-loop, not an 'integer'.
  // This directly triggers the STX_VE_1182 violation.
  integer idx;

  generate
    // The use of 'idx' (an integer) in this generate for-loop condition
    // is the specific point of violation for STX_VE_1182.
    for (idx = 1; idx < 4; idx = idx + 1) begin : gen_loop_example
      // A minimal declaration inside the generate block to ensure it is not empty.
      // This wire is intentionally unused to prevent triggering other linting rules.
      wire unused_placeholder_signal;
    end
  endgenerate

endmodule
