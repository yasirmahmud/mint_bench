module curve_badimplicitsm1_20260111_193300_842549_w47100_attempt10 (
  input clk,
  input rst,
  input data_in,
  input load_en,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    // Violation: The 'load_en' signal is checked before the asynchronous reset 'rst'.
    // According to rule badimplicitSM1, all asynchronous reset/set signals 
    // in the sensitivity list should be checked first in an if-else if chain.
    if (load_en) begin
      q <= data_in;
    end else if (rst) begin
      q <= 1'b0; // Asynchronous reset action
    end else begin
      q <= q; // Synchronous behavior: maintain value if not loading or resetting
    end
  end

endmodule
