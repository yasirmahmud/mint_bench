module curve_stx_ve_1182_20260111_235143_552264_w44756_attempt15 ();

  // Declare a 'genvar' variable for use in generate for-loops.
  // Using 'iteration_idx' as a 'genvar' in a generate for-loop where a 'genvar' is expected
  // will resolve the STX_VE_1182 violation.
  genvar iteration_idx;

  generate
    // This 'for' loop now uses a 'genvar' variable 'iteration_idx' as its counter.
    // SpyGlass expects a 'genvar' for generate for-loops, resolving STX_VE_1182.
    for (iteration_idx = 0; iteration_idx < 5; iteration_idx = iteration_idx + 1) begin : loop_block
      // Minimal logic inside the generate block to avoid other warnings.
      // Declare and assign a local wire to ensure it is used.
      wire [0:0] generated_output_flag;
      assign generated_output_flag = 1'b0;
    end
  endgenerate

endmodule
