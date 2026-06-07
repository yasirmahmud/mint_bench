module my_module_ex2(input clk, output reg q);
always @(posedge clk or posedge clk) begin q <= 1'b0;
 end endmodule
