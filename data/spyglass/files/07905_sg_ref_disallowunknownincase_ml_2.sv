module disallow_unknown_in_case_ex2 (input en, input [1:0] a, output reg [3:0] y);
 always @* begin y = 4'b0;
 case ({en, a}) 3'b100: y[a] = 1'b1;
 3'b10x: y[a] = 1'b1;
 3'b110: y[a] = 1'b1;
 3'b111: y[a] = 1'b1;
 endcase end endmodule
