module disallow_x_in_casez_ex1(input [1:0] sel, output reg out);
 always @(*) begin casez (sel) 2'b0x: out = 1'b0;
 default: out = 1'b1;
 endcase end endmodule
