module W187_ex1;
 reg [1:0] sel;
 reg [1:0] out;
 always @* begin case (sel) default: out = 2'b00;
 2'b01: out = 2'b01;
 endcase end endmodule
