module curve_synth_89_20260111_154018_077221_w31260_attempt4 (
  input clk,
  input d_in,
  output reg q_out = 1'b1 // This declaration triggers SYNTH_89
);

  // The initial assignment 'q_out = 1'b1' at declaration
  // is ignored by synthesis tools because 'q_out' is subsequently
  // driven by the 'always' block, typically inferring a reset
  // or power-on default based on the technology or specific reset logic.
  always @(posedge clk) begin
    q_out <= d_in; // q_out's value is determined by d_in on the clock edge
  end

endmodule
