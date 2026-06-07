module STARC_3_5_6_2a_ex1(input clk, output reg out);
 initial begin out = 1'b0;
 end always @(posedge clk) begin out <= ~out;
 end endmodule
