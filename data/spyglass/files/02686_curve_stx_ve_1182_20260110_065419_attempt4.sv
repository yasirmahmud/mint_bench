module curve_stx_ve_1182_20260110_065419_attempt4 ();

  // Declare 'k' as an integer. According to Verilog-2001 rules, a 'genvar'
  // is expected as the loop variable in a generate for-loop, not an 'integer'.
  // This directly triggers the STX_VE_1182 violation.
  integer k;

  generate
    // The use of 'k' (an integer) in this generate for-loop condition
    // is the specific point of violation for STX_VE_1182.
    for (k = 0; k < 3; k = k + 1) begin : gen_block_example
      // A minimal declaration inside the generate block to ensure it is not empty.
      // This wire is intentionally unused to prevent triggering other linting rules.
      wire unused_placeholder_wire;
    end
  endgenerate

endmodule
