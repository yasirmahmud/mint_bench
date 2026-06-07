module W263_ex2;
 reg [3:0] sel;
 reg out;
 always @* begin case (sel) 4'b0001: out = 1'b0;
 2'b10: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
