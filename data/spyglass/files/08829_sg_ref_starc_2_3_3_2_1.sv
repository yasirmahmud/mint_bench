module starc_2_3_3_2_ex1(input in_sig, input clk_sig, output reg out1_reg, output reg out2_reg);
 always begin @(posedge clk_sig) out1_reg <= in_sig;
 @(negedge clk_sig) out2_reg <= ~in_sig;
 end endmodule
