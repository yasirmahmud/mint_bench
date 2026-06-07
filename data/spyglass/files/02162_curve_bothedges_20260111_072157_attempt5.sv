module curve_bothedges_20260111_072157_attempt5 (
  input clk,
  output reg out_q
);

always @(posedge clk or negedge clk) begin
  out_q <= 1'b0;
end

endmodule
