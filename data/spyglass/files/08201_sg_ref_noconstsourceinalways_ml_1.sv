module NoConstSourceInAlways_ex1;
 reg out_reg;
 always @* begin out_reg = 1'b1;
 end endmodule
