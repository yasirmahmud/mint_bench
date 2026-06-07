module complex_for_ex1 (input [3:0] a, output reg x);
 integer i;
 always @* begin x = 1'b1;
 for (i = 0; i <= 3; i = i + 1) begin x = x & a[i];
 end end endmodule
