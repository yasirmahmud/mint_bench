module d_type  (
  input d, clk, rst,
  output reg q, qn
);


always @(posedge clk or posedge rst) begin
  if (~rst) begin
    q <= d;
    qn <= ~d;
  end else begin
    q <= 1'b0;
    qn <= 1'b1;
  end
end

endmodule
