module W450L_ex1 (input [1:0] en, input d, output reg q);
 always @* begin if (en) q = d;
 end endmodule
