module curve_synth_5321_20260110_182955_attempt7 (
  input sys_clk,
  output reg sys_out_reg
);

  always @(posedge sys_clk) begin
    // SYNTH_5321 violation: Clocked if-else construct referencing the clock signal is not synthesizable.
    // The always @(posedge sys_clk) implies sys_clk is high during the edge, 
    // making the if (sys_clk == 1'b1) condition redundant and problematic for synthesis.
    if (sys_clk == 1'b1) begin
      sys_out_reg <= 1'b1;
    end else begin
      sys_out_reg <= 1'b0;
    end
  end

endmodule
