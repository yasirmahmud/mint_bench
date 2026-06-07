module curve_wrn_63_20260111_181258_824244_w47100_attempt8 (
  input [7:0] data_in_a,
  input [7:0] data_in_b,
  output [7:0] result_out_a,
  output [7:0] result_out_b
);

  // Default assignments for outputs to ensure they are always driven 
  // and to prevent unused signal warnings, as the conditional generate 
  // blocks below will never be elaborated.
  assign result_out_a = 8'd0;
  assign result_out_b = 8'd0;

  // First division by zero inside a never-taken generate 'if' block.
  // A 'generate if (1'b0)' block will be completely removed during Verilog elaboration.
  // However, static analysis tools like SpyGlass are expected to still parse and 
  // check the code within such blocks for potential design issues, even if it's dead code.
  // This should trigger WRN_63 without causing synthesis errors (SYNTH_5235, ErrorAnalyzeBBox).
  generate
    if (1'b0) begin : gen_block_a // This block's content will never be elaborated into hardware
      assign result_out_a = data_in_a / 8'd0; // Expected WRN_63 here
    end
  endgenerate

  // Second division by zero using a constant expression that evaluates to zero,
  // also within a never-taken generate 'if' block for distinction and to meet the
  // requirement of 2 occurrences of WRN_63.
  generate
    if (1'b0) begin : gen_block_b // This block's content will never be elaborated into hardware
      assign result_out_b = data_in_b / (8'd10 - 8'd10); // Expected WRN_63 here
    end
  endgenerate

endmodule
