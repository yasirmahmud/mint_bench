module async_output_port_1 (
  input wire clk,
  input wire reset_n,
  input wire data_in,
  output wire async_out
);
  // Violation: Output port 'async_out' is assigned asynchronously.
  assign async_out = data_in;

endmodule
