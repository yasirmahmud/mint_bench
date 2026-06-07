module star_ex2(input clk, output reg out);
 always @(posedge clk or 1'b1) out <= 1'b0;
 endmodule
