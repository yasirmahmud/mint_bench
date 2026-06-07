module multiassign_ex2(input clk, input rst, input in1, input in2, output reg out_reg);
always @(posedge clk or posedge rst) begin if (rst) out_reg <= 1'b0;
 else begin out_reg <= in1;
 out_reg <= in2;
 end end endmodule
