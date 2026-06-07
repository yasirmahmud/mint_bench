module starc02_2_8_1_6_ex2(input [3:0] sel, output reg out);
 always @* begin case (sel) 4'b0001: out = 1'b0;
 3'b010: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
