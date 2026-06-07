module case_with_dont_care_ex1(input [3:0] sel, output reg out);
 always @(*) begin casez (sel) 4'b1?x?: out = 1;
 4'b0000: out = 0;
 default: out = 0;
 endcase end endmodule
