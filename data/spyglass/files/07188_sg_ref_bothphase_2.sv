module bothphase_ex2(input clk, input rst, output reg q);
 always @(posedge clk or negedge clk or posedge rst) begin if (rst) begin q <= 1'b0;
 end else begin q <= ~q;
 end end endmodule
