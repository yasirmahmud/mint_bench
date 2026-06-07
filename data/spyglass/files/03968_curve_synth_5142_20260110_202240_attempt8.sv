module curve_synth_5142_20260110_202240_attempt8 (
  input wire clk,
  input wire reset_n,
  input wire data_in,
  output reg data_out
);

  // A simple D-flip-flop to provide some minimal functionality.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // This specify block, containing only a specparam, is inherently ignored by synthesis tools.
  // This construct is intended to trigger exactly one SYNTH_5142 violation: "Specify block is ignored for synthesis".
  // The use of specparam makes this example distinct from previous attempts which used path delays or timing checks.
  specify
    specparam delay_val = 10.0; // A specify parameter, typically used for simulation delays.
  endspecify

endmodule
