module AsgnOverflow_ex1();
 reg [0:0] a;
 reg [1:0] b = 2'b11;
 reg [1:0] c = 2'b11;
 assign a = b + c;
 endmodule
