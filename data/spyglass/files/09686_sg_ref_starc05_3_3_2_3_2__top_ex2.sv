module top_ex2 (input sys_clk, input rst_n, input data_in, output data_out);
 wire generated_clk;
 my_bb_pll u_pll (.in_clk(sys_clk), .out_clk(generated_clk));
 reg data_reg;
 always @(posedge generated_clk or negedge rst_n) begin if (!rst_n) data_reg <= 1'b0;
 else data_reg <= data_in;
 end assign data_out = data_reg;
 endmodule
