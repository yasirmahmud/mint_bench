module curve_bothedges_20260111_072157_attempt2 (
  input clk,
  input rst_n, // Asynchronous active-low reset
  output reg out_q
);

always @(posedge clk or negedge clk or negedge rst_n) begin
  if (!rst_n) begin
    out_q <= 1'b0;
  end else begin
    out_q <= !out_q;
  end
end

endmodule
