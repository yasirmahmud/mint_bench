module W415a_ex1(input clk, output reg out_sig);
 always @(posedge clk) begin out_sig <= 1'b0;
 out_sig <= 1'b1;
 end endmodule
