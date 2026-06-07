module my_module_ex2 (input clk, output reg out);
 reg data_in_not_set;
 always @(posedge clk) begin out <= data_in_not_set;
 end endmodule
