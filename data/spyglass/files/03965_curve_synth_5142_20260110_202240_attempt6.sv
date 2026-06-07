module curve_synth_5142_20260110_202240_attempt6 (
  input wire clk,
  input wire data_in,
  output reg out_reg
);

  // A simple register to make the module somewhat functional
  always @(posedge clk) begin
    out_reg <= data_in;
  end

  // This specify block, containing a timing check, will be ignored by synthesis tools.
  // This triggers the SYNTH_5142 violation.
  specify
    $setup(data_in, posedge clk, 5);
  endspecify

endmodule
