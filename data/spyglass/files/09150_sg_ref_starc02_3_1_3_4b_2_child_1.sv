module my_module_ex2 (input clk, output reg out_reg);
 always @(posedge clk) begin
  out_reg <= clk;
 end
endmodule
