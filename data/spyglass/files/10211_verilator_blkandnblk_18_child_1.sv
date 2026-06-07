module ex18 (input clk);
  reg r;
  always @(posedge clk) begin
    r <= 1'b0;
  end
endmodule
