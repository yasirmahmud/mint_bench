module star_ex1 (input [3:0] data_in, output reg out);
 always @(*) begin casex (data_in) 4'b1X1X: out = 1'b1;
 default: out = 1'b0;
 endcasex end endmodule
