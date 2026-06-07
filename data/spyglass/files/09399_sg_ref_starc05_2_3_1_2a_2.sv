module my_module_ex2 (input clk, input d, output reg q);
 always @(posedge clk) begin assign q = d;
 end endmodule
