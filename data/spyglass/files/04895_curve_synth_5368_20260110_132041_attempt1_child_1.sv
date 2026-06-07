module curve_synth_5368_20260110_132041_attempt1 (
    input wire data_in,
    input wire reset,
    input wire clock,
    output reg q_out
);

  always @(posedge clock or posedge reset) begin
    if (reset) {
      q_out <= 1'b0;
    } else {
      q_out <= data_in;
    }
  end

endmodule
