module curve_badimplicitsm1_20260111_193300_842549_w47100_attempt8 (
  input clk,
  input rst,
  input en,
  input data_in,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    // Violation: The asynchronous reset (rst) is not checked first.
    // An unrelated condition ('en') is checked before 'rst' in the if-else if chain.
    if (en) begin
      q <= data_in;
    end else if (rst) begin
      q <= 1'b0; // Reset output asynchronously
    end else begin
      q <= 1'b0; // Default state when not enabled and not reset
    end
  end

endmodule
