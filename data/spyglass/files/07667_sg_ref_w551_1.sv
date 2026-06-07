module W551_ex1;
 reg [1:0] sel;
 reg out;
 always @* begin priority case (sel) 2'b00: out = 1'b0;
 2'b01: out = 1'b1;
 default: out = 1'bx;
 endcase end endmodule
