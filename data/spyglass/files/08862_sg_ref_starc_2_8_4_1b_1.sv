module STARC_2_8_4_1b_ex1 (input [3:0] in, output reg [1:0] out);
 always @* begin out = 2'b0;
 casex(in) 4'b1??: out = 2'b1;
 4'b0???: out = 2'b0;
 default: out = 2'b0;
 endcase end endmodule
