module W71_ex1(input [1:0] sel, output reg out);
 always @(*) begin case(sel) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 endcase end endmodule
