// Child module definition: a simple D-flip-flop
// This module defines a clock, data input, and data output.
module d_flop (
  input wire clk, // Clock input
  input wire d,    // Data input
  output reg q     // Data output
);

  always @(posedge clk) begin
    q <= d;
  end

endmodule
