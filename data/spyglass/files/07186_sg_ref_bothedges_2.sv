module bothedges_ex2(input clk, output reg out);
 always @(posedge clk or negedge clk) begin out <= 1'b0;
 end endmodule
