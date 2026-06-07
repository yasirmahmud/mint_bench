// spyglass disable_block
module curve_notopdufound_20260111_204432_554723_w36056_attempt7 (
  input clk,
  output reg out_signal
);

  initial begin
    out_signal = 1'b0; // Initialize to avoid X-propagation if clk isn't ideal
  end

  always @(posedge clk) begin
    out_signal <= ~out_signal;
  end

endmodule
