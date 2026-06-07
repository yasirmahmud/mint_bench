module ex7(input clk);
  reg g;
  always @(posedge clk) begin
    g = 1'b1; // Blocking in sequential block
    g <= 1'b0;
  end
endmodule
