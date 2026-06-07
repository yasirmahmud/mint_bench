module starc05_ex2 (input clk, input in, output reg out);
 initial begin out = 1'b0;
 end always @(posedge clk) begin out <= in;
 end endmodule
