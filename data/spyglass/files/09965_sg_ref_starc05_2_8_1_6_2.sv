module starc05_2_8_1_6_ex2(input [3:0] sel, output reg out);
 always @(sel) begin case (sel) 3'b001: out = 1'b0;
 4'b0100: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
