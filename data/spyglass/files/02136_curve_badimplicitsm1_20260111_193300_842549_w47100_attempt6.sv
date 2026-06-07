module curve_badimplicitsm1_20260111_193300_842549_w47100_attempt6 (
  input clk,
  input rst,
  input d,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    if (d) begin
      q <= 1'b1;
    end else if (rst) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
