module sim_race08_ex2 (input wire in1, input wire in2, input wire d, output reg q);
 wire clk;
 assign clk = in1; // Resolved multiple driver by selecting in1 as the clock source.
 always @(posedge clk) begin q <= d;
 end
endmodule
