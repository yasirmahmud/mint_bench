module curve_bothedges_20260111_072157_attempt4 (
  input clk,
  input data_in,
  output reg out_q
);

always @(posedge clk or negedge clk) begin
  out_q <= data_in;
end

endmodule
