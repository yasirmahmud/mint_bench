module curve_synth_5378_20260111_183704_402252_w37940_attempt7 (
    input wire clk_in,
    input wire reset_in,
    input wire data_in,
    output reg data_out
);

  // SYNTH_5378: Complex expression in event specification.
  // This triggers SYNTH_5378 by applying 'posedge' to a complex logical expression (clk_in & reset_in)
  // in the always block's sensitivity list, which is not allowed for synthesis.
  always @(posedge (clk_in & reset_in)) begin
    data_out <= data_in;
  end

endmodule
