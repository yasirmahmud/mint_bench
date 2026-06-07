module FlopClockUndriven_ex1(input d, output reg q);
 wire clk;
 always @(posedge clk) q <= d;
 endmodule
