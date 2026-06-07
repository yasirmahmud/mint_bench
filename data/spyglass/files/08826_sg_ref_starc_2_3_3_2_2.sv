module star_2_3_3_2_ex2 (input in, input clk, output reg out1, output reg out2);
 always begin @ (posedge clk) out1 <= in;
 @ (negedge clk) out2 <= ~in;
 end endmodule
