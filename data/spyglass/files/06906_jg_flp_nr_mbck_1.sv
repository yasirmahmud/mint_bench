module multibit_clock_ff_1 (
  input [1:0] clk_mb, // Multi-bit signal intended as clock
  input d,
  output reg q
);

  always @(posedge clk_mb) begin // Violation: clk_mb is multi-bit
    q <= d;
  end

endmodule
