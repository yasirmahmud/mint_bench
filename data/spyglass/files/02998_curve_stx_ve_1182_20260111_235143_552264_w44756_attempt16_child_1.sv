module curve_stx_ve_1182_20260111_235143_552264_w44756_attempt16 ();

  // Declare a 'genvar' variable 'gen_loop_counter' as required for generate for-loops.
  // This resolves the STX_VE_1182 violation.
  genvar gen_loop_counter;

  generate
    // This 'for' loop now correctly uses a 'genvar' variable 'gen_loop_counter'.
    for (gen_loop_counter = 0; gen_loop_counter < 3; gen_loop_counter = gen_loop_counter + 1) begin : gen_loop_block
      // Minimal logic inside the generate block to avoid other warnings.
      // Declare and assign a local wire to ensure it is used.
      wire [1:0] local_data_out;
      assign local_data_out = 2'b10;
    end
  endgenerate

endmodule
