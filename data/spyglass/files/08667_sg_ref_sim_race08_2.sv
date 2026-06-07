module sim_race08_ex2 (input wire in1, input wire in2, input wire d, output reg q);
 wire clk;
 assign clk = in1;
 assign clk = in2;
 always @(posedge clk) begin q <= d;
 end endmodule
