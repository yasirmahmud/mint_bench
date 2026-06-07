module my_module_ex2 (input clk, output reg out_reg);
 wire my_wire;
 assign my_wire = clk;
 always @(posedge clk) begin out_reg <= my_wire;
 end endmodule
