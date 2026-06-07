module curve_synth_5378_20260111_183704_402252_w37940_attempt6 (
    input clk_in,
    input reset_in,
    input data_in,
    output reg data_out
);

  // SYNTH_5378: Complex expression 'posedge (clk_in | reset_in)' is not allowed in event specification for synthesis
  // This directly triggers the rule by applying 'posedge' to a logical expression instead of a simple signal.
  always @(posedge (clk_in | reset_in)) begin
    if (reset_in) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
