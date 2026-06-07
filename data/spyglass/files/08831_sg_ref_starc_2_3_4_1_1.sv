module starc_2_3_4_1_ex1 (input in, input clk, output reg out);
 initial begin out = 1'b0;
 end always @(posedge clk) out <= in;
 endmodule
