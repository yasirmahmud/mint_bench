module curve_synth_5405_20260111_051450_attempt1 (
  input [1:0] multi_bit_clock, // Multi-bit signal used as a clock
  input [7:0] data_in,
  input reset,
  output reg [7:0] data_out
);

  // This always block uses a multi-bit signal 'multi_bit_clock' as a clock expression,
  // which violates SYNTH_5405 as clock expressions must be one bit wide.
  always @(posedge multi_bit_clock) begin
    if (reset) begin
      data_out <= 8'd0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
