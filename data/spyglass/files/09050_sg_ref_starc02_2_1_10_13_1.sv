module STARC02_2_1_10_13_ex1 (input clk, input rst_n, input data_in, output reg out_reg);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) out_reg <= 1'b0;
 else begin out_reg <= #10 data_in;
 out_reg <= #20 ~data_in;
 end end endmodule
