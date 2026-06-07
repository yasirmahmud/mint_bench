module W218_ex2 (input clk, input [1:0] data_in, output reg out_reg);
 always @(posedge data_in) begin out_reg <= data_in[0];
 end endmodule
