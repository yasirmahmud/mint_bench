module curve_synth_5321_20260110_131525_attempt5 (
  input clk,
  output reg out_q
);

  always @(posedge clk) begin
    // SYNTH_5321: Clocked if-else construct is not synthesizable to standard logic
    // An 'if' condition that checks the clock signal itself (clk == 1'b1)
    // within a clocked always block is not synthesizable to standard logic.
    if (clk == 1'b1) begin
      out_q <= 1'b1;
    end else begin
      out_q <= 1'b0;
    end
  end

endmodule
