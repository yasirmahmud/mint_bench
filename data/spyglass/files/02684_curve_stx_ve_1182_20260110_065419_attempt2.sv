module curve_stx_ve_1182_20260110_065419_attempt2 ();

  // Declare 'i' as an integer. Using an integer as a loop variable
  // in a generate for-loop is a violation of STX_VE_1182, as a genvar
  // is expected here.
  integer i;

  generate
    for (i = 0; i < 2; i = i + 1) begin : gen_block
      // A simple declaration inside the generate block to ensure it's not empty.
      // This wire is intentionally unused to avoid adding complex logic
      // that might trigger other rules.
      wire unused_local_wire;
    end
  endgenerate

endmodule
