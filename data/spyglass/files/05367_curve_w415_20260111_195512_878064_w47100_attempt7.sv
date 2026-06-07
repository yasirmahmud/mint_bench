module curve_w415_20260111_195512_878064_w47100_attempt7 (
  input wire a,
  input wire b,
  output reg out_signal
);

  // First combinational driver for out_signal
  always @(*) begin
    out_signal = a;
  end

  // Second combinational driver for out_signal, active simultaneously
  always @(*) begin
    out_signal = b;
  end

endmodule
