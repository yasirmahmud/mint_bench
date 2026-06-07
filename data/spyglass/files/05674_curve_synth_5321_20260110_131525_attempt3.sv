module curve_synth_5321_20260110_131525_attempt3 (
  input clk,
  output reg out_q
);

  always @(posedge clk) begin
    // SYNTH_5321: Clocked if-else construct is not synthesizable to standard logic
    // The condition of an 'if' statement within a clocked always block should not check the clock signal itself.
    if (clk) begin 
      out_q <= 1'b1;
    end else begin
      out_q <= 1'b0;
    end
  end

endmodule
