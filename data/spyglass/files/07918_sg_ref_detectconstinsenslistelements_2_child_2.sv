module my_module_ex2 (input clk, output reg out_reg);
 reg some_reg = 1'b0; // Fixed: Initialize 'some_reg' to resolve undriven and unset violations.
 always @(posedge clk) begin
  out_reg <= some_reg;
 end
endmodule
