module NoConstSourceInAlways_ex2 (input wire clk, output reg out_reg);
 always @* begin out_reg = 1'b1;
 end endmodule
