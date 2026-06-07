module IncompatibleSVAssign_ex2;
 reg [7:0] a, b;
 initial begin b = 8'd10;
 a = (b++);
 end endmodule
