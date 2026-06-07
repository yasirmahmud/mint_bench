module W348_ex2;
 reg [7:0] a, b;
 wire [23:0] c;
 assign c = {a, 5, b};
 endmodule
