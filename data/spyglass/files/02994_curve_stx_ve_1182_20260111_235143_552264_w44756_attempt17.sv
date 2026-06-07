module curve_stx_ve_1182_20260111_235143_552264_w44756_attempt17 ();

  // This module demonstrates STX_VE_1182 by using an 'integer' variable
  // as the loop counter within a generate for-loop, where a 'genvar' is expected.
  
  generate
    // Declare an integer variable 'gen_index_var' within the generate region.
    // This declaration is syntactically valid Verilog-2001 within 'generate' blocks.
    integer gen_index_var;

    // The 'for' loop uses the 'integer' variable 'gen_index_var' as its counter.
    // SpyGlass expects a 'genvar' for generate for-loops, which triggers STX_VE_1182.
    for (gen_index_var = 0; gen_index_var < 2; gen_index_var = gen_index_var + 1) begin : indexed_gen_block
      // Minimal logic inside the generate block to avoid other warnings.
      // Declare and assign a local parameter and a wire to ensure usage.
      parameter LOCAL_WIDTH = 4;
      wire [LOCAL_WIDTH-1:0] output_bus;
      assign output_bus = {LOCAL_WIDTH{1'b1}};
    end
  endgenerate

endmodule
