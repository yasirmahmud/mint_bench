module my_module_ex1 (input clk, output reg out);
 always @(posedge clk or posedge clk) begin out <= 1'b0;
 end endmodule
