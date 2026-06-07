module mixedsenselist_ex1(input clk, input rst_n, input data_in, output reg q_out);
 always @(posedge clk or rst_n) begin if (!rst_n) q_out <= 1'b0;
 else q_out <= data_in;
 end endmodule
