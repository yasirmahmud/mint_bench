module multibit_clock_ff_2 (
  input [2:0] sys_clk_bus, // Multi-bit input
  input data_in,
  output logic data_out
);

  // A multi-bit wire derived from the input
  wire [2:0] internal_clock_signal = sys_clk_bus;

  always_ff @(posedge internal_clock_signal) begin // Violation: internal_clock_signal is multi-bit
    data_out <= data_in;
  end

endmodule
