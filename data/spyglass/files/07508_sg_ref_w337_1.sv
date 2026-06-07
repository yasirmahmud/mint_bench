module w337_ex1 (input [1:0] sel, output reg out);
 always @(*) begin case (sel) 2.5: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
