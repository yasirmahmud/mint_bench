module my_module_ex2 (input [0:0] sel, output reg out);
 always @* begin case (sel) 2'b10: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
