module star_2_8_4_4_ex1 (input [7:0] data, output reg out);
 always @* begin out = 1'b0;
 casex (data) 8'b1X1X1X1X: out = 1'b1;
 default: out = 1'b0;
 endcasex end endmodule
