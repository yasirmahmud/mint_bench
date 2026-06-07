module curve_synth_5321_20260110_131525_attempt1 (
  input clk,
  output reg out_q
);

  always @(posedge clk) begin
    // SYNTH_5321: Clocked if-else construct is not synthesizable to standard logic
    // The condition of an 'if' statement inside a clocked always block should not check the clock signal itself.
    if (clk == 1'b1) begin
      out_q <= 1'b1;
    end else begin
      out_q <= 1'b0;
    end
  end

endmodule
