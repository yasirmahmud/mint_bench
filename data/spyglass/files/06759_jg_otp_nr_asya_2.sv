module async_output_port_2 (
  input wire clk,
  input wire reset_n,
  input wire a,
  input wire b,
  output reg comb_out
);
  // Violation: Output port 'comb_out' is assigned asynchronously.
  always_comb begin
    comb_out = a | b;
  end

endmodule
