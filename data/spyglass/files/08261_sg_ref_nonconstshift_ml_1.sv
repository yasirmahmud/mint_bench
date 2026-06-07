module NonConstShift_ex1;
 reg [7:0] a;
 reg [2:0] b;
 wire [7:0] c;
 assign c = a << b;
 endmodule
