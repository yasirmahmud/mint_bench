module w280_ex2(input clk, input rst, input d_in, output reg q_out);
always @(posedge clk or posedge rst) begin if (rst) begin q_out <= 1'b0;
 end else begin q_out <= #1 d_in;
 end end endmodule
