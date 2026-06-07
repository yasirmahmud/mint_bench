module unreachable_clk_ex1 (input clk_i, input data_i, output reg q_o);
 always @(posedge data_i) begin q_o <= data_i;
 end endmodule
