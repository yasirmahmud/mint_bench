module ex18;
  reg r;
  always @* begin
    r = 1'b1;
  end
  always @(posedge clk) begin
    r <= 1'b0;
  end
endmodule
