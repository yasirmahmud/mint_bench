module complex_reset_and (
  input clk,
  input rst0,
  input rst1,
  input d,
  output reg q
);

  always_ff @(posedge clk or negedge (rst0 && rst1)) begin
    if (!(rst0 && rst1)) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
