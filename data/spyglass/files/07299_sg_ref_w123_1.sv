module W123_ex1(input clk, output reg out);
 reg my_var;
 always @(posedge clk) begin out <= my_var;
 end endmodule
