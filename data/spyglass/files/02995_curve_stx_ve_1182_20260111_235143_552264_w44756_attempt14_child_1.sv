module curve_stx_ve_1182_20260111_235143_552264_w44756_attempt14 ();

  // Declare a 'genvar' variable for use in generate for-loops.
  // This resolves the STX_VE_1182 violation.
  genvar my_loop_var;

  generate
    // This 'for' loop now uses a 'genvar' variable 'my_loop_var' as its counter.
    for (my_loop_var = 0; my_loop_var < 4; my_loop_var = my_loop_var + 1) begin : gen_instance_block
      // Minimal logic inside the generate block to avoid other warnings.
      // Declare and assign a local wire to ensure it is used.
      wire [7:0] generated_wire;
      assign generated_wire = 8'hAA;
    end
  endgenerate

endmodule
