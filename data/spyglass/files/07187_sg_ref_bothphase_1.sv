module bothphase_ex1 (input clk, input rst, output reg out);
 always @(posedge clk or negedge clk or posedge rst) begin if (rst) out <= 1'b0;
 else out <= ~out;
 end endmodule
