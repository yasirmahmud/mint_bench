module star_ex2_module (input clk, input d_in, output reg q1, output reg q2);
 always @(posedge clk) q1 <= d_in;
 always @(posedge clk) q2 <= clk;
 endmodule
