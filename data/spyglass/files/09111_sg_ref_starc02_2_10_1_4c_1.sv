module starc02_ex1(input [1:0] in, output reg out);
 always @* begin out = 1'b0;
 case(in) 2'b01: out = 1'b1;
 2'b1X: out = 1'b0;
 default: out = 1'b0;
 endcase end endmodule
