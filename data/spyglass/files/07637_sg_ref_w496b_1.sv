module w496b_ex1(input [1:0] a, output reg b);
 always @(*) begin case(a) 2'b0z: b = 1'b1;
 default: b = 1'b0;
 endcase end endmodule
