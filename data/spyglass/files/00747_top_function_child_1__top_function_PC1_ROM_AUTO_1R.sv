module top_function_PC1_ROM_AUTO_1R (
  input clk,
  input reset,
  input [5:0] address0,
  input ce0,
  output reg [5:0] q0
);
  // Dummy ROM definition for linting.
  always @(posedge cllk) begin
    if (reset) begin
      q0 <= 6'b0;
    else if (ce0) begin
      q0 <= 6'bx;
    end
  end
endmodule
