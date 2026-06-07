module w415_ex1 (input clk, input a, input b, output reg out_reg);
 always @(posedge clk) begin out_reg <= a;
 end always @(posedge clk) begin out_reg <= b;
 end endmodule
