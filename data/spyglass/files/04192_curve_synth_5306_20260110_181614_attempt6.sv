module curve_synth_5306_20260110_181614_attempt6 (
  input clk,
  input reset_n,
  input enable_signal,
  output reg data_out
);

  reg internal_reg;

  // This is a named block whose scope is local to this always block.
  always @(posedge clk or negedge reset_n) begin : my_scoped_block
    if (!reset_n) begin
      internal_reg <= 1'b0;
      data_out <= 1'b0;
    end else begin
      internal_reg <= enable_signal;
      data_out <= internal_reg;
    end
  end

  // This always block attempts to disable 'my_scoped_block',
  // which is defined in a different 'always' block and is therefore
  // not within the current scope. This triggers SYNTH_5306.
  always @(posedge clk) begin
    if (enable_signal) begin
      disable my_scoped_block; // SYNTH_5306 violation: Named block is not in scope
    end
  end

endmodule
