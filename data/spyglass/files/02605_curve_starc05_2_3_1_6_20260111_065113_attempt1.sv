module curve_starc05_2_3_1_6_20260111_065113_attempt1 (
  input wire clk,
  input wire rst,
  input wire d,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    if (~rst) begin // STARC05-2.3.1.6: Reset 'rst' is specified as posedge in sensitivity list, but its logic level is checked as active-low (~rst).
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
