module st_2_10_1_5b_ex1(input [1:0] sel, output reg out);
 always @(*) begin case(sel) 2'b0X: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
