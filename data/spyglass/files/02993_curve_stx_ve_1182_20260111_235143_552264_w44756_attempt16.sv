module curve_stx_ve_1182_20260111_235143_552264_w44756_attempt16 ();

  // Declare an integer variable 'gen_loop_counter' instead of a 'genvar'.
  // Using 'gen_loop_counter' in a generate for-loop where a 'genvar' is expected
  // will trigger the STX_VE_1182 violation.
  integer gen_loop_counter;

  generate
    // This 'for' loop uses an 'integer' variable 'gen_loop_counter' as its counter.
    // SpyGlass expects a 'genvar' for generate for-loops, leading to STX_VE_1182.
    for (gen_loop_counter = 0; gen_loop_counter < 3; gen_loop_counter = gen_loop_counter + 1) begin : gen_loop_block
      // Minimal logic inside the generate block to avoid other warnings.
      // Declare and assign a local wire to ensure it is used.
      wire [1:0] local_data_out;
      assign local_data_out = 2'b10;
    end
  endgenerate

endmodule
