module curve_flopsrconst_20260111_184819_104583_w7792_attempt10 (
  input clk,
  input d,
  output reg q
);

  // Declare an active-low asynchronous reset signal
  // and tie it to a constant low value (its active state).
  // This means the reset pin is always active, causing the flop to be always reset.
  wire rst_n;
  assign rst_n = 1'b0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // This condition is always true as rst_n is '0'
      q <= 1'b0; // Reset value
    end else begin
      q <= d;
    end
  end

endmodule
