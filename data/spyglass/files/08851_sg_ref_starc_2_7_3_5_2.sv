module starc_2_7_3_5_ex2 (input clk, output reg out);
wire my_signal;
always @(posedge clk) begin out <= my_signal;
 end endmodule
