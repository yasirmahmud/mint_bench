module curve_bothedges_20260111_072157_attempt1 (
  input clk,
  output reg out_q
);

always @(posedge clk or negedge clk) begin
  out_q <= !out_q;
end

endmodule
