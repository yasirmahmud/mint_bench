module multiassign_ex1 (input clk, input a, input b, output reg out);
 always @(posedge clk) begin
  out <= b;
 end
endmodule
