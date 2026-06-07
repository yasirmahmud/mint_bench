module curve_badimplicitsm1_20260111_193300_842549_w47100_attempt9 (
  input clk,
  input rst,
  input enable,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    // Violation: The asynchronous reset 'rst' is not checked first.
    // The 'enable' signal is checked before 'rst' in the if-else if chain.
    if (enable) begin
      q <= 1'b1;
    end else if (rst) begin
      q <= 1'b0; // Asynchronous reset
    end else begin
      q <= 1'b0;
    end
  end

endmodule
