module curve_synth_5378_20260111_183704_402252_w37940_attempt8 (
    input wire clk_in,
    input wire reset_in,
    input wire data_in,
    output reg data_out
);

  // SYNTH_5378: Complex expression 'posedge (clk_in | reset_in)' is not allowed in event specification for synthesis.
  // This module triggers SYNTH_5378 by using a logical OR expression (clk_in | reset_in)
  // directly within the 'posedge' construct of the always block's sensitivity list.
  // The rule description specifically targets this type of complex expression for synthesis violation.
  always @(posedge (clk_in | reset_in)) begin
    data_out <= data_in;
  end

endmodule
