module curve_stx_ve_1182_20260111_235143_552264_w44756_attempt14 ();

  // Declare an integer variable instead of a 'genvar'.
  // Using 'my_loop_var' in a generate for-loop where a 'genvar' is expected
  // will trigger the STX_VE_1182 violation.
  integer my_loop_var;

  generate
    // This 'for' loop uses an 'integer' variable 'my_loop_var' as its counter.
    // SpyGlass expects a 'genvar' for generate for-loops, leading to STX_VE_1182.
    for (my_loop_var = 0; my_loop_var < 4; my_loop_var = my_loop_var + 1) begin : gen_instance_block
      // Minimal logic inside the generate block to avoid other warnings.
      // Declare and assign a local wire to ensure it is used.
      wire [7:0] generated_wire;
      assign generated_wire = 8'hAA;
    end
  endgenerate

endmodule
