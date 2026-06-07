module my_module_ex2 (input [3:0] in_sig, output reg out_reg);
 always @* begin if (in_sig == 4'b10x1) begin out_reg = 1'b1;
 end else begin out_reg = 1'b0;
 end end endmodule
