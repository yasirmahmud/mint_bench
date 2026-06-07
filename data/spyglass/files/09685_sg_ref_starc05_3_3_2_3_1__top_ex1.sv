module top_ex1 (input clk_in, rst_in, data_in, output reg data_out);
 wire bb_clk_out;
 my_bb u_bb (.clk_out(bb_clk_out));
 always @(posedge bb_clk_out or posedge rst_in) begin if (rst_in) data_out <= 1'b0;
 else data_out <= data_in;
 end endmodule
