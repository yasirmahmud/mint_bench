module curve_starc05_2_3_1_6_20260111_065113_attempt2 (
  input wire clk,
  input wire rst,
  input wire d_in,
  output reg q
);

  always @(posedge clk or negedge rst) begin
    if (rst) begin // STARC05-2.3.1.6 violation: Reset 'rst' is specified as negedge in sensitivity list, but its logic level is checked as active-high (rst).
      q <= 1'b0;
    end else begin
      q <= d_in;
    end
  end

endmodule
