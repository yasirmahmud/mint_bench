module curve_stx_ve_1182_20260110_065419_attempt3 ();

  // Declare 'idx' as an integer. Using an integer as a loop variable
  // in a generate for-loop is a violation of STX_VE_1182, as a genvar
  // is expected here.
  integer idx;

  generate
    for (idx = 0; idx < 4; idx = idx + 1) begin : gen_block_instance
      // A simple declaration inside the generate block to ensure it's not empty.
      // This wire is intentionally unused to avoid adding complex logic
      // that might trigger other rules.
      wire unused_dummy_wire_inst;
    end
  endgenerate

endmodule
