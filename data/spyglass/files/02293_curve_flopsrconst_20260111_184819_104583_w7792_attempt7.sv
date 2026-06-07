module curve_flopsrconst_20260111_184819_104583_w7792_attempt7 (
  input clk,
  input d,
  output reg q
);

  // Declare an active-high asynchronous reset signal
  // and tie it to a constant high value.
  // This means the reset pin is always active, causing the flop to be always reset.
  wire rst_const = 1'b1;

  always @(posedge clk or posedge rst_const) begin
    if (rst_const) begin // This condition is always true as rst_const is '1'
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
