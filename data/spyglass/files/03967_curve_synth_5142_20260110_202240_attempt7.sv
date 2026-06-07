module curve_synth_5142_20260110_202240_attempt7 (
  input wire clk,
  input wire data_in,
  output reg out_reg
);

  // A simple register to make the module somewhat functional.
  always @(posedge clk) begin
    out_reg <= data_in;
  end

  // This specify block, containing a parallel path delay, will be ignored by synthesis tools.
  // This construct is intended to trigger exactly one SYNTH_5142 violation: "Specify block is ignored for synthesis".
  specify
    (data_in => out_reg) = (10:15:20, 12:18:24);
  endspecify

endmodule
