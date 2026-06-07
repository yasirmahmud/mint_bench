module ex16(input clk, output reg p);
  always @(posedge clk) begin
    p <= 1'b1; // Changed to non-blocking assignment
  end
  always @(negedge clk) begin
    p <= 1'b0;
  end
endmodule
